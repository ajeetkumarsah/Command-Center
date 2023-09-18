const {sequelize} = require('../../../databaseConnection/sql_connection');

const cache = require("memory-cache");

function sanitizeInput(input) {
    const sanitizedInput = input.trim();
    if (/^[a-zA-Z0-9\s\W_]+$/.test(sanitizedInput)) {
        return sanitizedInput; // Return the sanitized input if it contains only alphabet and special characters
    } else {
        throw new Error('Invalid input'); // Throw an error for invalid input
    }
}

function copyObject(obj) {
    return JSON.parse(JSON.stringify(obj));
}

function deepEqual(obj1, obj2) {
    // Convert objects to JSON strings and compare them
    const json1 = JSON.stringify(obj1);
    const json2 = JSON.stringify(obj2);

    return json1 === json2;
}

function getPNMList2(current_date, no_of_months){
    let pNm = []
    let current_year = current_date.split('-')[1]
    let current_month = current_date.split('-')[0]
    // current_month = getDigitMonth(current_month)
    let calender_year = `CY${current_year}-${current_month}`
    pNm.push(calender_year)

    for(let i=0; i<no_of_months-1; i++){
        let previous_month = getPreviousMonth(current_month)
        if(current_month === "Jan"){
            current_year = parseInt(current_year) - 1
            current_month = previous_month
            let calender_year = `CY${current_year}-${current_month}`
            pNm.push(calender_year)
        }else {
            current_month = previous_month
            let calender_year = `CY${current_year}-${current_month}`
            pNm.push(calender_year)
        }
    }
    // let pNm_string = pNm.map(item => `'${item}'`).join(", ");
    return pNm
}

function getPreviousMonth(currentMonth) {
    const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    // Get the index of the current month
    const currentMonthIndex = months.indexOf(currentMonth);

    // Subtract 1 from the current month index
    const previousMonthIndex = (currentMonthIndex - 1 + months.length) % months.length;

    // Retrieve the previous month name using the index
    const previousMonth = months[previousMonthIndex];

    return previousMonth;
}

function getPNMList(current_date, no_of_months){
    let pNm = []
    let current_year = current_date.split('-')[1]
    let current_month = current_date.split('-')[0]
    // current_month = getDigitMonth(current_month)
    let calender_year = `CY${current_year}-${current_month}`
    pNm.push(calender_year)

    for(let i=0; i<no_of_months-1; i++){
        let previous_month = getPreviousMonth(current_month)
        if(current_month === "Jan"){
            current_year = parseInt(current_year) - 1
            current_month = previous_month
            let calender_year = `CY${current_year}-${current_month}`
            pNm.push(calender_year)
        }else {
            current_month = previous_month
            let calender_year = `CY${current_year}-${current_month}`
            pNm.push(calender_year)
        }
    }
    let pNm_string = pNm.map(item => `'${item}'`).join(", ");
    return pNm_string
}

function getMatchedValue(arr, key){
    for(let i in arr){
        if(key === arr[i]['filter_key']){
            return arr[i]['fb_per']
        }
    }
    return 0
}

function getMatchedBranchValue(arr, key, branch_name){
    for(let i in arr){
        if(key === arr[i]['filter_key']){
            for(let j in arr[i]['Branch']){
                if(branch_name === arr[i]['Branch'][j]['filter_key']){
                    return arr[i]['Branch'][j]['fb_per']
                }
            }
        }

    }
    return 0
}

function getMatchedChannelValue(arr, key, branch_name, channel_name){

    for(let i in arr){
        if(key === arr[i]['filter_key']){
            for(let j in arr[i]['Branch']){
                if(branch_name === arr[i]['Branch'][j]['filter_key']){
                    for(let k in arr[i]['Branch'][j]['Channel']){
                        if(channel_name === arr[i]['Branch'][j]['Channel'][k]['filter_key']){
                            return arr[i]['Branch'][j]['Channel'][k]['fb_per']
                        }
                    }
                }
            }
        }
    }

    return 0
}

function getMatchedSubChannelValue(arr, key, branch_name, channel_name, subChannel_name){
    for(let i in arr){
        if(key === arr[i]['filter_key']){
            for(let j in arr[i]['Branch']){
                if(branch_name === arr[i]['Branch'][j]['filter_key']){
                    for(let k in arr[i]['Branch'][j]['Channel']){
                        if(channel_name === arr[i]['Branch'][j]['Channel'][k]['filter_key']){
                            for(let l in arr[i]['Branch'][j]['Channel'][k]['SubChannel']){
                                if(subChannel_name === arr[i]['Branch'][j]['Channel'][k]['SubChannel'][l]['filter_key']){
                                    return arr[i]['Branch'][j]['Channel'][k]['SubChannel'][l]['fb_per']
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return 0
}

async function getTableData(bodyData){
    let reqDate = ''
    let all_data = copyObject(bodyData);
    let all_result = []
    for (let i in all_data) {
        let final_result = []
        let final_data = []
        let data = all_data[i]
        let date = data.date;
        reqDate = date
        let filter_key;
        let filter_1 = '';
        let filter_2 = '';
        let filter_data;
        let filter_type = data
        let channel = []
        let channel_list = []
        channel = data.channel
        channel_list = data.channel
        channel = channel.map(item => `'${item}'`).join(", ")
        let all_india_filter = data.allIndia ? data.allIndia : ''
        let division_filter = data.division ? data.division : ''
        let cluster_filter = data.cluster ? data.cluster : ''
        delete filter_type.date;
        delete filter_type.channel;

        if (all_india_filter !== '') {
            delete filter_type.allIndia;
            filter_1 = {
                filter_key: 'all_india',
                filter_data: all_india_filter
            }
        }
        if (division_filter !== '') {
            delete filter_type.division;
            if (division_filter === "South-West") {
                division_filter = "S-W"
            }
            if (division_filter === "North-East") {
                division_filter = "N-E"
            }
            filter_1 = {
                filter_key: 'division',
                filter_data: division_filter
            }
        }
        if (cluster_filter !== '') {
            delete filter_type.cluster;
            filter_1 = {
                filter_key: 'cluster',
                filter_data: cluster_filter
            }
        }

        for (let key in filter_type) {
            filter_key = key
            filter_data = filter_type[key]
        }

        if (filter_key === 'category') {
            filter_key = 'CategoryName'
        }
        if (filter_key === 'brand') {
            filter_key = 'BrandName'
        }
        if (filter_key === 'brandForm') {
            filter_key = 'BFName'
        }
        if (filter_key === 'subBrandGroup') {
            filter_key = 'SBFGroup'
        }

        if (filter_key !== undefined & filter_data !== '') {
            filter_2 = {
                filter_key: filter_key,
                filter_data: filter_data
            }
        }

        let calendar_month_cy = getPNMList(date, 3)
        if (filter_data === "South-West") {
            filter_data = "S-W"
        }
        if (filter_data === "North-East") {
            filter_data = "N-E"
        }

        let mergedArr = []
        let channel_query_fb

        if (filter_2 === '') {
            if (channel.length === 0) {
                if (filter_1['filter_data'] === 'allIndia') {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum ,[Calendar Month], Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in (${calendar_month_cy}) and Division in ('N-E', 'S-W')  group by [FB Type], [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                } else {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in (${calendar_month_cy}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' group by [FB Type], [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                }
            } else {
                if (filter_1['filter_data'] === 'allIndia') {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum ,[Calendar Month], Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in (${calendar_month_cy}) and Division in ('N-E', 'S-W') and [ChannelName] in (${channel})  group by [FB Type], [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                } else {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in (${calendar_month_cy}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [ChannelName] in (${channel}) group by [FB Type], [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                }
            }

        } else {
            if (channel.length === 0) {
                if (filter_1['filter_data'] === 'allIndia') {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in (${calendar_month_cy}) and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' group by [FB Type], [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                } else {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in (${calendar_month_cy}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' group by [FB Type], [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                }
            } else {
                if (filter_1['filter_data'] === 'allIndia') {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in (${calendar_month_cy}) and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [ChannelName] in (${channel}) group by [FB Type], [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                } else {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in (${calendar_month_cy}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [ChannelName] in (${channel}) group by [FB Type], [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                }
            }

        }
        // console.time("Data Fetching")

        let categories_data_fb = await sequelize.query(channel_query_fb)
        // console.timeEnd("Data Fetching")

        mergedArr = categories_data_fb[0]
        if (mergedArr.length <= 0) {
            res.status(400).send({successful: false, message: "DB do not have data for this filter"})
            return 0
        }
        let P3M = getPNMList2(date, 3)
        for (let i in P3M) {
            let current_month = P3M[i]

            let DivisionObj = {}
            for (let i in mergedArr) {
                if (current_month === mergedArr[i]['Calendar Month']) {
                    let fb_target_base = 0
                    if (mergedArr[i]['FB Type'] === 'Base') {
                        fb_target_base = mergedArr[i]['fb_target_sum']
                    }
                    let obj = {}
                    let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                    let Division = sanitizeInput(mergedArr[i]['Division'])
                    let key = `${Month}/${Division}`
                    if (mergedArr[i]['fb_achieve_sum'] == null) {
                        mergedArr[i]['fb_achieve_sum'] = 0
                    }
                    if (mergedArr[i]['fb_target_sum'] == null) {
                        mergedArr[i]['fb_target_sum'] = 0
                    }
                    if (key in DivisionObj) {
                        DivisionObj[`${key}`]['fb_achieve_sum'] = parseFloat((DivisionObj[`${key}`]['fb_achieve_sum'] + mergedArr[i]['fb_achieve_sum']).toFixed(2))
                        DivisionObj[`${key}`]['fb_target_sum'] = parseFloat((DivisionObj[`${key}`]['fb_target_sum'] + mergedArr[i]['fb_target_sum']).toFixed(2))
                        DivisionObj[`${key}`]['fb_target_base_sum'] = parseFloat((DivisionObj[`${key}`]['fb_target_base_sum'] + fb_target_base).toFixed(2))
                        if (mergedArr[i]['fb_target_sum'] === 0) {
                            mergedArr[i]['fb_target_sum'] = 1
                        }
                        // DivisionObj[`${key}`]['fb_per'] = parseFloat(((DivisionObj[`${key}`]['fb_per'] + (((mergedArr[i]['fb_achieve_sum'])/(mergedArr[i]['fb_target_sum'])) * 100))/2).toFixed(2))
                        DivisionObj[`${key}`]['fb_per'] = parseFloat(((DivisionObj[`${key}`]['fb_achieve_sum'] / DivisionObj[`${key}`]['fb_target_base_sum']) * 100).toFixed(2))
                    } else {
                        obj = {
                            'filter_key': mergedArr[i]['Division'],
                            'fb_achieve_sum': parseFloat((mergedArr[i]['fb_achieve_sum']).toFixed(2)),
                            'fb_target_sum': parseFloat((mergedArr[i]['fb_target_sum']).toFixed(2)),
                            'fb_target_base_sum': fb_target_base,
                            'Site': []
                        }
                        if (fb_target_base === 0) {
                            fb_target_base = 1
                        }
                        obj['fb_per'] = parseFloat((((mergedArr[i]['fb_achieve_sum']) / (fb_target_base)) * 100).toFixed(2)),
                            DivisionObj[key] = obj
                    }
                }
            }

            let SiteObj = {}
            for (let i in mergedArr) {
                if (current_month === mergedArr[i]['Calendar Month']) {
                    let fb_target_base = 0
                    if (mergedArr[i]['FB Type'] === 'Base') {
                        fb_target_base = mergedArr[i]['fb_target_sum']
                    }
                    let obj = {}
                    let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                    let Division = sanitizeInput(mergedArr[i]['Division'])
                    let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                    let key = `${Month}/${Division}/${Site_Name}`
                    if (mergedArr[i]['fb_achieve_sum'] == null) {
                        mergedArr[i]['fb_achieve_sum'] = 0
                    }
                    if (mergedArr[i]['fb_target_sum'] == null) {
                        mergedArr[i]['fb_target_sum'] = 0
                    }
                    if (key in SiteObj) {
                        SiteObj[`${key}`]['fb_achieve_sum'] = parseFloat((SiteObj[`${key}`]['fb_achieve_sum'] + mergedArr[i]['fb_achieve_sum']).toFixed(2))
                        SiteObj[`${key}`]['fb_target_sum'] = parseFloat((SiteObj[`${key}`]['fb_target_sum'] + mergedArr[i]['fb_target_sum']).toFixed(2))
                        SiteObj[`${key}`]['fb_target_base_sum'] = parseFloat((SiteObj[`${key}`]['fb_target_base_sum'] + fb_target_base).toFixed(2))
                        if (mergedArr[i]['fb_target_sum'] === 0) {
                            mergedArr[i]['fb_target_sum'] = 1
                        }
                        // SiteObj[`${key}`]['fb_per'] = parseFloat(((SiteObj[`${key}`]['fb_per'] + (((mergedArr[i]['fb_achieve_sum'])/(mergedArr[i]['fb_target_sum'])) * 100))/2).toFixed(2))
                        SiteObj[`${key}`]['fb_per'] = parseFloat(((((SiteObj[`${key}`]['fb_achieve_sum']) / (SiteObj[`${key}`]['fb_target_base_sum']) * 100))).toFixed(2))
                    } else {
                        obj = {
                            'filter_key': mergedArr[i]['Site Name'],
                            'fb_achieve_sum': parseFloat((mergedArr[i]['fb_achieve_sum']).toFixed(2)),
                            'fb_target_sum': parseFloat((mergedArr[i]['fb_target_sum']).toFixed(2)),
                            'fb_target_base_sum': parseFloat((fb_target_base).toFixed(2)),
                            'Branch': []
                        }
                        if (fb_target_base === 0) {
                            fb_target_base = 1
                        }
                        obj['fb_per'] = parseFloat((((mergedArr[i]['fb_achieve_sum']) / (fb_target_base)) * 100).toFixed(2)),
                            SiteObj[key] = obj
                    }
                }
            }

            let BranchObj = {}
            for (let i in mergedArr) {
                if (current_month === mergedArr[i]['Calendar Month']) {
                    let fb_target_base = 0
                    if (mergedArr[i]['FB Type'] === 'Base') {
                        fb_target_base = mergedArr[i]['fb_target_sum']
                    }
                    let obj = {}
                    let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                    let Division = sanitizeInput(mergedArr[i]['Division'])
                    let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                    let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                    let key = `${Month}/${Division}/${Site_Name}/${Branch_Name}`
                    if (mergedArr[i]['fb_achieve_sum'] == null) {
                        mergedArr[i]['fb_achieve_sum'] = 0
                    }
                    if (mergedArr[i]['fb_target_sum'] == null) {
                        mergedArr[i]['fb_target_sum'] = 0
                    }
                    if (key in BranchObj) {
                        BranchObj[`${key}`]['fb_achieve_sum'] = parseFloat((BranchObj[`${key}`]['fb_achieve_sum'] + mergedArr[i]['fb_achieve_sum']).toFixed(2))
                        BranchObj[`${key}`]['fb_target_sum'] = parseFloat((BranchObj[`${key}`]['fb_target_sum'] + mergedArr[i]['fb_target_sum']).toFixed(2))
                        BranchObj[`${key}`]['fb_target_base_sum'] = parseFloat((BranchObj[`${key}`]['fb_target_base_sum'] + fb_target_base).toFixed(2))
                        if (mergedArr[i]['fb_target_sum'] === 0) {
                            mergedArr[i]['fb_target_sum'] = 1
                        }
                        BranchObj[`${key}`]['fb_per'] = parseFloat(((((BranchObj[`${key}`]['fb_achieve_sum']) / (BranchObj[`${key}`]['fb_target_base_sum']) * 100))).toFixed(2))
                    } else {
                        obj = {
                            'filter_key': mergedArr[i]['Branch Name'],
                            'fb_achieve_sum': parseFloat((mergedArr[i]['fb_achieve_sum']).toFixed(2)),
                            'fb_target_sum': parseFloat((mergedArr[i]['fb_target_sum']).toFixed(2)),
                            'fb_target_base_sum': fb_target_base,
                            'Channel': []
                        }
                        if (fb_target_base === 0) {
                            fb_target_base = 1
                        }
                        obj['fb_per'] = parseFloat((((mergedArr[i]['fb_achieve_sum']) / (fb_target_base)) * 100).toFixed(2)),
                            BranchObj[key] = obj

                    }
                }
            }

            let ChannelObj = {}
            for (let i in mergedArr) {
                if (current_month === mergedArr[i]['Calendar Month']) {
                    let fb_target_base = 0
                    if (mergedArr[i]['FB Type'] === 'Base') {
                        fb_target_base = mergedArr[i]['fb_target_sum']
                    }
                    let obj = {}
                    let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                    let Division = sanitizeInput(mergedArr[i]['Division'])
                    let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                    let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                    let ChannelName = sanitizeInput(mergedArr[i]['ChannelName'])
                    let key = `${Month}/${Division}/${Site_Name}/${Branch_Name}/${ChannelName}`
                    if (mergedArr[i]['fb_achieve_sum'] == null) {
                        mergedArr[i]['fb_achieve_sum'] = 0
                    }
                    if (mergedArr[i]['fb_target_sum'] == null) {
                        mergedArr[i]['fb_target_sum'] = 0
                    }
                    if (key in ChannelObj) {
                        ChannelObj[`${key}`]['fb_achieve_sum'] = parseFloat((ChannelObj[`${key}`]['fb_achieve_sum'] + mergedArr[i]['fb_achieve_sum']).toFixed(2))
                        ChannelObj[`${key}`]['fb_target_sum'] = parseFloat((ChannelObj[`${key}`]['fb_target_sum'] + mergedArr[i]['fb_target_sum']).toFixed(2))
                        ChannelObj[`${key}`]['fb_target_base_sum'] = parseFloat((ChannelObj[`${key}`]['fb_target_base_sum'] + fb_target_base).toFixed(2))
                        if (mergedArr[i]['fb_target_sum'] === 0) {
                            mergedArr[i]['fb_target_sum'] = 1
                        }
                        ChannelObj[`${key}`]['fb_per'] = parseFloat(((((ChannelObj[`${key}`]['fb_achieve_sum']) / (ChannelObj[`${key}`]['fb_target_base_sum']) * 100))).toFixed(2))
                    } else {
                        obj = {
                            'filter_key': mergedArr[i]['ChannelName'],
                            'fb_achieve_sum': parseFloat((mergedArr[i]['fb_achieve_sum']).toFixed(2)),
                            'fb_target_sum': parseFloat((mergedArr[i]['fb_target_sum']).toFixed(2)),
                            'fb_target_base_sum': parseFloat((fb_target_base).toFixed(2)),
                            'SubChannel': []
                        }
                        if (fb_target_base === 0) {
                            fb_target_base = 1
                        }
                        obj['fb_per'] = parseFloat((((mergedArr[i]['fb_achieve_sum']) / (fb_target_base)) * 100).toFixed(2)),
                            ChannelObj[key] = obj
                    }
                }
            }

            let subChannelObj = {}
            for (let i in mergedArr) {
                if (current_month === mergedArr[i]['Calendar Month']) {
                    let fb_target_base = 0
                    if (mergedArr[i]['FB Type'] === 'Base') {
                        fb_target_base = mergedArr[i]['fb_target_sum']
                    }
                    let obj = {}
                    let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                    let Division = sanitizeInput(mergedArr[i]['Division'])
                    let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                    let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                    let ChannelName = sanitizeInput(mergedArr[i]['ChannelName'])
                    let SubChannelName = sanitizeInput(mergedArr[i]['SubChannelName'])
                    let key = `${Month}/${Division}/${Site_Name}/${Branch_Name}/${ChannelName}/${SubChannelName}`
                    if (mergedArr[i]['fb_achieve_sum'] == null) {
                        mergedArr[i]['fb_achieve_sum'] = 0
                    }
                    if (mergedArr[i]['fb_target_sum'] == null) {
                        mergedArr[i]['fb_target_sum'] = 0
                    }
                    if (key in subChannelObj) {
                        subChannelObj[`${key}`]['fb_achieve_sum'] = parseFloat((subChannelObj[`${key}`]['fb_achieve_sum'] + mergedArr[i]['fb_achieve_sum']).toFixed(2))
                        subChannelObj[`${key}`]['fb_target_sum'] = parseFloat((subChannelObj[`${key}`]['fb_target_sum'] + mergedArr[i]['fb_target_sum']).toFixed(2))
                        subChannelObj[`${key}`]['fb_target_base_sum'] = parseFloat((subChannelObj[`${key}`]['fb_target_base_sum'] + fb_target_base).toFixed(2))
                        if (mergedArr[i]['fb_target_sum'] === 0) {
                            mergedArr[i]['fb_target_sum'] = 1
                        }
                        subChannelObj[`${key}`]['fb_per'] = parseFloat(((((subChannelObj[`${key}`]['fb_achieve_sum']) / (subChannelObj[`${key}`]['fb_target_base_sum']) * 100))).toFixed(2))
                    } else {
                        obj = {
                            'filter_key': mergedArr[i]['SubChannelName'],
                            'fb_achieve_sum': parseFloat((mergedArr[i]['fb_achieve_sum']).toFixed(2)),
                            'fb_target_base_sum': parseFloat((fb_target_base).toFixed(2)),
                            'fb_target_sum': parseFloat((mergedArr[i]['fb_target_sum']).toFixed(2)),
                        }
                        if (fb_target_base === 0) {
                            fb_target_base = 1
                        }
                        obj['fb_per'] = parseFloat((((mergedArr[i]['fb_achieve_sum']) / (fb_target_base)) * 100).toFixed(2)),
                            subChannelObj[key] = obj
                    }
                }
            }

            for (let i in subChannelObj) {
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                ChannelObj[key]['SubChannel'].push(subChannelObj[i])
            }

            for (let i in ChannelObj) {
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                BranchObj[key]['Channel'].push(ChannelObj[i])
            }

            for (let i in BranchObj) {
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                SiteObj[key]['Branch'].push(BranchObj[i])
            }

            for (let i in SiteObj) {
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                DivisionObj[key]['Site'].push(SiteObj[i])
            }

            let sql_query_no_of_fb_current_year

            if (filter_2 === '') {
                if (channel.length === 0) {
                    if (filter_1['filter_data'] === 'allIndia') {
                        sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${current_month}' and Division in ('N-E', 'S-W')`
                    } else {
                        sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${current_month}' and [${filter_1['filter_key']}] = '${filter_1['filter_data']}'`
                    }
                } else {
                    if (filter_1['filter_data'] === 'allIndia') {
                        sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${current_month}' and Division in ('N-E', 'S-W') and [ChannelName] in (${channel})`
                    } else {
                        sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${current_month}' and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [ChannelName] in (${channel})`
                    }
                }

            } else {
                if (channel.length === 0) {
                    if (filter_1['filter_data'] === 'allIndia') {
                        sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${current_month}' and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' `
                    } else {
                        sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${current_month}' and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' `
                    }
                } else {
                    if (filter_1['filter_data'] === 'allIndia') {
                        sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${current_month}' and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [ChannelName] in (${channel})`
                    } else {
                        sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${current_month}' and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [ChannelName] in (${channel})`
                    }
                }

            }

            let fb_data = await sequelize.query(sql_query_no_of_fb_current_year)
            let fb_call = 0
            let fb_target = 1
            let fb_target_base = 1
            let coverage = 1

            for (let i in DivisionObj) {
                fb_target_base = parseFloat((fb_target_base + DivisionObj[i]['fb_target_base_sum']).toFixed(2))
            }

            if (fb_data[0][0] !== undefined) {
                if (fb_data[0][0]['fb_achieve_sum'] !== null && fb_data[0][0]['fb_target_sum'] !== null) {
                    fb_call = parseFloat((fb_data[0][0]['fb_achieve_sum']).toFixed(2))
                    fb_target = parseFloat((fb_data[0][0]['fb_target_sum']).toFixed(2))
                }
            }

            if (fb_call === null) {
                fb_call = 0
            }
            if (fb_target === null) {
                fb_target = 1
            }
            if (coverage === 0) {
                coverage = 1
            }
            let fb_per = (fb_call / fb_target_base) * 100
            if (coverage === 1) {
                coverage = 0
            }

            let objData = {
                "fb_per": parseInt(fb_per.toFixed(2).split(".")[0])
            }
            let divList = []
            for (let i in DivisionObj) {
                divList.push(DivisionObj[i])
            }
            if (filter_data === 'allIndia') {
                filter_data = 'All India'
            }
            objData['filter_key'] = `${filter_1['filter_data']}`
            objData['filter_key2'] = `${filter_2['filter_data'] ? filter_2['filter_data'] : ''}`
            objData['channel'] = channel_list.map(item => item).join("/")
            objData['month'] = `${calendar_month_cy}`
            objData['fb_achieve_sum'] = parseFloat(`${fb_call}`)
            objData['fb_target_sum'] = parseFloat(`${fb_target}`)
            objData['fb_target_base_sum'] = parseFloat(`${fb_target_base}`)
            objData["division"] = divList
            final_data.push(objData)
            if (filter_data === 'All India') {
                filter_data = 'allIndia'
            }
        }
        final_result.push(final_data)

        let allMonths = getPNMList2(reqDate, 3)
        let mergeObjAllIndia = {}
        mergeObjAllIndia['filter_key'] = `${filter_1['filter_data']}`
        mergeObjAllIndia['filter_key2'] = `${filter_2['filter_data'] ? filter_2['filter_data'] : ''}`
        mergeObjAllIndia['channel'] = channel_list.map(item => item).join("/")
        mergeObjAllIndia['month1'] = allMonths[0]
        mergeObjAllIndia['month2'] = allMonths[1]
        mergeObjAllIndia['month3'] = allMonths[2]
        mergeObjAllIndia['fb_per1'] = final_result[0][0]['fb_per']
        mergeObjAllIndia['fb_per2'] = final_result[0][1]['fb_per']
        mergeObjAllIndia['fb_per3'] = final_result[0][2]['fb_per']
        mergeObjAllIndia['division'] = []

        let mergeObjAllDivision = {}

        for (let i in final_result[0][0]['division']) {
            let div_key = final_result[0][0]['division'][i]['filter_key']
            if (!(div_key in mergeObjAllDivision)) {
                mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`] = {
                    'filter_key': final_result[0][0]['division'][i]['filter_key'],
                    'fb_per1': final_result[0][0]['division'][i] ? final_result[0][0]['division'][i]['fb_per'] : 0,
                    'fb_per2': final_result[0][1]['division'][i] ? final_result[0][1]['division'][i]['fb_per'] : 0,
                    'fb_per3': final_result[0][2]['division'][i] ? final_result[0][2]['division'][i]['fb_per'] : 0,
                    'site': []
                }
            }

            for (let j in final_result[0][0]['division'][i]['Site']) {
                let mergeObjSite = {}
                let site_key = final_result[0][0]['division'][i]['Site'][j]['filter_key']
                let fb_per1 = final_result[0][0]['division'][i] ? getMatchedValue(final_result[0][0]['division'][i]['Site'], site_key) : 0
                let fb_per2 = final_result[0][1]['division'][i] ? getMatchedValue(final_result[0][1]['division'][i]['Site'], site_key) : 0
                let fb_per3 = final_result[0][2]['division'][i] ? getMatchedValue(final_result[0][2]['division'][i]['Site'], site_key) : 0
                mergeObjSite = {
                    'filter_key': site_key,
                    'fb_per1': fb_per1,
                    'fb_per2': fb_per2,
                    'fb_per3': fb_per3,
                    'branch': []
                }
                mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`]['site'].push(mergeObjSite)

                for (let k in final_result[0][0]['division'][i]['Site'][j]['Branch']) {
                    let mergeObjBranch = {}
                    let branch_key = final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['filter_key']
                    let fb_per1 = final_result[0][0]['division'][i] ? getMatchedBranchValue(final_result[0][0]['division'][i]['Site'], site_key, branch_key) : 0
                    let fb_per2 = final_result[0][1]['division'][i] ? getMatchedBranchValue(final_result[0][1]['division'][i]['Site'], site_key, branch_key) : 0
                    let fb_per3 = final_result[0][2]['division'][i] ? getMatchedBranchValue(final_result[0][2]['division'][i]['Site'], site_key, branch_key) : 0
                    mergeObjBranch = {
                        'filter_key': branch_key,
                        'fb_per1': fb_per1,
                        'fb_per2': fb_per2,
                        'fb_per3': fb_per3,
                        'channel': []
                    }
                    mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`]['site'][j]['branch'].push(mergeObjBranch)

                    for (let l in final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel']) {
                        let mergeObjChannel = {}
                        let channel_key = final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel'][l]['filter_key']
                        let fb_per1 = final_result[0][0]['division'][i] ? getMatchedChannelValue(final_result[0][0]['division'][i]['Site'], site_key, branch_key, channel_key) : 0
                        let fb_per2 = final_result[0][1]['division'][i] ? getMatchedChannelValue(final_result[0][1]['division'][i]['Site'], site_key, branch_key, channel_key) : 0
                        let fb_per3 = final_result[0][2]['division'][i] ? getMatchedChannelValue(final_result[0][2]['division'][i]['Site'], site_key, branch_key, channel_key) : 0
                        mergeObjChannel = {
                            'filter_key': channel_key,
                            'fb_per1': fb_per1,
                            'fb_per2': fb_per2,
                            'fb_per3': fb_per3,
                            'subChannel': []
                        }
                        mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`]['site'][j]['branch'][k]['channel'].push(mergeObjChannel)

                        for (let m in final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel'][l]['SubChannel']) {
                            let mergeObjSubChannel = {}
                            let sub_channel_key = final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel'][l]['SubChannel'][m]['filter_key']
                            let fb_per1 = final_result[0][0]['division'][i] ? getMatchedSubChannelValue(final_result[0][0]['division'][i]['Site'], site_key, branch_key, channel_key, sub_channel_key) : 0
                            let fb_per2 = final_result[0][1]['division'][i] ? getMatchedSubChannelValue(final_result[0][1]['division'][i]['Site'], site_key, branch_key, channel_key, sub_channel_key) : 0
                            let fb_per3 = final_result[0][2]['division'][i] ? getMatchedSubChannelValue(final_result[0][2]['division'][i]['Site'], site_key, branch_key, channel_key, sub_channel_key) : 0
                            mergeObjSubChannel = {
                                'filter_key': sub_channel_key,
                                'fb_per1': fb_per1,
                                'fb_per2': fb_per2,
                                'fb_per3': fb_per3
                            }
                            mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`]['site'][j]['branch'][k]['channel'][l]['subChannel'].push(mergeObjSubChannel)
                        }
                    }
                }
            }
        }

        for (let i in mergeObjAllDivision) {
            mergeObjAllIndia['division'].push(mergeObjAllDivision[i])
        }
        all_result.push([mergeObjAllIndia])
    }
    return all_result;
}

let getDeepDivePageData = async (req, res) =>{

    try {
        let time_to_live = 7*24*60*60*1000 // Time in milliseconds for 7 days
        let cacheKey = 'fbMonthlyDeepDiveData'
        let final_result = []
        if(cache.get(cacheKey)){
            let cacheData = cache.get(cacheKey)
            let nonMatchedIndex = []
            let matchedDataList = []
            for(let k in cacheData){
                let cachebodyData = cacheData[k]['reqBody']
                let curReq = req.body
                if (Array.isArray(curReq)){
                    for(let i=0; i<curReq.length; i++){
                        let matched = false
                        for(let n = 0; n<cachebodyData.length; n++){
                            if (deepEqual(cachebodyData[n], curReq[i])) {
                                if((cachebodyData[n]['channel'].map(item => `'${item}'`).join(", ")) === (curReq[i]['channel'].map(item => `'${item}'`).join(", "))){
                                    matchedDataList.push(cacheData[k]['resData'][n])
                                    matched = true
                                    console.log("Data fetched from cache")
                                }
                            }
                        }
                        if(!matched){
                            nonMatchedIndex.push(curReq[i])
                        }
                    }
                }
                else{
                    console.log("No data in Cache")
                }
            }

            let finalData = await getTableData(nonMatchedIndex)
            for(let i in nonMatchedIndex){
                if(finalData.length>0){
                    matchedDataList.push(finalData[i])
                    cacheData[0]['reqBody'].push(nonMatchedIndex[i])
                    cacheData[0]['resData'].push(finalData[i])
                    console.log("Putting data into cache")
                }else{
                    console.log("There is no data for this query");
                }
            }
            res.status(200).json(matchedDataList);
        }else {
            final_result = await getTableData(req.body)
            if(final_result.length>0){
                let obj ={
                    'reqBody': req.body,
                    'resData': final_result
                }
                cache.put(cacheKey, [obj], time_to_live);
                console.log("Putting data into cache");
            }else{
                console.log("There is no data for this query");
            }
            res.status(200).json(final_result);
        }

    } catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

module.exports = {
    getDeepDivePageData
}

