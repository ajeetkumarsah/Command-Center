const {sequelize} = require('../../../databaseConnection/sql_connection');

function getMonthDigit(month) {
    const monthMap = {
        Jan: '01',
        Feb: '02',
        Mar: '03',
        Apr: '04',
        May: '05',
        Jun: '06',
        Jul: '07',
        Aug: '08',
        Sep: '09',
        Oct: '10',
        Nov: '11',
        Dec: '12'
    };

    return monthMap[month];
}

function getDigitMonth(month) {
    const monthMap = {
        '01': 'Jan',
        '02': 'Feb',
        '03': 'Mar',
        '04': 'Apr',
        '05': 'May',
        '06': 'Jun',
        '07': 'Jul',
        '08': 'Aug',
        '09': 'Sep',
        '10': 'Oct',
        '11': 'Nov',
        '12': 'Dec'
    };

    return monthMap[month];
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

function getPNMListDayLevel(current_year, current_month, no_of_months, required_type){
    let pNm = []

    for(let i=0; i<no_of_months; i++){
        if(current_month === "Jan"){
            current_year = parseInt(current_year) - 1
            let lastDayOfMonth = new Date(current_year, getMonthDigit(current_month), 0).getDate();
            for(let j=1; j<=lastDayOfMonth; j++){
                let todayDate;
                if(j<10){j = "0"+j}
                todayDate = `${current_year}-${getMonthDigit(current_month)}-${j}`
                pNm.push(todayDate)
            }
            current_month = getPreviousMonth(current_month)

        }else {
            let todayDate;
            let lastDayOfMonth = new Date(current_year, getMonthDigit(current_month), 0).getDate();
            for(let j=1; j<=lastDayOfMonth; j++){
                if(j<10){j = "0"+j}
                todayDate = `${current_year}-${getMonthDigit(current_month)}-${j}`
                pNm.push(todayDate)
            }
            current_month = getPreviousMonth(current_month)
        }
    }
    if(required_type === 'string'){
        return pNm.map(item => `'${item}'`).join(", ")
    }else{
        return pNm
    }

}

let getDeepDivePageData = async (req, res) =>{

    try {
        let reqDate = ''
        // let date = 'Aug-2023'
        // let monthsList = getPNMListDayLevel(date.split("-")[1], date.split("-")[0], 3)
        let all_data = req.body;
        let all_result = []
        for (let i in all_data) {
            let final_result = []
            let final_data = []
            let data = all_data[i]
            let date = data.date;
            reqDate = date
            let filter_key;
            let filter_1 = '';
            let filter_2 = '';
            let filter_data;
            let filter_type = data
            let channel = []
            let channel_list = []
            channel = data.channel
            channel_list = data.channel
            channel = channel.map(item => `'${item}'`).join(", ")
            let all_india_filter = data.allIndia ? data.allIndia : ''
            let division_filter = data.division ? data.division : ''
            let cluster_filter = data.cluster ? data.cluster : ''
            delete filter_type.date;
            delete filter_type.channel;

            if(all_india_filter !== ''){
                delete filter_type.allIndia;
                filter_1 = {
                    filter_key : 'allIndia',
                    filter_data : 'allIndia'
                }
            }
            if(division_filter !== ''){
                delete filter_type.division;
                if (division_filter === "South-West") {
                    division_filter = "S-W"
                }
                if (division_filter === "North-East") {
                    division_filter = "N-E"
                }
                filter_1 = {
                    filter_key : 'division',
                    filter_data : division_filter
                }
            }
            if(cluster_filter !== ''){
                delete filter_type.cluster;
                filter_1 = {
                    filter_key : 'cluster',
                    filter_data : cluster_filter
                }
            }

            for (let key in filter_type) {
                filter_key = key
                filter_data = filter_type[key]
            }

            if(filter_key === 'category'){filter_key = 'Category'}
            if(filter_key === 'brand'){filter_key = 'brand_name'}
            if(filter_key === 'brandForm'){filter_key = 'brandform_name'}
            if(filter_key === 'subBrandGroup'){filter_key = 'SBFGroup'}

            if(filter_key !== undefined & filter_data !== ''){
                filter_2 = {
                    filter_key : filter_key,
                    filter_data : filter_data
                }
            }

            let calendar_month_cy = getPNMListDayLevel(date.split("-")[1], date.split("-")[0], 3, 'string')
            if (filter_data === "South-West") {
                filter_data = "S-W"
            }
            if (filter_data === "North-East") {
                filter_data = "N-E"
            }

            let mergedArr = []
            let channel_query_rt

            if (filter_2 === '') {
                if(channel === ''){
                    if (filter_1['filter_data'] === 'allIndia') {
                        channel_query_rt = `select sum([Retailing]) as Retailing_Sum, [Date] from [datahub].[totalSalesCombinedExt] where [Date] in (${calendar_month_cy}) and Division in ('N-E', 'S-W') and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') group by [Date] order by [Date]`
                    } else {
                        channel_query_rt = `select sum([Retailing]) as Retailing_Sum, [Date] from [datahub].[totalSalesCombinedExt] where [Date] in (${calendar_month_cy}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') group by [Date] order by [Date]`
                    }
                }else{
                    if (filter_1['filter_data'] === 'allIndia') {
                        channel_query_rt = `select sum([Retailing]) as Retailing_Sum, [Date] from [datahub].[totalSalesCombinedExt] where [Date] in (${calendar_month_cy}) and Division in ('N-E', 'S-W') and [channel_name] = ${channel} group by [Date] order by [Date]`
                    } else {
                        channel_query_rt = `select sum([Retailing]) as Retailing_Sum, [Date] from [datahub].[totalSalesCombinedExt] where [Date] in (${calendar_month_cy}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [channel_name] = ${channel} group by [Date] order by [Date]`
                    }
                }

            } else {
                if(channel === ''){
                    if (filter_1['filter_data'] === 'allIndia') {
                        channel_query_rt = `select sum([Retailing]) as Retailing_Sum, [Date] from [datahub].[totalSalesCombinedExt] where [Date] in (${calendar_month_cy}) and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') group by [Date] order by [Date]`
                    } else {
                        channel_query_rt = `select sum([Retailing]) as Retailing_Sum, [Date] from [datahub].[totalSalesCombinedExt] where [Date] in (${calendar_month_cy}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') group by [Date] order by [Date]`
                    }
                }else {
                    if (filter_1['filter_data'] === 'allIndia') {
                        channel_query_rt = `select sum([Retailing]) as Retailing_Sum, [Date] from [datahub].[totalSalesCombinedExt] where [Date] in (${calendar_month_cy}) and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [channel_name] = ${channel} group by [Date] order by [Date]`
                    } else {
                        channel_query_rt = `select sum([Retailing]) as Retailing_Sum, [Date] from [datahub].[totalSalesCombinedExt] where [Date] in (${calendar_month_cy}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [channel_name] = ${channel} group by [Date] order by [Date]`
                    }
                }

            }
            // console.time("Data Fetching")

            let categories_data_rt = await sequelize.query(channel_query_rt)
            // console.timeEnd("Data Fetching")

            mergedArr = categories_data_rt[0]
            if(mergedArr.length<=0){
                res.status(400).send({successful: false, message: "DB do not have data for this filter"})
                return 0
            }
            let P3M = getPNMListDayLevel(date.split("-")[1], date.split("-")[0], 3, 'list')
            let processed_list = P3M.map(date => {
                date = date.split("-");
                return date[0] + "-" + date[1];
            });
            let processed_list_set = new Set(processed_list)
            processed_list = [...processed_list_set]
            for (let current_month in processed_list){
                let monthList = []
                for (let i in mergedArr) {
                    if ((mergedArr[i]['Date']).includes(processed_list[current_month])){
                        let date = (mergedArr[i]['Date']).split("-")
                        date = date[2]
                        let obj = {
                            'date':  date,
                            'retailing': mergedArr[i]['Retailing_Sum']  ? mergedArr[i]['Retailing_Sum'] : 0
                        }
                        monthList.push(obj)
                    }
                }
                let month = (processed_list[current_month]).split("-")
                month = getDigitMonth(month[1])+"-"+month[0]
                let obj = {
                    "month": month,
                    "filter_key1": filter_1['filter_data'],
                    "filter_key2": filter_2['filter_data'],
                    "channel": channel_list.map(item => item).join("/"),
                    "data": monthList
                }
                final_data.push(obj)
            }
            all_result.push(final_data)

        }
        res.status(200).json(all_result);
    } catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: e})
    }
}

module.exports = {
    getDeepDivePageData
}
