const {sequelize} = require('../../../databaseConnection/sql_connection');

const cache = require("memory-cache");

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
            return arr[i]['cc_per']
        }
    }
    return 0
}

function getMatchedBranchValue(arr, key, branch_name){
    for(let i in arr){
        if(key === arr[i]['filter_key']){
            for(let j in arr[i]['Branch']){
                if(branch_name === arr[i]['Branch'][j]['filter_key']){
                    return arr[i]['Branch'][j]['cc_per']
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
                            return arr[i]['Branch'][j]['Channel'][k]['cc_per']
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
                                    return arr[i]['Branch'][j]['Channel'][k]['SubChannel'][l]['cc_per']
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

async function getTableData (bodyData){

    try {
        let reqDate = ''
        let all_data = copyObject(bodyData);
        let all_result = []
        for(let i in all_data) {
            let final_result = []
            let final_data = []
            let data = all_data[i]
            let date = data.date;
            reqDate = date
            let filter_key;
            let filter_data;
            let filter_type = data
            let channel = []
            let channel_list = []
            channel = data.channel
            channel_list = data.channel
            channel = channel.map(item => `'${item}'`).join(", ")
            delete filter_type.date;
            delete filter_type.channel;
            for (let key in filter_type) {
                filter_key = key
                filter_data = filter_type[key]
            }

            if (filter_key === "allIndia") {
                filter_key = "Division"
                filter_data = "allIndia"
            }

            let calendar_month_cy = getPNMList(date, 3)
            if (filter_data === "South-West") {
                filter_data = "S-W"
            }
            if (filter_data === "North-East") {
                filter_data = "N-E"
            }

            let mergedArr = []
            let channel_query_cc

            if (channel.length === 0) {
                if (filter_data === 'allIndia') {
                    channel_query_cc = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum ,[Calendar Month], Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_cc_new] where [Calendar Month] in (${calendar_month_cy}) and Division in ('N-E', 'S-W')  group by [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                } else {
                    channel_query_cc = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_cc_new] where [Calendar Month] in (${calendar_month_cy}) and [${filter_key}] = '${filter_data}' group by [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                }
            } else {
                if (filter_data === 'allIndia') {
                    channel_query_cc = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_cc_new] where [Calendar Month] in (${calendar_month_cy}) and Division in ('N-E', 'S-W') and [ChannelName] in (${channel}) group by [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                } else {

                    channel_query_cc = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_cc_new] where [Calendar Month] in (${calendar_month_cy}) and [${filter_key}] = '${filter_data}'  and [ChannelName] in (${channel}) group by [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                }
            }
            // console.time("Data Fetching")

            let categories_data_cc = await sequelize.query(channel_query_cc)
            // console.timeEnd("Data Fetching")
            mergedArr = categories_data_cc[0]

            let P3M = getPNMList2(date, 3)
            for (let i in P3M) {
                let current_month = P3M[i]
                {
                    let DivisionObj = {}
                    for (let i in mergedArr) {
                        if (current_month === mergedArr[i]['Calendar Month']) {
                            let obj = {}
                            let key = `${mergedArr[i]['Calendar Month']}/${mergedArr[i]['Division']}`
                            if (mergedArr[i]['calls_made_sum'] == null) {
                                mergedArr[i]['calls_made_sum'] = 0
                            }
                            if (mergedArr[i]['target_calls_sum'] == null) {
                                mergedArr[i]['target_calls_sum'] = 0
                            }
                            if (key in DivisionObj) {
                                DivisionObj[`${key}`]['calls_made_sum'] += mergedArr[i]['calls_made_sum']
                                DivisionObj[`${key}`]['target_calls_sum'] += mergedArr[i]['target_calls_sum']
                                if (mergedArr[i]['target_calls_sum'] === 0) {
                                    mergedArr[i]['target_calls_sum'] = 1
                                }
                                // DivisionObj[`${key}`]['cc_per'] = parseFloat(((DivisionObj[`${key}`]['cc_per'] + (((mergedArr[i]['calls_made_sum'])/(mergedArr[i]['target_calls_sum'])) * 100))/2).toFixed(2))
                                DivisionObj[`${key}`]['cc_per'] = parseFloat(((DivisionObj[`${key}`]['calls_made_sum'] / DivisionObj[`${key}`]['target_calls_sum']) * 100).toFixed(2))
                            } else {
                                obj = {
                                    'filter_key': mergedArr[i]['Division'],
                                    'calls_made_sum': mergedArr[i]['calls_made_sum'],
                                    'target_calls_sum': mergedArr[i]['target_calls_sum'],
                                    'Site': []
                                }
                                if (mergedArr[i]['target_calls_sum'] === 0) {
                                    mergedArr[i]['target_calls_sum'] = 1
                                }
                                obj['cc_per'] = parseFloat((((mergedArr[i]['calls_made_sum']) / (mergedArr[i]['target_calls_sum'])) * 100).toFixed(2)),
                                    DivisionObj[key] = obj
                            }
                        }

                    }

                    let SiteObj = {}
                    for (let i in mergedArr) {
                        if (current_month === mergedArr[i]['Calendar Month']) {
                            let obj = {}
                            let key = `${mergedArr[i]['Calendar Month']}/${mergedArr[i]['Division']}/${mergedArr[i]['Site Name']}`
                            if (mergedArr[i]['calls_made_sum'] == null) {
                                mergedArr[i]['calls_made_sum'] = 0
                            }
                            if (mergedArr[i]['target_calls_sum'] == null) {
                                mergedArr[i]['target_calls_sum'] = 0
                            }
                            if (key in SiteObj) {
                                SiteObj[`${key}`]['calls_made_sum'] += mergedArr[i]['calls_made_sum']
                                SiteObj[`${key}`]['target_calls_sum'] += mergedArr[i]['target_calls_sum']
                                if (mergedArr[i]['target_calls_sum'] === 0) {
                                    mergedArr[i]['target_calls_sum'] = 1
                                }
                                // SiteObj[`${key}`]['cc_per'] = parseFloat(((SiteObj[`${key}`]['cc_per'] + (((mergedArr[i]['calls_made_sum'])/(mergedArr[i]['target_calls_sum'])) * 100))/2).toFixed(2))
                                SiteObj[`${key}`]['cc_per'] = parseFloat(((((SiteObj[`${key}`]['calls_made_sum']) / (SiteObj[`${key}`]['target_calls_sum']) * 100))).toFixed(2))
                            } else {
                                obj = {
                                    'filter_key': mergedArr[i]['Site Name'],
                                    'calls_made_sum': mergedArr[i]['calls_made_sum'],
                                    'target_calls_sum': mergedArr[i]['target_calls_sum'],
                                    'Branch': []
                                }
                                if (mergedArr[i]['target_calls_sum'] === 0) {
                                    mergedArr[i]['target_calls_sum'] = 1
                                }
                                obj['cc_per'] = parseFloat((((mergedArr[i]['calls_made_sum']) / (mergedArr[i]['target_calls_sum'])) * 100).toFixed(2)),
                                    SiteObj[key] = obj
                            }
                        }

                    }

                    let BranchObj = {}
                    for (let i in mergedArr) {
                        if (current_month === mergedArr[i]['Calendar Month']) {
                            let obj = {}
                            let key = `${mergedArr[i]['Calendar Month']}/${mergedArr[i]['Division']}/${mergedArr[i]['Site Name']}/${mergedArr[i]['Branch Name']}`
                            if (mergedArr[i]['calls_made_sum'] == null) {
                                mergedArr[i]['calls_made_sum'] = 0
                            }
                            if (mergedArr[i]['target_calls_sum'] == null) {
                                mergedArr[i]['target_calls_sum'] = 0
                            }
                            if (key in BranchObj) {
                                BranchObj[`${key}`]['calls_made_sum'] += mergedArr[i]['calls_made_sum']
                                BranchObj[`${key}`]['target_calls_sum'] += mergedArr[i]['target_calls_sum']
                                if (mergedArr[i]['target_calls_sum'] === 0) {
                                    mergedArr[i]['target_calls_sum'] = 1
                                }
                                BranchObj[`${key}`]['cc_per'] = parseFloat(((((BranchObj[`${key}`]['calls_made_sum']) / (BranchObj[`${key}`]['target_calls_sum']) * 100))).toFixed(2))
                            } else {
                                obj = {
                                    'filter_key': mergedArr[i]['Branch Name'],
                                    'calls_made_sum': mergedArr[i]['calls_made_sum'],
                                    'target_calls_sum': mergedArr[i]['target_calls_sum'],
                                    'Channel': []
                                }
                                if (mergedArr[i]['target_calls_sum'] === 0) {
                                    mergedArr[i]['target_calls_sum'] = 1
                                }
                                obj['cc_per'] = parseFloat((((mergedArr[i]['calls_made_sum']) / (mergedArr[i]['target_calls_sum'])) * 100).toFixed(2)),
                                    BranchObj[key] = obj
                            }
                        }

                    }

                    let ChannelObj = {}
                    for (let i in mergedArr) {
                        if (current_month === mergedArr[i]['Calendar Month']) {
                            let obj = {}
                            let key = `${mergedArr[i]['Calendar Month']}/${mergedArr[i]['Division']}/${mergedArr[i]['Site Name']}/${mergedArr[i]['Branch Name']}/${mergedArr[i]['ChannelName']}`
                            if (mergedArr[i]['calls_made_sum'] == null) {
                                mergedArr[i]['calls_made_sum'] = 0
                            }
                            if (mergedArr[i]['target_calls_sum'] == null) {
                                mergedArr[i]['target_calls_sum'] = 0
                            }
                            if (key in ChannelObj) {
                                ChannelObj[`${key}`]['calls_made_sum'] += mergedArr[i]['calls_made_sum']
                                ChannelObj[`${key}`]['target_calls_sum'] += mergedArr[i]['target_calls_sum']
                                if (mergedArr[i]['target_calls_sum'] === 0) {
                                    mergedArr[i]['target_calls_sum'] = 1
                                }
                                ChannelObj[`${key}`]['cc_per'] = parseFloat(((((ChannelObj[`${key}`]['calls_made_sum']) / (ChannelObj[`${key}`]['target_calls_sum']) * 100))).toFixed(2))
                            } else {
                                obj = {
                                    'filter_key': mergedArr[i]['ChannelName'],
                                    'calls_made_sum': mergedArr[i]['calls_made_sum'],
                                    'target_calls_sum': mergedArr[i]['target_calls_sum'],
                                    'SubChannel': []
                                }
                                if (mergedArr[i]['target_calls_sum'] === 0) {
                                    mergedArr[i]['target_calls_sum'] = 1
                                }
                                obj['cc_per'] = parseFloat((((mergedArr[i]['calls_made_sum']) / (mergedArr[i]['target_calls_sum'])) * 100).toFixed(2)),
                                    ChannelObj[key] = obj
                            }
                        }

                    }

                    let subChannelObj = {}
                    for (let i in mergedArr) {
                        if (current_month === mergedArr[i]['Calendar Month']) {
                            let obj = {}
                            let key = `${mergedArr[i]['Calendar Month']}/${mergedArr[i]['Division']}/${mergedArr[i]['Site Name']}/${mergedArr[i]['Branch Name']}/${mergedArr[i]['ChannelName']}/${mergedArr[i]['SubChannelName']}`
                            if (mergedArr[i]['calls_made_sum'] == null) {
                                mergedArr[i]['calls_made_sum'] = 0
                            }
                            if (mergedArr[i]['target_calls_sum'] == null) {
                                mergedArr[i]['target_calls_sum'] = 0
                            }
                            if (key in subChannelObj) {
                                subChannelObj[`${key}`]['calls_made_sum'] += mergedArr[i]['calls_made_sum']
                                subChannelObj[`${key}`]['target_calls_sum'] += mergedArr[i]['target_calls_sum']
                                if (mergedArr[i]['target_calls_sum'] === 0) {
                                    mergedArr[i]['target_calls_sum'] = 1
                                }
                                subChannelObj[`${key}`]['cc_per'] = parseFloat(((((subChannelObj[`${key}`]['calls_made_sum']) / (subChannelObj[`${key}`]['target_calls_sum']) * 100))).toFixed(2))
                            } else {
                                obj = {
                                    'filter_key': mergedArr[i]['SubChannelName'],
                                    'calls_made_sum': mergedArr[i]['calls_made_sum'],
                                    'target_calls_sum': mergedArr[i]['target_calls_sum'],
                                }
                                if (mergedArr[i]['target_calls_sum'] === 0) {
                                    mergedArr[i]['target_calls_sum'] = 1
                                }
                                obj['cc_per'] = parseFloat((((mergedArr[i]['calls_made_sum']) / (mergedArr[i]['target_calls_sum'])) * 100).toFixed(2)),
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

                    let sql_query_no_of_cc_current_year

                    if (channel.length === 0) {
                        if (filter_data === 'allIndia') {
                            sql_query_no_of_cc_current_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum FROM [dbo].[tbl_command_center_cc_new] where [Calendar Month] = '${current_month}' and Division in ('N-E', 'S-W')`
                        } else {
                            sql_query_no_of_cc_current_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum FROM [dbo].[tbl_command_center_cc_new] where [Calendar Month] = '${current_month}' and [${filter_key}] = '${filter_data}'`
                        }
                    } else {
                        if (filter_data === 'allIndia') {
                            sql_query_no_of_cc_current_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum FROM [dbo].[tbl_command_center_cc_new] where [Calendar Month] = '${current_month}' and Division in ('N-E', 'S-W') and [ChannelName] in (${channel}) `
                        } else {
                            sql_query_no_of_cc_current_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum FROM [dbo].[tbl_command_center_cc_new] where [Calendar Month] = '${current_month}' and [${filter_key}] = '${filter_data}' and [ChannelName] in (${channel}) `
                        }
                    }

                    let cc_data = await sequelize.query(sql_query_no_of_cc_current_year)
                    let cc_call = 0
                    let cc_target = 1
                    let coverage = 1
                    if (cc_data[0][0] !== undefined) {
                        cc_call = cc_data[0][0]['calls_made_sum']
                        cc_target = cc_data[0][0]['target_calls_sum']
                    }

                    if (cc_call === null) {
                        cc_call = 0
                    }
                    if (cc_target === null) {
                        cc_target = 1
                    }
                    if (coverage === 0) {
                        coverage = 1
                    }
                    let cc_per = (cc_call / cc_target) * 100
                    if (coverage === 1) {
                        coverage = 0
                    }

                    let objData = {
                        "cc_per": parseInt(cc_per.toFixed(2).split(".")[0])
                    }
                    let divList = []
                    for (let i in DivisionObj) {
                        divList.push(DivisionObj[i])
                    }
                    if (filter_data === 'allIndia') {
                        filter_data = 'All India'
                    }
                    objData['filter'] = `${filter_data}`
                    objData['month'] = `${current_month}`
                    objData['channel'] = channel_list.map(item => item).join("/")
                    objData["division"] = divList
                    final_data.push(objData)
                    if (filter_data === 'All India') {
                        filter_data = 'allIndia'
                    }
                }
            }
            // final_data.push(filter_data)
            final_result.push(final_data)

            let allMonths = getPNMList2(reqDate, 3)
            let mergeObjAllIndia = {}
            mergeObjAllIndia['filter_key'] = final_data[0]['filter']
            mergeObjAllIndia['channel'] = channel_list.map(item => item).join("/")
            mergeObjAllIndia['month1'] = allMonths[0]
            mergeObjAllIndia['month2'] = allMonths[1]
            mergeObjAllIndia['month3'] = allMonths[2]
            mergeObjAllIndia['cc_per1'] = final_result[0][0]['cc_per']
            mergeObjAllIndia['cc_per2'] = final_result[0][1]['cc_per']
            mergeObjAllIndia['cc_per3'] = final_result[0][2]['cc_per']
            mergeObjAllIndia['division'] = []

            let mergeObjAllDivision = {}

            for (let i in final_result[0][0]['division']) {
                let div_key = final_result[0][0]['division'][i]['filter_key']
                if (!(div_key in mergeObjAllDivision)) {
                    mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`] = {
                        'filter_key': final_result[0][0]['division'][i]['filter_key'],
                        'cc_per1': final_result[0][0]['division'][i]['cc_per'],
                        'cc_per2': final_result[0][1]['division'][i]['cc_per'],
                        'cc_per3': final_result[0][2]['division'][i]['cc_per'],
                        'site': []
                    }
                }

                for (let j in final_result[0][0]['division'][i]['Site']) {
                    let mergeObjSite = {}
                    let site_key = final_result[0][0]['division'][i]['Site'][j]['filter_key']
                    let cc_per1 = getMatchedValue(final_result[0][0]['division'][i]['Site'], site_key)
                    let cc_per2 = getMatchedValue(final_result[0][1]['division'][i]['Site'], site_key)
                    let cc_per3 = getMatchedValue(final_result[0][2]['division'][i]['Site'], site_key)
                    mergeObjSite = {
                        'filter_key': site_key,
                        'cc_per1': cc_per1,
                        'cc_per2': cc_per2,
                        'cc_per3': cc_per3,
                        'branch': []
                    }
                    mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`]['site'].push(mergeObjSite)

                    for (let k in final_result[0][0]['division'][i]['Site'][j]['Branch']) {
                        let mergeObjBranch = {}
                        let branch_key = final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['filter_key']
                        let cc_per1 = getMatchedBranchValue(final_result[0][0]['division'][i]['Site'], site_key, branch_key)
                        let cc_per2 = getMatchedBranchValue(final_result[0][1]['division'][i]['Site'], site_key, branch_key)
                        let cc_per3 = getMatchedBranchValue(final_result[0][2]['division'][i]['Site'], site_key, branch_key)
                        mergeObjBranch = {
                            'filter_key': branch_key,
                            'cc_per1': cc_per1,
                            'cc_per2': cc_per2,
                            'cc_per3': cc_per3,
                            'channel': []
                        }
                        mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`]['site'][j]['branch'].push(mergeObjBranch)

                        for (let l in final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel']) {
                            let mergeObjChannel = {}
                            let channel_key = final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel'][l]['filter_key']
                            let cc_per1 = getMatchedChannelValue(final_result[0][0]['division'][i]['Site'], site_key, branch_key, channel_key)
                            let cc_per2 = getMatchedChannelValue(final_result[0][1]['division'][i]['Site'], site_key, branch_key, channel_key)
                            let cc_per3 = getMatchedChannelValue(final_result[0][2]['division'][i]['Site'], site_key, branch_key, channel_key)
                            mergeObjChannel = {
                                'filter_key': channel_key,
                                'cc_per1': cc_per1,
                                'cc_per2': cc_per2,
                                'cc_per3': cc_per3,
                                'subChannel': []
                            }
                            mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`]['site'][j]['branch'][k]['channel'].push(mergeObjChannel)

                            for (let m in final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel'][l]['SubChannel']) {
                                let mergeObjSubChannel = {}
                                let sub_channel_key = final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel'][l]['SubChannel'][m]['filter_key']
                                let cc_per1 = getMatchedSubChannelValue(final_result[0][0]['division'][i]['Site'], site_key, branch_key, channel_key, sub_channel_key)
                                let cc_per2 = getMatchedSubChannelValue(final_result[0][1]['division'][i]['Site'], site_key, branch_key, channel_key, sub_channel_key)
                                let cc_per3 = getMatchedSubChannelValue(final_result[0][2]['division'][i]['Site'], site_key, branch_key, channel_key, sub_channel_key)
                                mergeObjSubChannel = {
                                    'filter_key': sub_channel_key,
                                    'cc_per1': cc_per1,
                                    'cc_per2': cc_per2,
                                    'cc_per3': cc_per3
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
        return (all_result);
    }catch (e) {
        console.log('error',e)
        return e
        // res.status(500).send({successful: false, error: e})
    }
}

let getDeepDivePageData = async (req, res) => {
    try {
        let time_to_live = 7*24*60*60*1000 // Time in milliseconds for 7 days
        let cacheKey = 'ccMonthlyDeepDiveData'
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
        console.log('error', e)
        res.status(500).send({successful: false, error: e})
    }
}

module.exports = {
    getDeepDivePageData
}
