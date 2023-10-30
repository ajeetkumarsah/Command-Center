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
        let previous_year_cc = `CY${parseInt(date.split("-")[1])-1}-${date.split("-")[0]}`
        let current_year_cc = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}
        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}

        let cc_new_query_current_year
        let cc_new_query_previous_year
        if(filter_data === 'allIndia'){
            filter_data = "%"
            // let cc_new_query_current_year = `select [Calls Made], [Target Calls] from [dbo].[tbl_command_center_cc_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_cc}' `
            cc_new_query_current_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_calculation] where [Calendar Month] = '${current_year_cc}' and [Division] not in ('')`
            // cc_new_query_previous_year = `select [Calls Made], [Target Calls] from [dbo].[tbl_command_center_cc_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_cc}' `
            cc_new_query_previous_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_calculation] where [Calendar Month] = '${previous_year_cc}' and [Division] not in ('')`
        }
        else{
            cc_new_query_current_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_cc}' `
            // cc_new_query_current_year_all_india = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_calculation] where [Calendar Month] = '${current_year_cc}' and [Division] not in ('')`
            cc_new_query_previous_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_cc}' `
            // let cc_new_query_previous_year_all_india = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_calculation] where [Calendar Month] = '${previous_year_cc}' and [Division] not in ('')`

        }
        let connection = await getConnection()
        let cc_achieved_current_year = await getQueryData(connection, cc_new_query_current_year)
        // let cc_achieved_current_year = await sequelize.query(cc_new_query_current_year)

        let cc_target_current_year = 1
        if(cc_achieved_current_year[0] !== undefined && cc_achieved_current_year[0]['target_calls_sum'] !== null){
            cc_target_current_year = cc_achieved_current_year[0]['target_calls_sum']
            cc_achieved_current_year = cc_achieved_current_year[0]['calls_made_sum']
        }else{
            cc_achieved_current_year = 0
        }

        // let cc_achieved_current_year_all_india = await sequelize.query(cc_new_query_current_year_all_india)

        // let cc_target_current_year_all_india = 1
        // if(cc_achieved_current_year_all_india[0][0] !== undefined){
        //     cc_target_current_year_all_india = cc_achieved_current_year_all_india[0][0]['target_calls_sum']
        //     cc_achieved_current_year_all_india = cc_achieved_current_year_all_india[0][0]['calls_made_sum']
        // }else{
        //     cc_achieved_current_year_all_india = 0
        // }

        let cc_target_previous_year = 1
        connection = await getConnection()
        let cc_achieved_previous_year = await getQueryData(connection, cc_new_query_previous_year)
        // let cc_achieved_previous_year = await sequelize.query(cc_new_query_previous_year)
        // let cc_achieved_previous_year = await sequelize.query(cc_new_query_previous_year)
        if(cc_achieved_previous_year[0] !== undefined && cc_achieved_previous_year[0]['target_calls_sum'] !== null){
            cc_target_previous_year = cc_achieved_previous_year[0]['target_calls_sum']
            cc_achieved_previous_year = cc_achieved_previous_year[0]['calls_made_sum']
        }else{
            cc_achieved_previous_year = 1
        }

        // let cc_target_previous_year_all_india = 1
        // let cc_achieved_previous_year_all_india = await sequelize.query(cc_new_query_previous_year_all_india)
        // if(cc_achieved_previous_year_all_india[0][0] !== undefined){
        //     cc_target_previous_year_all_india = cc_achieved_previous_year_all_india[0][0]['target_calls_sum']
        //     cc_achieved_previous_year_all_india = cc_achieved_previous_year_all_india[0][0]['calls_made_sum']
        // }else{
        //     cc_achieved_previous_year_all_india = 1
        // }

        if(cc_achieved_current_year === null || cc_achieved_current_year === undefined){ cc_achieved_current_year = 0 }
        if(cc_target_current_year === null || cc_target_current_year === undefined){ cc_target_current_year = 1 }

        let cc_iya_current_month = (cc_achieved_current_year / cc_target_current_year) * 100

        if(cc_achieved_previous_year === null || cc_achieved_previous_year === undefined){ cc_achieved_previous_year = 0 }
        if(cc_target_previous_year === null || cc_target_previous_year === undefined){ cc_target_previous_year = 1 }


        // if(cc_achieved_current_year_all_india === null || cc_achieved_current_year_all_india === undefined){ cc_achieved_current_year_all_india = 0 }
        // if(cc_target_current_year_all_india === null || cc_target_current_year_all_india === undefined){ cc_target_current_year_all_india = 1 }
        //
        // let cc_iya_current_month_all_india = (cc_achieved_current_year / cc_target_current_year) * 100
        //
        // if(cc_achieved_previous_year_all_india === null || cc_achieved_previous_year_all_india === undefined){ cc_achieved_previous_year_all_india = 0 }
        // if(cc_target_previous_year_all_india === null || cc_target_previous_year_all_india === undefined){ cc_target_previous_year_all_india = 1 }


        let cc_iya_previous_month = (cc_achieved_previous_year / cc_target_previous_year) * 100
        // let cc_iya_previous_month_all_india = (cc_achieved_previous_year_all_india / cc_target_previous_year_all_india) * 100

        while (cc_target_current_year>1000){cc_target_current_year = cc_target_current_year/100}
        while (cc_target_previous_year>1000){cc_target_previous_year = cc_target_previous_year/100}
        // while (fb_iya_all_india>1000){fb_iya_all_india = fb_iya_all_india/100}
        // while (fb_achieved_current_year_all_india>1000){fb_achieved_current_year_all_india = fb_achieved_current_year_all_india/100}

        let cc = {
            "ccCurrentMonth": parseFloat(cc_iya_current_month.toFixed(2)),
            "ccCurrentMonthTarget": cc_target_current_year.toFixed(2),
            "ccPreviousMonth": parseFloat(cc_iya_previous_month.toFixed(2)),
            "ccPreviousMonthTarget": cc_target_previous_year.toFixed(2),
            // "ccCurrentMonthAllIndia": cc_iya_current_month_all_india.toFixed(2),
            // "ccPreviousMonthAllIndia": cc_iya_previous_month_all_india.toFixed(2)
        }
        if(filter_data === '%'){filter_data = 'All India'}
        cc['filter'] = `${filter_data}`
        cc['month'] = `${date}`

        data["callCompliance"]=(cc)

        res.status(200).json([data]);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.' })
    }
}

module.exports = {
    getSummaryPageData
}
