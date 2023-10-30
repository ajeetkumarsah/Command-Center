// const {sequelize} = require('../../databaseConnection/sql_connection');
const {getConnection, getQueryData} = require('../../databaseConnection/dbConnection');

let getSummaryPageData = async (req, res) =>{
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

        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}
        if(filter_key==="allIndia"){filter_key="Division"
            filter_data = "allIndia"
        }

        let calendar_month_cy = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}
        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}

        let sql_query_no_of_billing_current_year
        if(filter_data === 'allIndia'){
            filter_data = "%"
            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum  FROM [dbo].[tbl_command_center_billing_new] where [Division] in ('N-E', 'S-W') and [Calendar Month] = '${calendar_month_cy}' `

        }
        else{
            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}' `

        }

        // let sql_query_no_of_billing_current_year_all_india = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum  FROM [dbo].[tbl_command_center_billing_calculation] where [Division] not in ('') and [Calendar Month] = '${calendar_month_cy}'`
        // let new_producitivity_query_current_month_all_india = `select sum ([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_calculation] where [Division] not in ('') and [Calendar Month] = '${calendar_month_cy}'`

        // let sql_query_no_of_billing_current_year = `select [No of stores billed atleast once] as billed_sum , [Coverage] as coverage_sum from [dbo].[tbl_command_center_billing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}' and ChannelName is NULL`
        // let new_producitivity_query_current_month = `select [Productive Calls] as productivity_calls, [Target Calls] as target_calls FROM [dbo].[tbl_command_center_productivity_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`

        let connection = await getConnection()
        let billing_and_coverage_data = await getQueryData(connection, sql_query_no_of_billing_current_year)
        // let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)
        // let productivity_data = await sequelize.query(new_producitivity_query_current_month)

        // let billing_and_coverage_data_all_india = await sequelize.query(sql_query_no_of_billing_current_year_all_india)
        // let productivity_data_all_india = await sequelize.query(new_producitivity_query_current_month_all_india)

        let billing = 0
        let coverage = 1
        // let productive_calls = 0
        let target_calls = 1


        // let billing_all_india = 0
        // let coverage_all_india = 0
        // let productive_calls_all_india = 0
        // let target_calls_all_india = 1


        if(billing_and_coverage_data[0] !== undefined && billing_and_coverage_data[0]['billed_sum'] !== null){
            billing = billing_and_coverage_data[0]['billed_sum']
            coverage = billing_and_coverage_data[0]['coverage_sum']
        }
        // if(productivity_data[0][0] !== undefined) {
        //     productive_calls = productivity_data[0][0]['productivity_calls']
        //     target_calls = productivity_data[0][0]['target_calls']
        // }

        // if(billing_and_coverage_data_all_india[0][0] !== undefined){
        //     billing_all_india = billing_and_coverage_data_all_india[0][0]['billed_sum']
        //     coverage_all_india = billing_and_coverage_data_all_india[0][0]['coverage_sum']
        // }
        // if(productivity_data_all_india[0][0] !== undefined) {
        //     productive_calls_all_india = productivity_data_all_india[0][0]['productivity_calls']
        //     target_calls_all_india = productivity_data_all_india[0][0]['target_calls']
        // }

        if(coverage === 0){coverage = 1}
        let billing_per = (billing / coverage) * 100
        if(coverage === 1){coverage = 0}
        // let productivity_per = (productive_calls / target_calls) * 100

        // let billing_per_all_india = (billing_all_india / coverage_all_india) * 100
        // let productivity_per_all_india = (productive_calls_all_india / target_calls_all_india) * 100

        // while(productivity_per>100){productivity_per = productivity_per / 100}
        // while(productivity_per_all_india>100){productivity_per_all_india = productivity_per_all_india / 100}
        while(billing_per>100){billing_per = billing_per / 100}
        // while(billing_per_all_india>100){billing_per_all_india = billing_per_all_india / 100}
        while(coverage>1000){coverage = coverage / 100}
        // while(coverage_all_india>1000){coverage_all_india = coverage_all_india / 100}

        let objData = {
            "Billing_Per": parseInt(`${billing_per}`.split(".")[0]),
            "Coverage": parseInt(coverage.toFixed(2).split(".")[0]),
            // "Productive Calls": parseInt(`${productivity_per}`.split(".")[0]),
            // "BillingAllIndia": parseInt(`${billing_per_all_india}`.split(".")[0]),
            // "CoverageAllIndia": parseInt(coverage_all_india.toFixed(2).split(".")[0]),
            // "ProductiveCallsAllIndia": parseInt(`${productivity_per_all_india}`.split(".")[0]),
        }
        if(filter_data === '%'){filter_data = 'All India'}
        objData['filter'] = `${filter_data}`
        objData['month'] = `${date}`
        data["coverage"]=(objData)

        res.status(200).json([data]);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.' })
    }
}

module.exports = {
    getSummaryPageData
}
