const {sequelize} = require('../../../databaseConnection/sql_connection');
const {sequelize2} = require('../../../databaseConnection/sql_connection2');

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

let getDeepDivePageData = async (req, res) =>{

    try {
        let result_data = []
        let data = req.body;
        for(let i in data){
            let date = data[i].date;
            let filter_key;
            let filter_data;
            let filter_type = data[i]
            let channel = data[i].channel
            delete filter_type.date;
            delete filter_type.channel;
            for(let key in filter_type){
                filter_key = key
                filter_data = filter_type[key]
            }

            if(filter_key==="allIndia"){filter_key="Division"
                filter_data = "allIndia"
            }
            if (filter_data === "South-West"){filter_data="S-W"}
            if (filter_data === "North-East"){filter_data="N-E"}

            let p24mList = getPNMList(date, 24)

            let calendar_month_cy = p24mList

            let sql_query_no_of_gp_current_year

            let table_name = ''
            if(filter_key !== 'cluster'){
                table_name = '[tbl_cc_gp_deep_dive_by_division]'
            }else {
                table_name = '[tbl_cc_gp_deep_dive_by_cluster]'
            }

            if(channel === ''){
                if(filter_data === 'allIndia'){
                    sql_query_no_of_gp_current_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gf_sum , sum([Golden Points Target]) as gp_target_sum, [Calendar Month] from [dbo].${table_name} where Division in ('N-E', 'S-W') and [Calendar Month] in (${calendar_month_cy}) group by [Calendar Month] order by [Calendar Month] DESC`
                }
                else{
                    sql_query_no_of_gp_current_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gf_sum , sum([Golden Points Target]) as gp_target_sum, [Calendar Month] from [dbo].${table_name} where [${filter_key}] = '${filter_data}' and [Calendar Month] in (${calendar_month_cy}) group by [Calendar Month] order by [Calendar Month] DESC`
                }
            }else {
                if(filter_data === 'allIndia'){
                    sql_query_no_of_gp_current_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gf_sum , sum([Golden Points Target]) as gp_target_sum, [Calendar Month] from [dbo].${table_name} where Division in ('N-E', 'S-W') and [Calendar Month] in (${calendar_month_cy}) and [ChannelName] = '${channel}' group by [Calendar Month] order by [Calendar Month] DESC`
                }
                else{
                    sql_query_no_of_gp_current_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gf_sum , sum([Golden Points Target]) as gp_target_sum, [Calendar Month] from [dbo].${table_name} where [${filter_key}] = '${filter_data}' and [Calendar Month] in (${calendar_month_cy}) and [ChannelName] = '${channel}' group by [Calendar Month] order by [Calendar Month] DESC`
                }
            }

            let final_data = []

            let gp_and_target_data = await sequelize.query(sql_query_no_of_gp_current_year)

            for(let i in gp_and_target_data[0]){
                let gp = 0
                let target = 1
                let month = ''

                if(gp_and_target_data[0][0] !== undefined){
                    gp = gp_and_target_data[0][i]['gp_gf_sum']
                    target = gp_and_target_data[0][i]['gp_target_sum']
                    month = gp_and_target_data[0][i]['Calendar Month']
                }


                if(gp === null){gp = 0}
                if(target === null){target = 1}
                if(target === 0){target = 1}
                if(month === null){month = ''}
                let gp_per = (gp / target) * 100
                if(target === 1){target = 0}

                let objData = {
                    "GP_Per": parseInt(`${gp_per}`.split(".")[0]),
                    "Month": month,
                    "filter": filter_data
                }
                final_data.push(objData)
            }
            let sortData = []
            let sortList = getPNMList2(date, 24)
            for(let i in sortList){
                for(let j in final_data){
                    if(sortList[i] === final_data[j]['Month']){
                        sortData.push(final_data[j])
                    }
                }
            }
            result_data.push(sortData)
        }

        res.status(200).json(result_data);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

module.exports = {
    getDeepDivePageData
}

