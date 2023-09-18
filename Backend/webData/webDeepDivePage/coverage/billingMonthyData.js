const {sequelize} = require('../../../databaseConnection/sql_connection');
// const {sequelize2} = require('../../../databaseConnection/sql_connection2');

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

            let sql_query_no_of_billing_current_year

            if(channel === ''){
                if(filter_data === 'allIndia'){
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum, [Calendar Month] from [dbo].[tbl_command_center_billing_new] where Division in ('N-E', 'S-W') and [Calendar Month] in (${calendar_month_cy}) group by [Calendar Month] order by [Calendar Month] DESC`
                }
                else{
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum, [Calendar Month] from [dbo].[tbl_command_center_billing_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] in (${calendar_month_cy}) group by [Calendar Month] order by [Calendar Month] DESC`
                }
            }else {
                if(filter_data === 'allIndia'){
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum, [Calendar Month] from [dbo].[tbl_command_center_billing_new] where Division in ('N-E', 'S-W') and [Calendar Month] in (${calendar_month_cy}) and [ChannelName] = '${channel}' group by [Calendar Month] order by [Calendar Month] DESC`
                }
                else{
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum, [Calendar Month] from [dbo].[tbl_command_center_billing_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] in (${calendar_month_cy}) and [ChannelName] = '${channel}' group by [Calendar Month] order by [Calendar Month] DESC`
                }
            }

            let final_data = []

            let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)

            for(let i in billing_and_coverage_data[0]){
                let billing = 0
                let coverage = 1
                let month = ''

                if(billing_and_coverage_data[0][0] !== undefined){
                    billing = billing_and_coverage_data[0][i]['billed_sum']
                    coverage = billing_and_coverage_data[0][i]['coverage_sum']
                    month = billing_and_coverage_data[0][i]['Calendar Month']
                }


                if(billing === null){billing = 0}
                if(coverage === null){coverage = 1}
                if(coverage === 0){coverage = 1}
                if(month === null){month = ''}
                let billing_per = (billing / coverage) * 100
                if(coverage === 1){coverage = 0}

                let objData = {
                    "Billing_Per": parseInt(`${billing_per}`.split(".")[0]),
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

