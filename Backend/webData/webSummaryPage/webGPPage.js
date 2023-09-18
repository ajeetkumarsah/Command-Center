const {sequelize} = require('../../databaseConnection/sql_connection');

function getFormatedNumberValue(value){
    let formatedValue = '0'
    console.log("Your Value Before Format", value)
    // if(value>=1000000000 ){
    //     let a = 10110273179.49
    //      formatedValue = ((value/1000000000).toFixed(2).split(".")[0])+'Th Cr'
    // }

    // if(value>=10000000 ){
    //     formatedValue = ((value/10000000).toFixed(2).split(".")[0])+'Cr'
    // }

    if(value>=100000){
        formatedValue = ((value/100000).toFixed(2).split(".")[0])+'MM'
    }

    else if(value>=1000 && value<100000){
        formatedValue = ((value/1000).toFixed(2).split(".")[0])+'M'
    }
    console.log("Your Value After Format", formatedValue)
    return formatedValue
}

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
        let previous_year_gp = `CY${parseInt(date.split("-")[1])-1}-${date.split("-")[0]}`
        let current_year_gp = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}
        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}

        let gp_new_query_current_year
        let gp_new_query_previous_year
        if(filter_data === 'allIndia'){
            filter_data = "%"
            // let gp_new_query_current_year = `select [Golden Points Gap Filled - P3M], [Golden Points Target] from [dbo].[tbl_command_center_gp_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${current_year_gp}'`
            gp_new_query_current_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [Calender Year] = '${current_year_gp}' and [Division] not in ('')`
            // gp_new_query_previous_year = `select [Golden Points Gap Filled - P3M], [Golden Points Target] from [dbo].[tbl_command_center_gp_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${previous_year_gp}'`
            gp_new_query_previous_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [Calender Year] = '${previous_year_gp}' and [Division] not in ('')`

        }
        else{
            gp_new_query_current_year = `select [Golden Points Gap Filled - P3M] as gp_gap_fill_sum, [Golden Points Target] as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${current_year_gp}'`
            // gp_new_query_current_year_all_india = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [Calender Year] = '${current_year_gp}' and [Division] not in ('')`
            gp_new_query_previous_year = `select [Golden Points Gap Filled - P3M] as gp_gap_fill_sum, [Golden Points Target] as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${previous_year_gp}'`
            // let gp_new_query_previous_year_all_india = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [Calender Year] = '${previous_year_gp}' and [Division] not in ('')`

        }

        // let gp_new_query_current_year = `select [Golden Points Gap Filled - P3M], [Golden Points Target] from [dbo].[tbl_command_center_gp_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${current_year_gp}'`
        // // let gp_new_query_current_year_all_india = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [Calender Year] = '${current_year_gp}' and [Division] not in ('')`
        // let gp_new_query_previous_year = `select [Golden Points Gap Filled - P3M], [Golden Points Target] from [dbo].[tbl_command_center_gp_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${previous_year_gp}'`
        // // let gp_new_query_previous_year_all_india = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [Calender Year] = '${previous_year_gp}' and [Division] not in ('')`

        let gp_gf_p3m_current_year = await sequelize.query(gp_new_query_current_year)
        // let gp_gf_p3m_current_year_all_india = await sequelize.query(gp_new_query_current_year_all_india)

        let gp_target_current_year = 1
        if(gp_gf_p3m_current_year[0][0] === undefined){
            gp_gf_p3m_current_year = 0
        }else {
            gp_target_current_year = gp_gf_p3m_current_year[0][0]['gp_target_sum']
            gp_gf_p3m_current_year = gp_gf_p3m_current_year[0][0]['gp_gap_fill_sum']
        }

        // let gp_target_current_year_all_india = 1
        // if(gp_gf_p3m_current_year_all_india[0][0] === undefined){
        //     gp_gf_p3m_current_year_all_india = 0
        // }else {
        //     gp_target_current_year_all_india = gp_gf_p3m_current_year_all_india[0][0]['gp_target_sum']
        //     gp_gf_p3m_current_year_all_india = gp_gf_p3m_current_year_all_india[0][0]['gp_gap_fill_sum']
        // }


        let gp_target_previous_year = 1
        let gp_gf_p3m_previous_year = await sequelize.query(gp_new_query_previous_year)
        if(gp_gf_p3m_previous_year[0][0] === undefined){
            gp_target_previous_year = 1
            gp_gf_p3m_previous_year = 1
        }
        else {
            gp_target_previous_year = gp_gf_p3m_previous_year[0][0]['gp_target_sum']
            gp_gf_p3m_previous_year = gp_gf_p3m_previous_year[0][0]['gp_gap_fill_sum']
        }

        // let gp_target_previous_year_all_india = 1
        // let gp_gf_p3m_previous_year_all_india = await sequelize.query(gp_new_query_previous_year_all_india)
        // if(gp_gf_p3m_previous_year_all_india[0][0] === undefined){
        //     gp_target_previous_year_all_india = 1
        //     gp_gf_p3m_previous_year_all_india = 1
        // }
        // else {
        //     gp_target_previous_year_all_india = gp_gf_p3m_previous_year_all_india[0][0]['gp_target_sum']
        //     gp_gf_p3m_previous_year_all_india = gp_gf_p3m_previous_year_all_india[0][0]['gp_gap_fill_sum']
        // }

        if(gp_gf_p3m_current_year === null || gp_gf_p3m_current_year === undefined){ gp_gf_p3m_current_year = 0 }
        if(gp_gf_p3m_previous_year === null || gp_gf_p3m_previous_year === undefined){ gp_gf_p3m_previous_year = 1 }
        if(gp_target_current_year === null || gp_target_current_year === undefined){ gp_target_current_year = 1 }

        // if(gp_gf_p3m_current_year_all_india === null || gp_gf_p3m_current_year_all_india === undefined){ gp_gf_p3m_current_year_all_india = 0 }
        // if(gp_gf_p3m_previous_year_all_india === null || gp_gf_p3m_previous_year_all_india === undefined){ gp_gf_p3m_previous_year_all_india = 1 }
        // if(gp_target_current_year_all_india === null || gp_target_current_year_all_india === undefined){ gp_target_current_year_all_india = 1 }

        let gp_iya = (gp_gf_p3m_current_year / gp_gf_p3m_previous_year) * 100
        let gp_achievement = (gp_gf_p3m_current_year / gp_target_current_year) * 100
        let gp_abs = gp_gf_p3m_current_year

        // let gp_iya_all_india = (gp_gf_p3m_current_year_all_india / gp_gf_p3m_previous_year_all_india) * 100
        // let gp_achievement_all_india = (gp_gf_p3m_current_year_all_india / gp_target_current_year_all_india) * 100
        // let gp_abs_all_india = gp_gf_p3m_current_year_all_india

        // while (gp_abs>1000){gp_abs = gp_abs/100}
        // while (gp_abs_all_india>1000){gp_abs_all_india = gp_abs_all_india/100}
        // while (fb_iya_all_india>1000){fb_iya_all_india = fb_iya_all_india/100}
        // while (fb_achieved_current_year_all_india>1000){fb_achieved_current_year_all_india = fb_achieved_current_year_all_india/100}

        gp_abs = getFormatedNumberValue(gp_abs)

        let dgpcompliance ={
            // "gpAchievememt": (gp_achievement).toFixed(2),
            "gpAbs": (gp_abs),
            "gpIYA": (gp_iya).toFixed(2),
            // "gpAchievememtAllIndia": (gp_achievement_all_india).toFixed(2),
            // "gpAbsAllIndia": (gp_abs_all_india).toFixed(2),
            // "gpIYAAllIndia": (gp_iya_all_india).toFixed(2),
        }
        if(filter_data === '%'){filter_data = 'All India'}
        dgpcompliance['filter'] = `${filter_data}`
        dgpcompliance['month'] = `${date}`
        data["dgpCompliance"]=(dgpcompliance)

        res.status(200).json([data]);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

module.exports = {
    getSummaryPageData
}
