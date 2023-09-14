const {sequelize} = require('../../databaseConnection/sql_connection');


function getFormatedNumberValue(value){
    value = parseFloat(value)
    let formatedValue = '0'
    console.log("Your Value Before Format", value)
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
        let previous_year_fb = `CY${parseInt(date.split("-")[1])-1}-${date.split("-")[0]}`
        let current_year_fb = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}
        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}

        let new_fb_query
        if(filter_data === 'allIndia'){
            new_fb_query = `select sum([FB Points achieved]) as fb_achieved_sum , sum([FB Target]) as fb_target_sum  FROM [dbo].[tbl_command_center_fb_new2] where [Division] in ('N-E','S-W') and [Calendar Month] like '${current_year_fb}'`
        }
        else{
            new_fb_query = `select sum([FB Points achieved]) as fb_achieved_sum , sum([FB Target]) as fb_target_sum  FROM [dbo].[tbl_command_center_fb_new2] where [${filter_key}] = '${filter_data}' and [Calendar Month] like '${current_year_fb}'`
        }

        // let new_fb_query_all_india = `select sum([FB Points achieved Sum]) as fb_achieved_sum, sum([FB Target Sum]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [Division] not in ('') and [Calender Year] like '${current_year_fb}' `
        let fb_data = await sequelize.query(new_fb_query)
        // let fb_data_all_india = await sequelize.query(new_fb_query_all_india)
        let fb_achieved_current_year = 0
        let fb_target_current_year = 1
        // let fb_achieved_current_year_all_india = 0
        // let fb_target_current_year_all_india = 1
        if(fb_data[0][0] !== undefined){
            fb_achieved_current_year = fb_data[0][0]['fb_achieved_sum']
            fb_target_current_year = fb_data[0][0]['fb_target_sum']
        }
        // if(fb_data_all_india[0][0] !== undefined){
        //     fb_achieved_current_year_all_india = fb_data_all_india[0][0]['fb_achieved_sum']
        //     fb_target_current_year_all_india = fb_data_all_india[0][0]['fb_target_sum']
        // }
        if(fb_target_current_year === 0){fb_target_current_year = 1}
        let fb_iya = (fb_achieved_current_year / fb_target_current_year) * 100
        // let fb_iya_all_india = (fb_achieved_current_year_all_india / fb_target_current_year_all_india) * 100
        if(fb_target_current_year === 1){fb_target_current_year = 0}

        // while (fb_iya>1000){fb_iya = fb_iya/100}
        // while (fb_achieved_current_year>1000){fb_achieved_current_year = fb_achieved_current_year/100}
        // while (fb_iya_all_india>1000){fb_iya_all_india = fb_iya_all_india/100}
        // while (fb_achieved_current_year_all_india>1000){fb_achieved_current_year_all_india = fb_achieved_current_year_all_india/100}

        fb_achieved_current_year = getFormatedNumberValue(fb_achieved_current_year)
        fb_target_current_year = getFormatedNumberValue(fb_target_current_year)

        let focusbrand ={
            "fbActual": fb_achieved_current_year,
            "fbTarget": fb_target_current_year,
            // "fbActualAllIndia": parseInt(fb_achieved_current_year_all_india).toFixed(2).split(".")[0],
            "fbIYA": (parseInt(fb_iya).toFixed(2).split(".")[0]),
            // "fbAchievementAllIndia": (parseInt(fb_iya_all_india).toFixed(2).split(".")[0]),
        }
        if(filter_data === "allIndia"){filter_data = "All India"}
        focusbrand['filter'] = `${filter_data}`
        focusbrand['month'] = `${date}`

        data["focusBrand"]=(focusbrand)

        res.status(200).json([data]);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: e})
    }
}

module.exports = {
    getSummaryPageData
}
