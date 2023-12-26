// const {sequelize} = require('../../../databaseConnection/sql_connection');
const {getConnection, getQueryData} = require('../../../databaseConnection/dbConnection');
// const {sequelize2} = require('../../../databaseConnection/sql_connection2');
const lodash = require("lodash");
// const {QueryTypes} = require('sequelize')

const cache = require("memory-cache");
const {v4: uuidv4} = require("uuid");

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

function getFormattedNo(number){
    if(number>100000){
        number=(number/100000).toFixed(2)+"MM"
    }else if(number>1000){
        number=(number/1000).toFixed(2)+"M"
    }else {
        number = number.toFixed(2)
    }
    return number
}

function getFormattedNoObj(data){
    for(let i in data){
        data[i]['Coverage'] = getFormattedNo(data[i]['Coverage'])
    }
    return data
}

// async function getSiteList(filter_type, filter_data) {
//     try {
//         let data
//
//         if(filter_data === 'allIndia'){
//             data = await sequelize.query(`select distinct [SiteName] FROM [da].[locationHierarchy_updated] where Division in ('DIV_0001', 'DIV_0002')`)
//         }
//         else{
//             if(filter_data === 'N-E'){filter_data = 'DIV_0002'}
//             if(filter_data === 'S-W'){filter_data = 'DIV_0001'}
//             if(filter_type === 'cluster'){filter_type = '[ClusterName]'}
//             data = await sequelize.query(`select distinct [SiteName] FROM [da].[locationHierarchy_updated] where ${filter_type} = '${filter_data}'`)
//         }
//
//         let sites = []
//         for(let site in data[0]){
//             sites.push(data[0][site]['SiteName'])
//             console.log((data[0][site]['SiteName']))
//         }
//         return sites
//     }catch (e){
//         console.log('error',e)
//         return []
//     }
// }

function addArrays(array1, array2) {
    if (array1.length !== array2.length) {
        throw new Error('Arrays must have the same length');
    }

    const result = array1.map((element, index) => element + array2[index]);
    return result;
}

// async function getBranchList(filter_type, filter_data, site) {
//     try {
//         let data
//
//         if(filter_data === 'allIndia'){
//             data = await sequelize.query(`select distinct [BranchName] FROM [da].[locationHierarchy_updated] where Division in ('DIV_0001', 'DIV_0002') and SiteName = '${site}' `)
//         }
//         else{
//             if(filter_data === 'N-E'){filter_data = 'DIV_0002'}
//             if(filter_data === 'S-W'){filter_data = 'DIV_0001'}
//             if(filter_type === 'cluster'){filter_type = '[ClusterName]'}
//             data = await sequelize.query(`select distinct [BranchName] FROM [da].[locationHierarchy_updated] where ${filter_type} = '${filter_data}' and SiteName = '${site}'`)
//         }
//
//         let branch_list = []
//         for(let branch in data[0]){
//             branch_list.push(data[0][branch]['BranchName'])
//             console.log((data[0][branch]['BranchName']))
//         }
//         return branch_list
//     }catch (e){
//         console.log('error',e)
//         return []
//     }
// }

// function getUniqueSiteNames(data) {
//     return Object.keys(data);
// }

let getDeepDivePageData = async (req, res) =>{

    try {
        let date = req.query.date;
        let year = new Date()
        let current_year = parseInt(date.split("-")[1])
        let previous_year = current_year-1
        let data = {}
        let filter_key;
        let filter_data;
        let filter_type = req.query
        delete filter_type.date;
        for(let key in filter_type){
            filter_key = key
            filter_data = filter_type[key]
        }

        if(filter_key==="allIndia"){filter_key="Division"
            filter_data = "allIndia"
        }

        let calendar_month_cy = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}

        let siteObj = []
        let site_query
        if(filter_data === 'allIndia'){
            site_query = `select sum([No of stores billed atleast once])as billed_sum, sum([Coverage]) as coverage_sum , [Site Name] FROM [dbo].[tbl_command_center_billing] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') group by [Site Name]`
        }
        else{
            site_query = `select sum([No of stores billed atleast once])as billed_sum, sum([Coverage]) as coverage_sum , [Site Name] FROM [dbo].[tbl_command_center_billing] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' group by [Site Name]`
        }
        let connection = await getConnection()
        let sites_data = await getQueryData(connection, site_query)
        // let sites_data = await sequelize.query(site_query)

        if(sites_data.length === 0 || sites_data[0]['billed_sum'] === null){
            res.status(200).json([]);
            return 0
        }

        for(let i in sites_data){
            let billing = 0
            let coverage = 1
            let site = ''
            let site_data = sites_data[i]
            if(sites_data[i] !== undefined){
                billing = site_data['billed_sum']
                coverage = site_data['coverage_sum']
                site = site_data['Site Name']
            }

            if(billing === null){billing = 0}
            if(coverage === null){coverage = 1}
            if(coverage === 0){coverage = 1}
            let billing_per = (billing / coverage) * 100
            if(coverage === 1){coverage = 0}

            let objData = {
                "Site": `${site}`,
                "Billing_Per": parseInt(`${billing_per}`.split(".")[0]),
                "Coverage": parseInt(coverage.toFixed(2).split(".")[0]),
            }
            siteObj.push(objData)

        }

        let sql_query_no_of_billing_current_year

        if(filter_data === 'allIndia'){
            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing] where Division in ('N-E', 'S-W') and [Calendar Month] = '${calendar_month_cy}'`
        }
        else{
            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
        }

        connection = await getConnection()
        let billing_and_coverage_data = await getQueryData(connection, sql_query_no_of_billing_current_year)
        // let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)

        if(billing_and_coverage_data.length === 0 || billing_and_coverage_data[0]['billed_sum'] === null){
            res.status(200).json([]);
            return 0
        }

        let billing = 0
        let coverage = 1
        let target_calls = 1

        if(billing_and_coverage_data[0] !== undefined && billing_and_coverage_data[0]['billed_sum'] !== null){
            billing = billing_and_coverage_data[0]['billed_sum']
            coverage = billing_and_coverage_data[0]['coverage_sum']
        }


        if(billing === null){billing = 0}
        if(coverage === null){coverage = 1}
        if(coverage === 0){coverage = 1}
        let billing_per = (billing / coverage) * 100
        if(coverage === 1){coverage = 0}

        let objData = {
            "Billing_Per": parseInt(`${billing_per}`.split(".")[0]),
            "Coverage": parseInt(coverage.toFixed(2).split(".")[0])
        }
        objData['filter_key'] = `${filter_data}`
        objData['month'] = `${date}`
        objData["sites"] = siteObj
        data["coverage"]=(objData)


        res.status(200).json([data]);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getDeepDivePageDataByBranch = async (req, res) =>{

    try {
        let date = req.query.date;
        let year = new Date()
        let current_year = parseInt(date.split("-")[1])
        let previous_year = current_year-1
        let data = {}
        let filter_key;
        let filter_data;
        let filter_type = req.query
        delete filter_type.date;
        for(let key in filter_type){
            filter_key = key
            filter_data = filter_type[key]
        }

        if(filter_key==="allIndia"){filter_key="Division"
            filter_data = "allIndia"
        }

        let calendar_month_cy = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}

        let siteObj = []
        let site_query_billing
        let site_query_productivity
        if(filter_data === 'allIndia'){
            site_query_billing = `select sum([No of stores billed atleast once])as billed_sum, sum([Coverage]) as coverage_sum , [Site Name], [Branch Name] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') group by [Site Name], [Branch Name] order by [Site Name] ASC`
            site_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , [Site Name], [Branch Name] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') group by [Site Name], [Branch Name] order by [Site Name] ASC`
        }
        else{
            site_query_billing = `select sum([No of stores billed atleast once])as billed_sum, sum([Coverage]) as coverage_sum , [Site Name], [Branch Name] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' group by [Site Name], [Branch Name] order by [Site Name] ASC`
            site_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , [Site Name], [Branch Name] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' group by [Site Name], [Branch Name] order by [Site Name] ASC`
        }
        let connection = await getConnection()
        let sites_data_billing = await getQueryData(connection, site_query_billing)
        // let sites_data_billing = await sequelize.query(site_query_billing)
        connection = await getConnection()
        let sites_data_productivity = await getQueryData(connection, site_query_productivity)
        // let sites_data_productivity = await sequelize.query(site_query_productivity)

        const siteNames = []
        let siteNamesSet

        let branchMap = {}
        for (let i = 0; i < sites_data_productivity.length; i++) {
            branchMap[`${sites_data_productivity[i]['Site Name']}/${sites_data_productivity[i]['Branch Name']}`] = (sites_data_productivity[i]['pro_sum']/sites_data_productivity[i]['target_sum'])*100
        }
        let mergedArr = []
        for (let i = 0; i < sites_data_billing.length; i++) {
            let obj = {
               'Site Name' :   sites_data_billing[i]['Site Name'],
               'Branch Name' :   sites_data_billing[i]['Branch Name'],
               'billed_sum' :   sites_data_billing[i]['billed_sum'],
               'coverage_sum' :   sites_data_billing[i]['coverage_sum'],
                'productivity_per' : branchMap[`${sites_data_billing[i]['Site Name']}/${sites_data_billing[i]['Branch Name']}`]
            }
            mergedArr.push(obj)
        }

        // console.log(branchMap)

        for(let i in sites_data_billing){
            if(sites_data_billing[i] !== undefined){
                siteNames.push(sites_data_billing[i]['Site Name'])
            }
        }

        siteNamesSet = new Set(siteNames)
        let siteNameObj = {}
        for(let siteName of siteNamesSet){
            siteNameObj[`${siteName}`]= {
                "Site": `${siteName}`,
                "Billing_Per": 0,
                "Coverage": 0,
                "Productivity": 0,
                "Branch" : []
            }
            }
        for(let i in mergedArr){
            for(let siteName of siteNamesSet){
                siteName = sanitizeInput(siteName)
                if(siteName === mergedArr[i]['Site Name']){
                    if(siteNameObj[`${siteName}`]['Billing_Per'] === 0){
                        siteNameObj[`${siteName}`]['Billing_Per'] = parseFloat(((mergedArr[i]['billed_sum']/mergedArr[i]['coverage_sum'])*100).toFixed(2))
                        siteNameObj[`${siteName}`]['Coverage'] += (mergedArr[i]['coverage_sum'])
                        siteNameObj[`${siteName}`]['Productivity'] = parseFloat((mergedArr[i]['productivity_per'] !== undefined) ?
                            (mergedArr[i]['productivity_per']).toFixed(2) :
                            0)
                        siteNameObj[`${siteName}`]['Branch'].push({
                            "Branch": `${mergedArr[i]['Branch Name']}`,
                            "Billing_Per": parseFloat(((mergedArr[i]['billed_sum']/mergedArr[i]['coverage_sum'])*100).toFixed(2)),
                            "Coverage": (mergedArr[i]['coverage_sum']),
                            "Productivity" : parseFloat((mergedArr[i]['productivity_per'] !== undefined) ?
                                (mergedArr[i]['productivity_per']).toFixed(2) :
                                0)
                        })
                    }else{
                        siteNameObj[`${siteName}`]['Billing_Per'] = parseFloat(((parseFloat(siteNameObj[`${siteName}`]['Billing_Per']) + (parseFloat(mergedArr[i]['billed_sum']/mergedArr[i]['coverage_sum'])*100))/2).toFixed(2))
                        siteNameObj[`${siteName}`]['Coverage'] += (mergedArr[i]['coverage_sum'])
                        siteNameObj[`${siteName}`]['Productivity'] = parseFloat(((parseFloat(siteNameObj[`${siteName}`]['Productivity']) + parseFloat(((mergedArr[i]['productivity_per'] !== undefined) ?
                            (mergedArr[i]['productivity_per']).toFixed(2) :
                            0)))/2).toFixed(2))
                        siteNameObj[`${siteName}`]['Branch'].push({
                            "Branch": `${mergedArr[i]['Branch Name']}`,
                            "Billing_Per": parseFloat(((mergedArr[i]['billed_sum']/mergedArr[i]['coverage_sum'])*100).toFixed(2)),
                            "Coverage": (mergedArr[i]['coverage_sum']),
                            "Productivity" : parseFloat((mergedArr[i]['productivity_per'] !== undefined) ?
                                (mergedArr[i]['productivity_per']).toFixed(2) :
                                0)
                        })
                    }
                }
            }
        }

        for(let site in siteNameObj){
            siteObj.push(siteNameObj[site])
        }

        let sql_query_no_of_billing_current_year
        let sql_query_no_of_productivity_current_year

        if(filter_data === 'allIndia'){
            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing] where Division in ('N-E', 'S-W') and [Calendar Month] = '${calendar_month_cy}'`
            sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W')`
        }
        else{
            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
            sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}'`
        }

        connection = await getConnection()
        let billing_and_coverage_data = await getQueryData(connection, sql_query_no_of_billing_current_year)
        // let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)
        connection = await getConnection()
        let productivity_data = await getQueryData(connection, sql_query_no_of_productivity_current_year)
        // let productivity_data = await sequelize.query(sql_query_no_of_productivity_current_year)
        let billing = 0
        let productivity_call = 0
        let productivity_target = 1
        let coverage = 1
        let target_calls = 1

        if(billing_and_coverage_data[0] !== undefined){
            billing = billing_and_coverage_data[0]['billed_sum']
            coverage = billing_and_coverage_data[0]['coverage_sum']
        }

        if(productivity_data[0] !== undefined){
            productivity_call = productivity_data[0]['pro_sum']
            productivity_target = productivity_data[0]['target_sum']
        }

        if(billing === null){billing = 0}
        if(coverage === null){coverage = 1}
        if(productivity_call === null){productivity_call = 0}
        if(productivity_target === null){productivity_target = 1}
        if(coverage === 0){coverage = 1}
        let billing_per = (billing / coverage) * 100
        let productivity_per = (productivity_call / productivity_target) * 100
        if(coverage === 1){coverage = 0}

        let objData = {
            "Billing_Per": parseInt(`${billing_per}`.split(".")[0]),
            "Coverage": parseInt(coverage.toFixed(2).split(".")[0]),
            "Productivity": parseInt(productivity_per.toFixed(2).split(".")[0])
        }
        if(filter_data === 'allIndia'){filter_data = 'All India'}
        objData['filter_key'] = `${filter_data}`
        objData['month'] = `${date}`
        objData["sites"] = siteObj
        // data["coverage"]=(objData)


        res.status(200).json([objData]);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getDeepDivePageDataBySubChannel = async (req, res) =>{

    try {
        let date = req.query.date;
        let year = new Date()
        let current_year = parseInt(date.split("-")[1])
        let previous_year = current_year-1
        let data = {}
        let filter_key;
        let filter_data;
        let channel = req.query.channel
        let filter_type = req.query
        delete filter_type.date;
        delete filter_type.channel;

        for(let key in filter_type){
            filter_key = key
            filter_data = filter_type[key]
        }

        if(filter_key==="allIndia"){filter_key="Division"
            filter_data = "allIndia"
        }

        let calendar_month_cy = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}

        let channelObj = []
        let channel_query_billing
        let channel_query_productivity
        if(filter_data === 'allIndia'){
            channel_query_billing = `select sum([No of stores billed atleast once])as billed_sum, sum([Coverage]) as coverage_sum , [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and ChannelName = '${channel}' group by [ChannelName], [SubChannelName] order by [ChannelName] ASC`
            channel_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and ChannelName = '${channel}' group by [ChannelName], [SubChannelName] order by [ChannelName] ASC`
        }
        else{
            channel_query_billing = `select sum([No of stores billed atleast once])as billed_sum, sum([Coverage]) as coverage_sum , [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' and ChannelName = '${channel}' group by [ChannelName], [SubChannelName] order by [ChannelName] ASC`
            channel_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' and ChannelName = '${channel}' group by [ChannelName], [SubChannelName] order by [ChannelName] ASC`
        }

        let connection = await getConnection()
        let channels_data_billing = await getQueryData(connection, channel_query_billing)
        // let channels_data_billing = await sequelize.query(channel_query_billing)
        connection = await getConnection()
        let channels_data_productivity = await getQueryData(connection, channel_query_productivity)
        // let channels_data_productivity = await sequelize.query(channel_query_productivity)

        const channelNames = []
        let channelNamesSet

        let subChannelMap = {}
        for (let i = 0; i < channels_data_productivity.length; i++) {
            subChannelMap[`${channels_data_productivity[i]['ChannelName']}/${channels_data_productivity[i]['SubChannelName']}`] = (channels_data_productivity[i]['pro_sum']/channels_data_productivity[i]['target_sum'])*100
        }
        let mergedArr = []
        for (let i = 0; i < channels_data_billing.length; i++) {
            let obj = {
                'ChannelName' :   channels_data_billing[i]['ChannelName'],
                'SubChannelName' :   channels_data_billing[i]['SubChannelName'],
                'billed_sum' :   channels_data_billing[i]['billed_sum'],
                'coverage_sum' :   channels_data_billing[i]['coverage_sum'],
                'productivity_per' : subChannelMap[`${channels_data_billing[i]['ChannelName']}/${channels_data_billing[i]['SubChannelName']}`]
            }
            mergedArr.push(obj)
        }

        // console.log(subChannelMap)

        for(let i in channels_data_billing){
            if(channels_data_billing[i] !== undefined){
                channelNames.push(channels_data_billing[i]['ChannelName'])
            }
        }

        channelNamesSet = new Set(channelNames)
        let channelNameObj = {}
        for(let channelName of channelNamesSet){
            channelNameObj[`${channelName}`]= {
                "Channel": `${channelName}`,
                "Billing_Per": 0,
                "Coverage": 0,
                "Productivity": 0,
                "SubChannel" : []
            }
        }
        for(let i in mergedArr){
            for(let channelName of channelNamesSet){
                channelName = sanitizeInput(channelName)
                if(channelName === mergedArr[i]['ChannelName']){
                    if(channelNameObj[`${channelName}`]['Billing_Per'] === 0){
                        channelNameObj[`${channelName}`]['Billing_Per'] = parseFloat(((mergedArr[i]['billed_sum']/mergedArr[i]['coverage_sum'])*100).toFixed(2))
                        channelNameObj[`${channelName}`]['Coverage'] += (mergedArr[i]['coverage_sum'])
                        channelNameObj[`${channelName}`]['Productivity'] = parseFloat((mergedArr[i]['productivity_per'] !== undefined) ?
                            (mergedArr[i]['productivity_per']).toFixed(2) :
                            0)
                        channelNameObj[`${channelName}`]['SubChannel'].push({
                            "SubChannel": `${mergedArr[i]['SubChannelName']}`,
                            "Billing_Per": parseFloat(((mergedArr[i]['billed_sum']/mergedArr[i]['coverage_sum'])*100).toFixed(2)),
                            "Coverage": (mergedArr[i]['coverage_sum']),
                            "Productivity" : parseFloat((mergedArr[i]['productivity_per'] !== undefined) ?
                                (mergedArr[i]['productivity_per']).toFixed(2) :
                                0)
                        })
                    }else{
                        channelNameObj[`${channelName}`]['Billing_Per'] = parseFloat(((parseFloat(channelNameObj[`${channelName}`]['Billing_Per']) + (parseFloat(mergedArr[i]['billed_sum']/mergedArr[i]['coverage_sum'])*100))/2).toFixed(2))
                        channelNameObj[`${channelName}`]['Coverage'] += (mergedArr[i]['coverage_sum'])
                        channelNameObj[`${channelName}`]['Productivity'] = parseFloat(((parseFloat(channelNameObj[`${channelName}`]['Productivity']) + parseFloat(((mergedArr[i]['productivity_per'] !== undefined) ?
                            (mergedArr[i]['productivity_per']).toFixed(2) :
                            0)))/2).toFixed(2))
                        channelNameObj[`${channelName}`]['SubChannel'].push({
                            "SubChannel": `${mergedArr[i]['SubChannelName']}`,
                            "Billing_Per": parseFloat(((mergedArr[i]['billed_sum']/mergedArr[i]['coverage_sum'])*100).toFixed(2)),
                            "Coverage": (mergedArr[i]['coverage_sum']),
                            "Productivity" : parseFloat((mergedArr[i]['productivity_per'] !== undefined) ?
                                (mergedArr[i]['productivity_per']).toFixed(2) :
                                0)
                        })
                    }
                }
            }
        }

        for(let channel in channelNameObj){
            channelObj.push(channelNameObj[channel])
        }

        let sql_query_no_of_billing_current_year
        let sql_query_no_of_productivity_current_year

        if(filter_data === 'allIndia'){
            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where Division in ('N-E', 'S-W') and [Calendar Month] = '${calendar_month_cy}'`
            sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W')`
        }
        else{
            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
            sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}'`
        }
        connection = await getConnection()
        let billing_and_coverage_data = await getQueryData(connection, sql_query_no_of_billing_current_year)
        // let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)
        connection = await getConnection()
        let productivity_data = await getQueryData(connection, sql_query_no_of_productivity_current_year)
        // let productivity_data = await sequelize.query(sql_query_no_of_productivity_current_year)
        let billing = 0
        let productivity_call = 0
        let productivity_target = 1
        let coverage = 1
        let target_calls = 1

        if(billing_and_coverage_data !== undefined){
            billing = billing_and_coverage_data[0]['billed_sum']
            coverage = billing_and_coverage_data[0]['coverage_sum']
        }

        if(productivity_data !== undefined){
            productivity_call = productivity_data[0]['pro_sum']
            productivity_target = productivity_data[0]['target_sum']
        }

        if(billing === null){billing = 0}
        if(coverage === null){coverage = 1}
        if(productivity_call === null){productivity_call = 0}
        if(productivity_target === null){productivity_target = 1}
        if(coverage === 0){coverage = 1}
        let billing_per = (billing / coverage) * 100
        let productivity_per = (productivity_call / productivity_target) * 100
        if(coverage === 1){coverage = 0}

        let objData = {
            "Billing_Per": parseInt(`${billing_per}`.split(".")[0]),
            "Coverage": parseInt(coverage.toFixed(2).split(".")[0]),
            "Productivity": parseInt(productivity_per.toFixed(2).split(".")[0])
        }
        if(filter_data === 'allIndia'){filter_data = 'All India'}
        objData['filter_key'] = `${filter_data}`
        objData['month'] = `${date}`
        objData["channels"] = channelObj
        // data["coverage"]=(objData)


        res.status(200).json([objData]);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

async function getTableData (bodyData){

    try {
        let all_data = copyObject(bodyData);
        let final_data = []
        for(let i in all_data){
            let data = all_data[i]
            let date = data.date;
            let filter_key;
            let filter_data;
            let filter_type = data
            let channel = []
            let channel_list = []
            channel = data.channel
            channel_list = data.channel
            channel_list = [...new Set(channel_list)];
            channel = channel.map(item => `'${item}'`).join(", ")
            delete filter_type.date;
            delete filter_type.channel;
            for(let key in filter_type){
                filter_key = key
                filter_data = filter_type[key]
            }
            if(filter_key==="allIndia"){filter_key="Division"
                filter_data = "allIndia"
            }

            let calendar_month_cy = `CY${date.split("-")[1]}-${date.split("-")[0]}`
            if (filter_data === "South-West"){filter_data="S-W"}
            if (filter_data === "North-East"){filter_data="N-E"}

            let db_data = []
            if(filter_data === "allIndia"){
                let data_query_ne = `select top(5) * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and Division = 'N-E' `
                let data_query_sw = `select top(5) * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and Division = 'S-W' `
                let connection = await getConnection()
                let db_data_ne = await getQueryData(connection, data_query_ne);
                // let db_data_ne = await sequelize.query(data_query_ne);
                connection = await getConnection()
                let db_data_sw = await getQueryData(connection, data_query_sw);
                // let db_data_sw = await sequelize.query(data_query_sw);
                db_data = [...db_data_ne, ...db_data_sw]
                // db_data=(db_data_ne)
                // db_data[0].push(db_data_sw[0])
            }else {
                let data_query = `select top(10) * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' `
                let connection = await getConnection()
                let db_data_filter = await getQueryData(connection, data_query);
                // let db_data_filter = await sequelize.query(data_query);
                db_data=(db_data_filter)
            }

            let mergedArr = []
            if(db_data.length>5 && (db_data[0]['channelFilter'] === false)){
                if(filter_data === "allIndia"){
                    let data_query = ''
                    if(channel.length === 0){
                        data_query = `select * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') `
                    }else{
                        data_query = `select * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W')  and [ChannelName] in (${channel})`
                    }
                    let connection = await getConnection()
                    let db_data = await getQueryData(connection, data_query);
                    // let db_data = await sequelize.query(data_query);
                    mergedArr = db_data
                }else {
                    let data_query = ''
                    if(channel.length === 0){
                        data_query = `select * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' `
                    }else{
                        data_query = `select * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' and [ChannelName] in (${channel})`
                    }
                    let connection = await getConnection()
                    let db_data = await getQueryData(connection, data_query);
                    // let db_data = await sequelize.query(data_query);
                    mergedArr = db_data
                }
                console.log("Data is already inserted.....")
            }
            else{

                let channel_query_billing
                let channel_query_productivity
                let exist_data_query = `delete FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}'`
                // let delete_data = await sequelize.query(exist_data_query);

                if(channel.length === 0){
                    if(filter_data === 'allIndia'){
                        channel_query_billing = `select sum([No of stores billed atleast once])as billed_sum, sum([Coverage]) as coverage_sum ,Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') group by Division ,[Cluster], [Site Name], [Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                        channel_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W')  group by Division ,[Cluster] ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`

                    }
                    else{

                        channel_query_billing = `select sum([No of stores billed atleast once])as billed_sum, sum([Coverage]) as coverage_sum ,Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' group by Division ,[Cluster], [Site Name], [Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                        channel_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' group by Division ,[Cluster] ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`

                    }
                }else {
                    if(filter_data === 'allIndia'){
                        channel_query_billing = `select sum([No of stores billed atleast once])as billed_sum, sum([Coverage]) as coverage_sum ,Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and [ChannelName] in (${channel}) group by Division ,[Cluster], [Site Name], [Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                        channel_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and [ChannelName] in (${channel}) group by Division ,[Cluster] ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`

                    }
                    else{

                        channel_query_billing = `select sum([No of stores billed atleast once])as billed_sum, sum([Coverage]) as coverage_sum ,Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_billing_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' and [ChannelName] in (${channel}) group by Division ,[Cluster], [Site Name], [Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                        channel_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}'  and [ChannelName] in (${channel}) group by Division ,[Cluster] ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`

                    }
                }

                let connection = await getConnection()
                let categories_data_coverage = await getQueryData(connection, channel_query_billing)

                // let categories_data_coverage = await sequelize.query(channel_query_billing)
                connection = getConnection()
                let categories_data_productivity = await getQueryData(connection, channel_query_productivity)
                // let categories_data_productivity = await sequelize.query(channel_query_productivity)

                let subChannelMap = {}
                for (let i = 0; i < categories_data_productivity.length; i++) {
                    subChannelMap[`${categories_data_productivity[i]['Division']}/${categories_data_productivity[i]['Site Name']}/${categories_data_productivity[i]['Branch Name']}/${categories_data_productivity[i]['ChannelName']}/${categories_data_productivity[i]['SubChannelName']}/'pc'`] = (categories_data_productivity[i]['pro_sum'])
                    subChannelMap[`${categories_data_productivity[i]['Division']}/${categories_data_productivity[i]['Site Name']}/${categories_data_productivity[i]['Branch Name']}/${categories_data_productivity[i]['ChannelName']}/${categories_data_productivity[i]['SubChannelName']}/'tc'`] = (categories_data_productivity[i]['target_sum'])
                }
                let channelFilter = false
                if(channel.length === 0){channelFilter = false}
                else{channelFilter = true}
                for (let i = 0; i < categories_data_coverage.length; i++) {
                    let obj = {
                        'Calendar Month': calendar_month_cy,
                        'Division' :   categories_data_coverage[i]['Division'],
                        'Site Name' :   categories_data_coverage[i]['Site Name'],
                        'Branch Name' :   categories_data_coverage[i]['Branch Name'],
                        'ChannelName' :   categories_data_coverage[i]['ChannelName'],
                        'SubChannelName' :   categories_data_coverage[i]['SubChannelName'],
                        'billed_sum' :   categories_data_coverage[i]['billed_sum'],
                        'coverage_sum' :   categories_data_coverage[i]['coverage_sum'],
                        'pc' : subChannelMap[`${categories_data_coverage[i]['Division']}/${categories_data_coverage[i]['Site Name']}/${categories_data_coverage[i]['Branch Name']}/${categories_data_coverage[i]['ChannelName']}/${categories_data_coverage[i]['SubChannelName']}/'pc'`] ? subChannelMap[`${categories_data_coverage[i]['Division']}/${categories_data_coverage[i]['Site Name']}/${categories_data_coverage[i]['Branch Name']}/${categories_data_coverage[i]['ChannelName']}/${categories_data_coverage[i]['SubChannelName']}/'pc'`] : 0,
                        'tc' : subChannelMap[`${categories_data_coverage[i]['Division']}/${categories_data_coverage[i]['Site Name']}/${categories_data_coverage[i]['Branch Name']}/${categories_data_coverage[i]['ChannelName']}/${categories_data_coverage[i]['SubChannelName']}/'tc'`] ? subChannelMap[`${categories_data_coverage[i]['Division']}/${categories_data_coverage[i]['Site Name']}/${categories_data_coverage[i]['Branch Name']}/${categories_data_coverage[i]['ChannelName']}/${categories_data_coverage[i]['SubChannelName']}/'tc'`] : 0,
                        'user_id' : 1,
                        'channelFilter': channelFilter,
                        'Cluster' :   categories_data_coverage[i]['Cluster']
                    }
                    mergedArr.push(obj)
                }

                // console.time('making chunks')
                let chunks = lodash.chunk(mergedArr, 1000)
                for (let chunk of chunks) {
                    const columns = [
                        '[Calendar Month]',
                        '[Division]',
                        '[Site Name]',
                        '[Branch Name]',
                        '[ChannelName]',
                        '[SubChannelName]',
                        '[billed_sum]',
                        '[coverage_sum]',
                        '[pc_sum]',
                        '[tc_sum]',
                        '[user_id]',
                        '[channelFilter]',
                        '[Cluster]'
                    ];
                    const valuePlaceholders = chunk.map(() => `(${columns.map(() => '?').join(',')})`).join(',');
                    const values = chunk.map(obj => {
                        return Object.values(obj);
                    });
                    const flattenedValues = values.flat();
                    let connection = await getConnection()
                    const query = `INSERT INTO [dbo].[tbl_coverageDeepDiveData] (${columns.join(',')}) VALUES ${valuePlaceholders}`;
                    getQueryData(connection,query);
                    // sequelize.query(query, {replacements: flattenedValues, type: QueryTypes.INSERT});
                }
                // console.timeEnd('making chunks')
            }


            let DivisionObj = {}
            for(let i in mergedArr){
                let obj = {}
                let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                let Division = sanitizeInput(mergedArr[i]['Division'])
                let key = `${Month}/${Division}`
                if(mergedArr[i]['billed_sum'] == null){mergedArr[i]['billed_sum'] = 0}
                if(mergedArr[i]['coverage_sum'] == null){mergedArr[i]['coverage_sum'] = 0}
                if(mergedArr[i]['pc_sum'] == null){mergedArr[i]['pc_sum'] = 0}
                if(mergedArr[i]['tc_sum'] == null){mergedArr[i]['tc_sum'] = 0}
                if(mergedArr[i]['productivity_per'] == null){mergedArr[i]['productivity_per'] = 0}
                if (key in DivisionObj){
                    DivisionObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                    DivisionObj[`${key}`]['Coverage'] += mergedArr[i]['coverage_sum']
                    DivisionObj[`${key}`]['pc_sum'] += mergedArr[i]['pc_sum']
                    DivisionObj[`${key}`]['tc_sum'] += mergedArr[i]['tc_sum']
                    if(DivisionObj[`${key}`]['tc_sum'] === 0){
                        DivisionObj[`${key}`]['productivity_per'] = parseFloat(((((DivisionObj[`${key}`]['pc_sum'])/(1) * 100))).toFixed(2))
                    }else{
                        DivisionObj[`${key}`]['productivity_per'] = parseFloat(((((DivisionObj[`${key}`]['pc_sum'])/(DivisionObj[`${key}`]['tc_sum']) * 100))).toFixed(2))
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    DivisionObj[`${key}`]['billing_per'] = parseFloat(((((DivisionObj[`${key}`]['billed_sum'])/(DivisionObj[`${key}`]['Coverage']) * 100))).toFixed(2))
                }else{
                    obj={
                        'filter_key': mergedArr[i]['Division'],
                        'billed_sum': mergedArr[i]['billed_sum'],
                        'Coverage': mergedArr[i]['coverage_sum'],
                        'pc_sum': mergedArr[i]['tc_sum'],
                        'tc_sum': mergedArr[i]['tc_sum'],
                        'Site' : []
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    if(mergedArr[i]['tc_sum'] === 0){mergedArr[i]['tc_sum'] = 1}
                    obj['billing_per'] =  parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                    obj['productivity_per'] =  parseFloat(((mergedArr[i]['pc_sum']) / (mergedArr[i]['tc_sum']) * 100).toFixed(2)),
                        DivisionObj[key] = obj
                }
            }

            let SiteObj = {}
            for(let i in mergedArr){
                let obj = {}
                let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                let Division = sanitizeInput(mergedArr[i]['Division'])
                let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                let key = `${Month}/${Division}/${Site_Name}`
                if(mergedArr[i]['billed_sum'] == null){mergedArr[i]['billed_sum'] = 0}
                if(mergedArr[i]['coverage_sum'] == null){mergedArr[i]['coverage_sum'] = 0}
                if(mergedArr[i]['pc_sum'] == null){mergedArr[i]['pc_sum'] = 0}
                if(mergedArr[i]['tc_sum'] == null){mergedArr[i]['tc_sum'] = 0}
                if(mergedArr[i]['productivity_per'] == null){mergedArr[i]['productivity_per'] = 0}
                if (key in SiteObj){
                    SiteObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                    SiteObj[`${key}`]['Coverage'] += mergedArr[i]['coverage_sum']
                    SiteObj[`${key}`]['pc_sum'] += mergedArr[i]['pc_sum']
                    SiteObj[`${key}`]['tc_sum'] += mergedArr[i]['tc_sum']
                    if(SiteObj[`${key}`]['tc_sum'] === 0){
                        SiteObj[`${key}`]['productivity_per'] = parseFloat(((((SiteObj[`${key}`]['pc_sum'])/(1) * 100))).toFixed(2))
                    }else{
                        SiteObj[`${key}`]['productivity_per'] = parseFloat(((((SiteObj[`${key}`]['pc_sum'])/(SiteObj[`${key}`]['tc_sum']) * 100))).toFixed(2))
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    SiteObj[`${key}`]['billing_per'] = parseFloat(((((SiteObj[`${key}`]['billed_sum'])/(SiteObj[`${key}`]['Coverage']) * 100))).toFixed(2))
                }else{
                    obj={
                        'filter_key': mergedArr[i]['Site Name'],
                        'billed_sum': mergedArr[i]['billed_sum'],
                        'Coverage': mergedArr[i]['coverage_sum'],
                        'pc_sum': mergedArr[i]['pc_sum'],
                        'tc_sum': mergedArr[i]['tc_sum'],
                        'Branch' : []
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    if(mergedArr[i]['tc_sum'] === 0){mergedArr[i]['tc_sum'] = 1}
                    obj['billing_per'] =  parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                        obj['productivity_per'] =  parseFloat(((mergedArr[i]['pc_sum']) / (mergedArr[i]['tc_sum']) * 100).toFixed(2)),
                        SiteObj[key] = obj
                }
            }

            let BranchObj = {}
            for(let i in mergedArr){
                let obj = {}
                let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                let Division = sanitizeInput(mergedArr[i]['Division'])
                let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                let key = `${Month}/${Division}/${Site_Name}/${Branch_Name}`
                if(mergedArr[i]['billed_sum'] == null){mergedArr[i]['billed_sum'] = 0}
                if(mergedArr[i]['coverage_sum'] == null){mergedArr[i]['coverage_sum'] = 0}
                if(mergedArr[i]['pc_sum'] == null){mergedArr[i]['pc_sum'] = 0}
                if(mergedArr[i]['tc_sum'] == null){mergedArr[i]['tc_sum'] = 0}
                if(mergedArr[i]['productivity_per'] == null){mergedArr[i]['productivity_per'] = 0}
                if (key in BranchObj){
                    BranchObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                    BranchObj[`${key}`]['Coverage'] += mergedArr[i]['coverage_sum']
                    BranchObj[`${key}`]['pc_sum'] += mergedArr[i]['pc_sum']
                    BranchObj[`${key}`]['tc_sum'] += mergedArr[i]['tc_sum']
                    if(BranchObj[`${key}`]['tc_sum'] === 0){
                        BranchObj[`${key}`]['productivity_per'] = parseFloat(((((BranchObj[`${key}`]['pc_sum'])/(1) * 100))).toFixed(2))
                    }else{
                        BranchObj[`${key}`]['productivity_per'] = parseFloat(((((BranchObj[`${key}`]['pc_sum'])/(BranchObj[`${key}`]['tc_sum']) * 100))).toFixed(2))
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    BranchObj[`${key}`]['billing_per'] = parseFloat(((((BranchObj[`${key}`]['billed_sum'])/(BranchObj[`${key}`]['Coverage']) * 100))).toFixed(2))
                }else{
                    obj={
                        'filter_key': mergedArr[i]['Branch Name'],
                        'billed_sum': mergedArr[i]['billed_sum'],
                        'Coverage': mergedArr[i]['coverage_sum'],
                        'pc_sum': mergedArr[i]['pc_sum'],
                        'tc_sum': mergedArr[i]['tc_sum'],
                        'Channel' : []
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    if(mergedArr[i]['tc_sum'] === 0){mergedArr[i]['tc_sum'] = 1}
                    obj['billing_per'] =  parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                        obj['productivity_per'] =  parseFloat(((mergedArr[i]['pc_sum']) / (mergedArr[i]['tc_sum']) * 100).toFixed(2)),
                        BranchObj[key] = obj
                }
            }


            let ChannelObj = {}
            for(let i in mergedArr){
                let obj = {}
                let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                let Division = sanitizeInput(mergedArr[i]['Division'])
                let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                let ChannelName = sanitizeInput(mergedArr[i]['ChannelName'])
                let key = `${Month}/${Division}/${Site_Name}/${Branch_Name}/${ChannelName}`
                if(mergedArr[i]['billed_sum'] == null){mergedArr[i]['billed_sum'] = 0}
                if(mergedArr[i]['coverage_sum'] == null){mergedArr[i]['coverage_sum'] = 0}
                if(mergedArr[i]['pc_sum'] == null){mergedArr[i]['pc_sum'] = 0}
                if(mergedArr[i]['tc_sum'] == null){mergedArr[i]['tc_sum'] = 0}
                if(mergedArr[i]['productivity_per'] == null){mergedArr[i]['productivity_per'] = 0}
                if (key in ChannelObj){
                    ChannelObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                    ChannelObj[`${key}`]['Coverage'] += mergedArr[i]['coverage_sum']
                    ChannelObj[`${key}`]['pc_sum'] += mergedArr[i]['pc_sum']
                    ChannelObj[`${key}`]['tc_sum'] += mergedArr[i]['tc_sum']
                    if(ChannelObj[`${key}`]['tc_sum'] === 0){
                        ChannelObj[`${key}`]['productivity_per'] = parseFloat(((((ChannelObj[`${key}`]['pc_sum'])/(1) * 100))).toFixed(2))
                    }else{
                        ChannelObj[`${key}`]['productivity_per'] = parseFloat(((((ChannelObj[`${key}`]['pc_sum'])/(ChannelObj[`${key}`]['tc_sum']) * 100))).toFixed(2))
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    ChannelObj[`${key}`]['billing_per'] = parseFloat(((((ChannelObj[`${key}`]['billed_sum'])/(ChannelObj[`${key}`]['Coverage']) * 100))).toFixed(2))
                }else{
                    obj={
                        'filter_key': mergedArr[i]['ChannelName'],
                        'billed_sum': mergedArr[i]['billed_sum'],
                        'Coverage': mergedArr[i]['coverage_sum'],
                        'pc_sum': mergedArr[i]['pc_sum'],
                        'tc_sum': mergedArr[i]['tc_sum'],
                        'SubChannel' : []
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    if(mergedArr[i]['tc_sum'] === 0){mergedArr[i]['tc_sum'] = 1}
                    obj['billing_per'] =  parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                        obj['productivity_per'] =  parseFloat(((mergedArr[i]['pc_sum']) / (mergedArr[i]['tc_sum']) * 100).toFixed(2)),
                        ChannelObj[key] = obj
                }
            }


            let subChannelObj = {}
            for(let i in mergedArr){
                let obj = {}
                let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                let Division = sanitizeInput(mergedArr[i]['Division'])
                let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                let ChannelName = sanitizeInput(mergedArr[i]['ChannelName'])
                let SubChannelName = sanitizeInput(mergedArr[i]['SubChannelName'])
                let key = `${Month}/${Division}/${Site_Name}/${Branch_Name}/${ChannelName}/${SubChannelName}`
                if(mergedArr[i]['billed_sum'] == null){mergedArr[i]['billed_sum'] = 0}
                if(mergedArr[i]['coverage_sum'] == null){mergedArr[i]['coverage_sum'] = 0}
                if(mergedArr[i]['pc_sum'] == null){mergedArr[i]['pc_sum'] = 0}
                if(mergedArr[i]['tc_sum'] == null){mergedArr[i]['tc_sum'] = 0}
                if(mergedArr[i]['productivity_per'] == null){mergedArr[i]['productivity_per'] = 0}
                if (key in subChannelObj){
                    subChannelObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                    subChannelObj[`${key}`]['Coverage'] += mergedArr[i]['coverage_sum']
                    subChannelObj[`${key}`]['pc_sum'] += mergedArr[i]['pc_sum']
                    subChannelObj[`${key}`]['tc_sum'] += mergedArr[i]['tc_sum']
                    if(subChannelObj[`${key}`]['tc_sum'] === 0){
                        subChannelObj[`${key}`]['productivity_per'] = parseFloat(((((subChannelObj[`${key}`]['pc_sum'])/(1) * 100))).toFixed(2))
                    }else{
                        subChannelObj[`${key}`]['productivity_per'] = parseFloat(((((subChannelObj[`${key}`]['pc_sum'])/(subChannelObj[`${key}`]['tc_sum']) * 100))).toFixed(2))
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    subChannelObj[`${key}`]['billing_per'] = parseFloat(((((subChannelObj[`${key}`]['billed_sum'])/(subChannelObj[`${key}`]['Coverage']) * 100))).toFixed(2))
                }else{
                    obj={
                        'filter_key': mergedArr[i]['SubChannelName'],
                        'billed_sum': mergedArr[i]['billed_sum'],
                        'Coverage': mergedArr[i]['coverage_sum'],
                        'pc_sum': mergedArr[i]['pc_sum'],
                        'tc_sum': mergedArr[i]['tc_sum']
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    if(mergedArr[i]['tc_sum'] === 0){mergedArr[i]['tc_sum'] = 1}
                    obj['billing_per'] =  parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                        obj['productivity_per'] =  parseFloat(((mergedArr[i]['pc_sum']) / (mergedArr[i]['tc_sum']) * 100).toFixed(2)),
                        subChannelObj[key] = obj
                }
            }


            DivisionObj = getFormattedNoObj(DivisionObj)
            SiteObj = getFormattedNoObj(SiteObj)
            BranchObj = getFormattedNoObj(BranchObj)
            ChannelObj = getFormattedNoObj(ChannelObj)
            subChannelObj = getFormattedNoObj(subChannelObj)

            for( let i in subChannelObj){
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                ChannelObj[key]['SubChannel'].push(subChannelObj[i])
            }

            for( let i in ChannelObj){
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                BranchObj[key]['Channel'].push(ChannelObj[i])
            }

            for( let i in BranchObj){
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                SiteObj[key]['Branch'].push(BranchObj[i])
            }

            for( let i in SiteObj){
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                DivisionObj[key]['Site'].push(SiteObj[i])
            }




            let divList = []
            for(let i in DivisionObj){
                divList.push(DivisionObj[i])
            }

            let sql_query_no_of_billing_current_year
            let sql_query_no_of_productivity_current_year

            if(channel.length === 0){
                if(filter_data === 'allIndia'){
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where Division in ('N-E', 'S-W') and [Calendar Month] = '${calendar_month_cy}'`
                    sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W')`
                }
                else{
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
                    sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}'`
                }
            }else {
                if(filter_data === 'allIndia'){
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where Division in ('N-E', 'S-W') and [Calendar Month] = '${calendar_month_cy}' and [ChannelName] in (${channel})`
                    sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and [ChannelName] in (${channel}) `
                }
                else{
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}' and [ChannelName] in (${channel}) `
                    sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' and [ChannelName] in (${channel}) `
                }
            }
            let connection = await getConnection()
            let billing_and_coverage_data = await getQueryData(connection, sql_query_no_of_billing_current_year)
            // let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)
            connection = await getConnection()
            let productivity_data = await getQueryData(connection, sql_query_no_of_productivity_current_year)
            // let productivity_data = await sequelize.query(sql_query_no_of_productivity_current_year)
            let billing = 0
            let productivity_call = 0
            let productivity_target = 1
            let coverage = 1
            let target_calls = 1

            if(billing_and_coverage_data !== undefined){
                billing = billing_and_coverage_data[0]['billed_sum']
                coverage = billing_and_coverage_data[0]['coverage_sum']
            }

            if(productivity_data !== undefined){
                productivity_call = productivity_data[0]['pro_sum']
                productivity_target = productivity_data[0]['target_sum']
            }

            if(billing === null){billing = 0}
            if(coverage === null){coverage = 1}
            if(productivity_call === null){productivity_call = 0}
            if(productivity_target === null){productivity_target = 1}
            if(coverage === 0){coverage = 1}
            let billing_per = (billing / coverage) * 100
            let productivity_per = (productivity_call / productivity_target) * 100
            if(coverage === 1){coverage = 0}

            let objData = {
                "billing_per": parseInt(`${billing_per}`.split(".")[0]),
                "Coverage": getFormattedNo(coverage),
                "productivity_per": parseInt(productivity_per.toFixed(2).split(".")[0])
            }
            if(filter_data === 'allIndia'){filter_data = 'All India'}
            objData['filter_key'] = `${filter_data}`
            objData['channel'] = channel_list
            objData['month'] = `${date}`
            objData["division"] = divList
            final_data.push([objData])


        }

        return (final_data);
        // console.timeEnd('api start')


    }catch (e) {
        console.log('error',e)
        return e
        // res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getDeepDivePageDataBySubChannel2 = async (req, res) => {
    try {
        let time_to_live = 7*24*60*60*1000 // Time in milliseconds for 7 days
        let cacheKey = 'coverageDeepDiveData'
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
                                    cacheData[k]['resData'][n][0]['id'] = uuidv4()
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
                    finalData[i][0]['id'] = uuidv4()
                    matchedDataList.push(finalData[i])
                    cacheData[0]['reqBody'].push(nonMatchedIndex[i])
                    cacheData[0]['resData'].push(finalData[i])
                    console.log("Putting data into cache")
                }else{
                    console.log("There is no data for this query");
                }
            }
            let checkDublicate = {}
            for(let i in matchedDataList){
                let key = matchedDataList[i][0]['id']
                checkDublicate[key] = matchedDataList[i]
            }
            let nonDulbicateList = []
            for(let i in checkDublicate){
                nonDulbicateList.push(checkDublicate[i])
            }
            res.status(200).json(nonDulbicateList);
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
    getDeepDivePageData,
    getDeepDivePageDataByBranch,
    getDeepDivePageDataBySubChannel,
    getDeepDivePageDataBySubChannel2
}

