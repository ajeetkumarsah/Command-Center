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


function addArrays(array1, array2) {
    if (array1.length !== array2.length) {
        throw new Error('Arrays must have the same length');
    }

    return array1.map((element, index) => element + array2[index]);
}

function getGeoType(geo){
    if(geo === 'division'){
        return 'Division'
    }else if(geo === 'cluster'){
        return 'Cluster'
    }else if(geo === 'site'){
        return 'Site Name'
    }else if(geo === 'branch'){
        return 'Branch Name'
    }
}

function getQuery(month, geo, geoData){
    let billingQuery = ''
    let productivityQuery = ''
    if(geo === 'allIndia'){
        billingQuery = `SELECT
                                SUM([No of stores billed atleast once]) AS billed_sum,
                                SUM([Coverage]) AS coverage_sum, [ChannelName]
                            FROM
                                [dbo].[tbl_command_center_billing_new]
                            WHERE
                                Division IN ('N-E', 'S-W')
                                AND [Calendar Month] = '${month}'
                                AND ChannelName not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B','IMR', 'Dcom')
                                GROUP BY [ChannelName]`

        productivityQuery = `SELECT
                                SUM([Productive Calls]) AS pro_sum,
                                SUM([Target Calls]) AS target_sum, [ChannelName]
                            FROM
                                [dbo].[tbl_command_center_productivity_new]
                            WHERE
                                [Calendar Month] = '${month}'
                                AND Division IN ('N-E', 'S-W')
                                AND ChannelName not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B','IMR', 'Dcom')
                                GROUP BY [ChannelName]`
    }else{
        let geoType = getGeoType(geo)
        billingQuery = `SELECT
                                SUM([No of stores billed atleast once]) AS billed_sum,
                                SUM([Coverage]) AS coverage_sum, [ChannelName]
                            FROM
                                [dbo].[tbl_command_center_billing_new]
                            WHERE
                                [${geoType}] = '${geoData}'
                                AND [Calendar Month] = '${month}'
                                AND ChannelName not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B','IMR', 'Dcom')
                                GROUP BY [ChannelName]`

        productivityQuery = `SELECT
                                SUM([Productive Calls]) AS pro_sum,
                                SUM([Target Calls]) AS target_sum, [ChannelName]
                            FROM
                                [dbo].[tbl_command_center_productivity_new]
                            WHERE
                                [Calendar Month] = '${month}'
                                AND [${geoType}] = '${geoData}'
                                AND ChannelName not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B','IMR', 'Dcom')
                                GROUP BY [ChannelName]`
    }

    return `SELECT
                billed_sum,
                coverage_sum,
                pro_sum,
                target_sum,
                billing_data.ChannelName
            FROM
                (${billingQuery}) AS billing_data
            LEFT JOIN
                (${productivityQuery}) AS productivity_data
            ON billing_data.ChannelName = productivity_data.ChannelName;`
}


let getCoverageDataByChannel = async (reqData) =>{
    try{

        let final_data = []
        for(let i in reqData){
            let reqDate = ''
            let data = reqData[i]
            let date = data.date;
            reqDate = date
            let filter_key;
            let filter_data;
            let filter_type = data
            delete filter_type.date;
            for (let key in filter_type) {
                filter_key = key
                filter_data = filter_type[key]
            }

            let calendar_month_cy = `CY${date.split("-")[1]}-${date.split("-")[0]}`
            // let calendar_month_cy = getPNMList(date, 3)
            if (filter_data === "South-West") {
                filter_data = "S-W"
            }
            if (filter_data === "North-East") {
                filter_data = "N-E"
            }

            let sqlQuery = getQuery(calendar_month_cy, filter_key, filter_data)

            let connection = await getConnection()
            let categories_data_cc = await getQueryData(connection, sqlQuery)
            for(let i in categories_data_cc){

                categories_data_cc[i]['billed_sum'] = (categories_data_cc[i]['billed_sum'] !== null) && (categories_data_cc[i]['billed_sum'] !== undefined) ? categories_data_cc[i]['billed_sum'] : 0
                categories_data_cc[i]['coverage_sum'] = (categories_data_cc[i]['coverage_sum'] !== null) && (categories_data_cc[i]['coverage_sum'] !== undefined) ? categories_data_cc[i]['coverage_sum'] : 1
                categories_data_cc[i]['pro_sum'] = (categories_data_cc[i]['pro_sum'] !== null) && (categories_data_cc[i]['pro_sum'] !== undefined) ? categories_data_cc[i]['pro_sum'] : 0
                categories_data_cc[i]['target_sum'] = (categories_data_cc[i]['target_sum'] !== null) && (categories_data_cc[i]['target_sum'] !== undefined) ? categories_data_cc[i]['target_sum'] : 1

                categories_data_cc[i]['billing_per'] = ((categories_data_cc[i]['billed_sum'] / categories_data_cc[i]['coverage_sum']) * 100).toFixed(2)
                categories_data_cc[i]['productivity_per'] = ((categories_data_cc[i]['pro_sum'] / categories_data_cc[i]['target_sum']) * 100).toFixed(2)
            }
            final_data.push(categories_data_cc)
        }
        return final_data

    }catch (e) {
        console.log('error', e)
        // res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

module.exports = {
    getCoverageDataByChannel
}

