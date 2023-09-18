const {sequelize} = require('../../../databaseConnection/sql_connection');

const cache = require("memory-cache");

function copyObject(obj) {
    return JSON.parse(JSON.stringify(obj));
}

function sanitizeInput(input) {
    const sanitizedInput = input.trim();
    if (/^[a-zA-Z0-9\s\W_]+$/.test(sanitizedInput)) {
        return sanitizedInput; // Return the sanitized input if it contains only alphabet and special characters
    } else {
        throw new Error('Invalid input'); // Throw an error for invalid input
    }
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
            return arr[i]['billing_per']
        }
    }
    return 0
}

function getMatchedBranchValue(arr, key, branch_name){
    for(let i in arr){
        if(key === arr[i]['filter_key']){
            for(let j in arr[i]['Branch']){
                if(branch_name === arr[i]['Branch'][j]['filter_key']){
                    return arr[i]['Branch'][j]['billing_per']
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
                            return arr[i]['Branch'][j]['Channel'][k]['billing_per']
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
                                    return arr[i]['Branch'][j]['Channel'][k]['SubChannel'][l]['billing_per']
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

            let p24mList = getPNMList(date, 3)
            let calendar_month_cy = p24mList
            if (filter_data === "South-West") {
                filter_data = "S-W"
            }
            if (filter_data === "North-East") {
                filter_data = "N-E"
            }

            let mergedArr = []
            let channel_query_billing

            if (channel.length === 0) {
                if (filter_data === 'allIndia') {
                    channel_query_billing = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum ,[Calendar Month], Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] in (${calendar_month_cy}) and Division in ('N-E', 'S-W')  group by [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                } else {
                    channel_query_billing = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] in (${calendar_month_cy}) and [${filter_key}] = '${filter_data}' group by [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                }
            } else {
                if (filter_data === 'allIndia') {
                    channel_query_billing = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] in (${calendar_month_cy}) and Division in ('N-E', 'S-W') and [ChannelName] in (${channel}) group by [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                } else {

                    channel_query_billing = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum , [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] in (${calendar_month_cy}) and [${filter_key}] = '${filter_data}'  and [ChannelName] in (${channel}) group by [Calendar Month],Division ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                }
            }
            // console.time("Data Fetching")

            let categories_data_billing = await sequelize.query(channel_query_billing)
            // console.timeEnd("Data Fetching")
            mergedArr = categories_data_billing[0]

            let P3M = getPNMList2(date, 3)
            for (let i in P3M) {
                let current_month = P3M[i]
                {
                    let DivisionObj = {}
                    for (let i in mergedArr) {
                        if (current_month === mergedArr[i]['Calendar Month']) {
                            let obj = {}
                            let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                            let Division = sanitizeInput(mergedArr[i]['Division'])
                            let key = `${Month}/${Division}`
                            if (mergedArr[i]['billed_sum'] == null) {
                                mergedArr[i]['billed_sum'] = 0
                            }
                            if (mergedArr[i]['coverage_sum'] == null) {
                                mergedArr[i]['coverage_sum'] = 0
                            }
                            if (key in DivisionObj) {
                                DivisionObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                                DivisionObj[`${key}`]['coverage_sum'] += mergedArr[i]['coverage_sum']
                                if (mergedArr[i]['coverage_sum'] === 0) {
                                    mergedArr[i]['coverage_sum'] = 1
                                }
                                DivisionObj[`${key}`]['billing_per'] = parseFloat(((DivisionObj[`${key}`]['billing_per'] + ((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100)) / 2).toFixed(2))
                            } else {
                                obj = {
                                    'filter_key': mergedArr[i]['Division'],
                                    'billed_sum': mergedArr[i]['billed_sum'],
                                    'coverage_sum': mergedArr[i]['coverage_sum'],
                                    'Site': []
                                }
                                if (mergedArr[i]['coverage_sum'] === 0) {
                                    mergedArr[i]['coverage_sum'] = 1
                                }
                                obj['billing_per'] = parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                                    DivisionObj[key] = obj
                            }
                        }

                    }

                    let SiteObj = {}
                    for (let i in mergedArr) {
                        if (current_month === mergedArr[i]['Calendar Month']) {
                            let obj = {}
                            let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                            let Division = sanitizeInput(mergedArr[i]['Division'])
                            let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                            let key = `${Month}/${Division}/${Site_Name}`
                            if (mergedArr[i]['billed_sum'] == null) {
                                mergedArr[i]['billed_sum'] = 0
                            }
                            if (mergedArr[i]['coverage_sum'] == null) {
                                mergedArr[i]['coverage_sum'] = 0
                            }
                            if (key in SiteObj) {
                                SiteObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                                SiteObj[`${key}`]['coverage_sum'] += mergedArr[i]['coverage_sum']
                                if (mergedArr[i]['coverage_sum'] === 0) {
                                    mergedArr[i]['coverage_sum'] = 1
                                }
                                SiteObj[`${key}`]['billing_per'] = parseFloat(((((SiteObj[`${key}`]['billed_sum']) / (SiteObj[`${key}`]['coverage_sum']) * 100))).toFixed(2))
                            } else {
                                obj = {
                                    'filter_key': mergedArr[i]['Site Name'],
                                    'billed_sum': mergedArr[i]['billed_sum'],
                                    'coverage_sum': mergedArr[i]['coverage_sum'],
                                    'Branch': []
                                }
                                if (mergedArr[i]['coverage_sum'] === 0) {
                                    mergedArr[i]['coverage_sum'] = 1
                                }
                                obj['billing_per'] = parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                                    SiteObj[key] = obj
                            }
                        }

                    }


                    let BranchObj = {}
                    for (let i in mergedArr) {
                        if (current_month === mergedArr[i]['Calendar Month']) {
                            let obj = {}
                            let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                            let Division = sanitizeInput(mergedArr[i]['Division'])
                            let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                            let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                            let key = `${Month}/${Division}/${Site_Name}/${Branch_Name}`
                            if (mergedArr[i]['billed_sum'] == null) {
                                mergedArr[i]['billed_sum'] = 0
                            }
                            if (mergedArr[i]['coverage_sum'] == null) {
                                mergedArr[i]['coverage_sum'] = 0
                            }
                            if (key in BranchObj) {
                                BranchObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                                BranchObj[`${key}`]['coverage_sum'] += mergedArr[i]['coverage_sum']
                                if (mergedArr[i]['coverage_sum'] === 0) {
                                    mergedArr[i]['coverage_sum'] = 1
                                }
                                BranchObj[`${key}`]['billing_per'] = parseFloat(((((BranchObj[`${key}`]['billed_sum']) / (BranchObj[`${key}`]['coverage_sum']) * 100))).toFixed(2))
                            } else {
                                obj = {
                                    'filter_key': mergedArr[i]['Branch Name'],
                                    'billed_sum': mergedArr[i]['billed_sum'],
                                    'coverage_sum': mergedArr[i]['coverage_sum'],
                                    'Channel': []
                                }
                                if (mergedArr[i]['coverage_sum'] === 0) {
                                    mergedArr[i]['coverage_sum'] = 1
                                }
                                obj['billing_per'] = parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                                    BranchObj[key] = obj
                            }
                        }

                    }


                    let ChannelObj = {}
                    for (let i in mergedArr) {
                        if (current_month === mergedArr[i]['Calendar Month']) {
                            let obj = {}
                            let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                            let Division = sanitizeInput(mergedArr[i]['Division'])
                            let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                            let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                            let ChannelName = sanitizeInput(mergedArr[i]['ChannelName'])
                            let key = `${Month}/${Division}/${Site_Name}/${Branch_Name}/${ChannelName}`
                            if (mergedArr[i]['billed_sum'] == null) {
                                mergedArr[i]['billed_sum'] = 0
                            }
                            if (mergedArr[i]['coverage_sum'] == null) {
                                mergedArr[i]['coverage_sum'] = 0
                            }
                            if (key in ChannelObj) {
                                ChannelObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                                ChannelObj[`${key}`]['coverage_sum'] += mergedArr[i]['coverage_sum']
                                if (mergedArr[i]['coverage_sum'] === 0) {
                                    mergedArr[i]['coverage_sum'] = 1
                                }
                                ChannelObj[`${key}`]['billing_per'] = parseFloat(((((ChannelObj[`${key}`]['billed_sum']) / (ChannelObj[`${key}`]['coverage_sum']) * 100))).toFixed(2))
                            } else {
                                obj = {
                                    'filter_key': mergedArr[i]['ChannelName'],
                                    'billed_sum': mergedArr[i]['billed_sum'],
                                    'coverage_sum': mergedArr[i]['coverage_sum'],
                                    'SubChannel': []
                                }
                                if (mergedArr[i]['coverage_sum'] === 0) {
                                    mergedArr[i]['coverage_sum'] = 1
                                }
                                obj['billing_per'] = parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                                    ChannelObj[key] = obj
                            }
                        }

                    }


                    let subChannelObj = {}
                    for (let i in mergedArr) {
                        if (current_month === mergedArr[i]['Calendar Month']) {
                            let obj = {}
                            let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                            let Division = sanitizeInput(mergedArr[i]['Division'])
                            let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                            let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                            let ChannelName = sanitizeInput(mergedArr[i]['ChannelName'])
                            let SubChannelName = sanitizeInput(mergedArr[i]['SubChannelName'])
                            let key = `${Month}/${Division}/${Site_Name}/${Branch_Name}/${ChannelName}/${SubChannelName}`
                            if (mergedArr[i]['billed_sum'] == null) {
                                mergedArr[i]['billed_sum'] = 0
                            }
                            if (mergedArr[i]['coverage_sum'] == null) {
                                mergedArr[i]['coverage_sum'] = 0
                            }
                            if (key in subChannelObj) {
                                subChannelObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                                subChannelObj[`${key}`]['coverage_sum'] += mergedArr[i]['coverage_sum']
                                if (mergedArr[i]['coverage_sum'] === 0) {
                                    mergedArr[i]['coverage_sum'] = 1
                                }
                                subChannelObj[`${key}`]['billing_per'] = parseFloat(((((subChannelObj[`${key}`]['billed_sum']) / (subChannelObj[`${key}`]['coverage_sum']) * 100))).toFixed(2))
                            } else {
                                obj = {
                                    'filter_key': mergedArr[i]['SubChannelName'],
                                    'billed_sum': mergedArr[i]['billed_sum'],
                                    'coverage_sum': mergedArr[i]['coverage_sum'],
                                }
                                if (mergedArr[i]['coverage_sum'] === 0) {
                                    mergedArr[i]['coverage_sum'] = 1
                                }
                                obj['billing_per'] = parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
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


// Now Map all values....

                    let sql_query_no_of_billing_current_year

                    if (channel.length === 0) {
                        if (filter_data === 'allIndia') {
                            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${current_month}' and Division in ('N-E', 'S-W')`
                        } else {
                            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${current_month}' and [${filter_key}] = '${filter_data}'`
                        }
                    } else {
                        if (filter_data === 'allIndia') {
                            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${current_month}' and Division in ('N-E', 'S-W') and [ChannelName] in (${channel}) `
                        } else {
                            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${current_month}' and [${filter_key}] = '${filter_data}' and [ChannelName] in (${channel}) `
                        }
                    }

                    let billing_data = await sequelize.query(sql_query_no_of_billing_current_year)
                    let billing_call = 0
                    let billing_target = 1
                    let coverage = 1
                    if (billing_data[0][0] !== undefined) {
                        billing_call = billing_data[0][0]['billed_sum']
                        billing_target = billing_data[0][0]['coverage_sum']
                    }

                    if (billing_call === null) {
                        billing_call = 0
                    }
                    if (billing_target === null) {
                        billing_target = 1
                    }
                    if (coverage === 0) {
                        coverage = 1
                    }
                    let billing_per = (billing_call / billing_target) * 100
                    if (coverage === 1) {
                        coverage = 0
                    }

                    let objData = {
                        "billing_per": parseInt(billing_per.toFixed(2).split(".")[0])
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
            mergeObjAllIndia['billing_per1'] = final_result[0][0]['billing_per']
            mergeObjAllIndia['billing_per2'] = final_result[0][1]['billing_per']
            mergeObjAllIndia['billing_per3'] = final_result[0][2]['billing_per']
            mergeObjAllIndia['division'] = []

            let mergeObjAllDivision = {}

            for (let i in final_result[0][0]['division']) {
                let div_key = final_result[0][0]['division'][i]['filter_key']
                if (!(div_key in mergeObjAllDivision)) {
                    mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`] = {
                        'filter_key': final_result[0][0]['division'][i]['filter_key'],
                        'billing_per1': final_result[0][0]['division'][i]['billing_per'],
                        'billing_per2': final_result[0][1]['division'][i]['billing_per'],
                        'billing_per3': final_result[0][2]['division'][i]['billing_per'],
                        'site': []
                    }
                }

                for (let j in final_result[0][0]['division'][i]['Site']) {
                    let mergeObjSite = {}
                    let site_key = final_result[0][0]['division'][i]['Site'][j]['filter_key']
                    let billing_per1 = getMatchedValue(final_result[0][0]['division'][i]['Site'], site_key)
                    let billing_per2 = getMatchedValue(final_result[0][1]['division'][i]['Site'], site_key)
                    let billing_per3 = getMatchedValue(final_result[0][2]['division'][i]['Site'], site_key)
                    mergeObjSite = {
                        'filter_key': site_key,
                        'billing_per1': billing_per1,
                        'billing_per2': billing_per2,
                        'billing_per3': billing_per3,
                        'branch': []
                    }
                    mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`]['site'].push(mergeObjSite)

                    for (let k in final_result[0][0]['division'][i]['Site'][j]['Branch']) {
                        let mergeObjBranch = {}
                        let branch_key = final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['filter_key']
                        let billing_per1 = getMatchedBranchValue(final_result[0][0]['division'][i]['Site'], site_key, branch_key)
                        let billing_per2 = getMatchedBranchValue(final_result[0][1]['division'][i]['Site'], site_key, branch_key)
                        let billing_per3 = getMatchedBranchValue(final_result[0][2]['division'][i]['Site'], site_key, branch_key)
                        mergeObjBranch = {
                            'filter_key': branch_key,
                            'billing_per1': billing_per1,
                            'billing_per2': billing_per2,
                            'billing_per3': billing_per3,
                            'channel': []
                        }
                        mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`]['site'][j]['branch'].push(mergeObjBranch)

                        for (let l in final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel']) {
                            let mergeObjChannel = {}
                            let channel_key = final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel'][l]['filter_key']
                            let billing_per1 = getMatchedChannelValue(final_result[0][0]['division'][i]['Site'], site_key, branch_key, channel_key)
                            let billing_per2 = getMatchedChannelValue(final_result[0][1]['division'][i]['Site'], site_key, branch_key, channel_key)
                            let billing_per3 = getMatchedChannelValue(final_result[0][2]['division'][i]['Site'], site_key, branch_key, channel_key)
                            mergeObjChannel = {
                                'filter_key': channel_key,
                                'billing_per1': billing_per1,
                                'billing_per2': billing_per2,
                                'billing_per3': billing_per3,
                                'subChannel': []
                            }
                            mergeObjAllDivision[`${final_result[0][0]['division'][i]['filter_key']}`]['site'][j]['branch'][k]['channel'].push(mergeObjChannel)

                            for (let m in final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel'][l]['SubChannel']) {
                                let mergeObjSubChannel = {}
                                let sub_channel_key = final_result[0][0]['division'][i]['Site'][j]['Branch'][k]['Channel'][l]['SubChannel'][m]['filter_key']
                                let billing_per1 = getMatchedSubChannelValue(final_result[0][0]['division'][i]['Site'], site_key, branch_key, channel_key, sub_channel_key)
                                let billing_per2 = getMatchedSubChannelValue(final_result[0][1]['division'][i]['Site'], site_key, branch_key, channel_key, sub_channel_key)
                                let billing_per3 = getMatchedSubChannelValue(final_result[0][2]['division'][i]['Site'], site_key, branch_key, channel_key, sub_channel_key)
                                mergeObjSubChannel = {
                                    'filter_key': sub_channel_key,
                                    'billing_per1': billing_per1,
                                    'billing_per2': billing_per2,
                                    'billing_per3': billing_per3
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
        // res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getDeepDivePageData = async (req, res) => {
    try {
        let time_to_live = 7*24*60*60*1000 // Time in milliseconds for 7 days
        let cacheKey = 'billingMonthlyDeepDiveData'
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
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

module.exports = {
    getDeepDivePageData
}

