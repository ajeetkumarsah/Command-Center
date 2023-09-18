const {sequelize} = require('../../databaseConnection/sql_connection');

function getFormatedNumberValue(value){
    let formatedValue = '0'
    console.log("Your Value Before Format", value)
    // if(value>=1000000000 ){
    //     let a = 10110273179.49
    //      formatedValue = ((value/1000000000).toFixed(2).split(".")[0])+'Th Cr'
    // }

    if(value>=10000000 ){
        formatedValue = ((value/10000000).toFixed(2).split(".")[0])+'Cr'
    }

    else if(value>=100000 && value<10000000){
        formatedValue = ((value/100000).toFixed(2).split(".")[0])+'Lk'
    }

    // else if(value>=1000 && value<100000){
    //     formatedValue = ((value/100000).toFixed(2).split(".")[0])+'K'
    // }
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

        let current_year_rt = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        let previous_year_rt = `CY${parseInt(date.split("-")[1])-1}-${date.split("-")[0]}`

        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}
        if(filter_key==="allIndia"){filter_key="Division"
            filter_data = "allIndia"
        }

        let new_rt_query_current_month
        let new_rt_query_previous_month

        if(filter_data === 'allIndia'){
            filter_data = "%"
            // let new_rt_query_current_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_rt}'`
            new_rt_query_current_month = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${current_year_rt}' and [Division] not in ('') `
            new_rt_query_previous_month = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${previous_year_rt}' and [Division] not in ('') `
            // new_rt_query_previous_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_rt}'`

        }
        else{
            new_rt_query_current_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_rt}'`
            // new_rt_query_current_month_all_india = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${current_year_rt}' and [Division] not in ('') `
            // new_rt_query_previous_month_all_india = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${previous_year_rt}' and [Division] not in ('') `
            new_rt_query_previous_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_rt}'`

        }


        // let new_rt_query_current_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_rt}'`
        // // let new_rt_query_current_month_all_india = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${current_year_rt}' and [Division] not in ('') `
        // // let new_rt_query_previous_month_all_india = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${previous_year_rt}' and [Division] not in ('') `
        // let new_rt_query_previous_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_rt}'`
        let rt_data_current_month = await sequelize.query(new_rt_query_current_month)
        // let rt_data_current_month_all_india = await sequelize.query(new_rt_query_current_month_all_india)
        // let rt_data_previous_month_all_india = await sequelize.query(new_rt_query_previous_month_all_india)
        let rt_data_previous_month = await sequelize.query(new_rt_query_previous_month)
        let retailing_sum_current_month = 0
        // let retailing_sum_current_month_all_india = 1
        // let retailing_sum_previous_month_all_india = 1
        let retailing_sum_previous_month = 1
        if(rt_data_current_month[0][0] !== undefined){
            retailing_sum_current_month = rt_data_current_month[0][0]['Retailing_Sum']
        }
        // if(rt_data_current_month_all_india[0][0] !== undefined){
        //     retailing_sum_current_month_all_india = rt_data_current_month_all_india[0][0]['Retailing_Sum']
        // }
        // if(rt_data_previous_month_all_india[0][0] !== undefined){
        //     retailing_sum_previous_month_all_india = rt_data_previous_month_all_india[0][0]['Retailing_Sum']
        // }
        if(rt_data_previous_month[0][0] !== undefined){
            retailing_sum_previous_month = rt_data_previous_month[0][0]['Retailing_Sum']
        }

        // if(retailing_sum_current_month_all_india === 0 || retailing_sum_current_month_all_india === null){
        //     retailing_sum_current_month_all_india = 1
        // }
        // if(retailing_sum_previous_month_all_india === 0 || retailing_sum_previous_month_all_india === null){
        //     retailing_sum_previous_month_all_india =1
        // }

        if(retailing_sum_previous_month===null || retailing_sum_previous_month===0 || retailing_sum_previous_month===undefined){retailing_sum_previous_month=1}
        let rt_iya = (retailing_sum_current_month / retailing_sum_previous_month) * 100
        // let rt_saliance = (retailing_sum_current_month / retailing_sum_current_month_all_india) * 100

        // if(retailing_sum_previous_month_all_india === 1 && retailing_sum_current_month_all_india === 1){
        //     retailing_sum_current_month_all_india  = 0
        // }
        // let rt_iya_all_india = (retailing_sum_current_month_all_india / retailing_sum_previous_month_all_india) * 100

        // while(rt_iya_all_india>1000){rt_iya_all_india = rt_iya_all_india/100}

        while(rt_iya>1000){rt_iya = rt_iya/100}

        retailing_sum_current_month = getFormatedNumberValue(retailing_sum_current_month)
        // while(retailing_sum_current_month>1000){retailing_sum_current_month = retailing_sum_current_month/100}

        let mtdRetailing = {
            "cmIya": (rt_iya).toFixed(2).split('.')[0],
            // "cmTarget": (rt_saliance).toFixed(2).split('.')[0],
            "cmSellout": (retailing_sum_current_month),
            // "cmIyaAllIndia": (rt_iya_all_india).toFixed(2).split('.')[0],
        }
        if(filter_data === '%'){filter_data = 'All India'}
        mtdRetailing['filter'] = `${filter_data}`
        mtdRetailing['month'] = `${date}`
        data["mtdRetailing"]=(mtdRetailing)

        res.status(200).json([data]);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

module.exports = {
    getSummaryPageData
}
