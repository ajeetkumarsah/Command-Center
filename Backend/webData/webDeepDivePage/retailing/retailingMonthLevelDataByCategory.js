const {sequelize} = require('../../../databaseConnection/sql_connection');


function getQuery(calendar_month, filter_2, filter_1, channel){
    let channel_query_rt_cy = ''
    if (filter_2 === '') {
        if(channel === ''){
            if (filter_1['filter_data'] === 'allIndia') {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] from [dbo].[tbl_command_center_rt_Division_cluster_category_brand_bf_sbf] where [MonthYear] in (${calendar_month}) and Division in ('N-E', 'S-W') and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') group by [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] order by [MonthYear]`
            } else {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] from [dbo].[tbl_command_center_rt_Division_cluster_category_brand_bf_sbf] where [MonthYear] in (${calendar_month}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') group by [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] order by [MonthYear]`
            }
        }else{
            if (filter_1['filter_data'] === 'allIndia') {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] from [dbo].[tbl_command_center_rt_Division_cluster_category_brand_bf_sbf] where [MonthYear] in (${calendar_month}) and Division in ('N-E', 'S-W') and [channel_name] = '${channel}' group by [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] order by [MonthYear]`
            } else {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] from [dbo].[tbl_command_center_rt_Division_cluster_category_brand_bf_sbf] where [MonthYear] in (${calendar_month}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [channel_name] = '${channel}' group by [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] order by [MonthYear]`
            }
        }

    } else {
        if(channel === ''){
            if (filter_1['filter_data'] === 'allIndia') {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] from [dbo].[tbl_command_center_rt_Division_cluster_category_brand_bf_sbf] where [MonthYear] in (${calendar_month}) and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') group by [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] order by [MonthYear]`
            } else {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] from [dbo].[tbl_command_center_rt_Division_cluster_category_brand_bf_sbf] where [MonthYear] in (${calendar_month}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') group by [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] order by [MonthYear]`
            }
        }else {
            if (filter_1['filter_data'] === 'allIndia') {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] from [dbo].[tbl_command_center_rt_Division_cluster_category_brand_bf_sbf] where [MonthYear] in (${calendar_month}) and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [channel_name] = '${channel}' group by [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] order by [MonthYear]`
            } else {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] from [dbo].[tbl_command_center_rt_Division_cluster_category_brand_bf_sbf] where [MonthYear] in (${calendar_month}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [channel_name] = '${channel}' group by [MonthYear], [Category], [brand_name], [brandform_name], [sbf_name] order by [MonthYear]`
            }
        }

    }

    return channel_query_rt_cy
}

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

function getPNMList(current_year, current_month, no_of_months, required_type){
    let pNm = []
    pNm.push(getMonthDigit(current_month)+current_year)
    for(let i=0; i<no_of_months-1; i++){
        let previous_month = getPreviousMonth(current_month)
        if(current_month === "Jan"){
            current_year = parseInt(current_year) - 1
            current_month = previous_month
            pNm.push(getMonthDigit(current_month)+current_year)
        }else {
            current_month = previous_month
            pNm.push(getMonthDigit(current_month)+current_year)
        }
    }
    if(required_type === 'string'){
        return pNm.map(item => `'${item}'`).join(", ")
    }else{
        return pNm
    }
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

let getDeepDivePageData = async (req, res) =>{

    try {
        let reqDate = ''
        let date = 'Aug-2023'
        let monthsList = getPNMList(date.split("-")[1], date.split("-")[0], 3)
        let all_data = req.body;
        let all_result = []
        for (let i in all_data) {
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
                    filter_key : 'all_india',
                    filter_data : all_india_filter
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

            let calendar_month_cy = getPNMList(date.split("-")[1], date.split("-")[0], 3, 'string')
            let calendar_month_py = getPNMList((date.split("-")[1])-1, date.split("-")[0], 3, 'string')
            let calendar_month_cy_list = getPNMList(date.split("-")[1], date.split("-")[0], 3, 'list')
            if (filter_data === "South-West") {
                filter_data = "S-W"
            }
            if (filter_data === "North-East") {
                filter_data = "N-E"
            }

            let mergedArr = []

            let channel_query_rt_cy = getQuery(calendar_month_cy, filter_2, filter_1, channel)
            let channel_query_rt_py = getQuery(calendar_month_py, filter_2, filter_1, channel)

            let categories_data_rt_cy = await sequelize.query(channel_query_rt_cy)
            let categories_data_rt_py = await sequelize.query(channel_query_rt_py)


            let cy_key = {}
            for(let i in categories_data_rt_cy[0]){
                cy_key[`${categories_data_rt_cy[0][i]['MonthYear']}/${categories_data_rt_cy[0][i]['Category']}/${categories_data_rt_cy[0][i]['brand_name']}/${categories_data_rt_cy[0][i]['brandform_name']}/${categories_data_rt_cy[0][i]['sbf_name']}`] = categories_data_rt_cy[0][i]['Retailing_Sum']
            }


            let cy_key_list = []
            for(let i in categories_data_rt_py[0]){
                let month = (categories_data_rt_py[0][i]['MonthYear']).slice(0,2)
                let year = (categories_data_rt_py[0][i]['MonthYear']).slice(2)
                let monthYear = month+(parseInt(year)+ 1)
                if(!cy_key[`${monthYear}/${categories_data_rt_py[0][i]['channel_name']}/${categories_data_rt_py[0][i]['CustName']}`]){
                    let obj = {
                        'Retailing_Sum': 0,
                        'MonthYear': categories_data_rt_cy[0][i]['MonthYear'],
                        'Category': categories_data_rt_py[0][i]['Category'],
                        'brand_name': categories_data_rt_py[0][i]['brand_name'],
                        'brandform_name': categories_data_rt_py[0][i]['brandform_name'],
                        'sbf_name': categories_data_rt_py[0][i]['sbf_name']
                    }
                    cy_key_list.push(obj)
                }
            }

            for(let i in cy_key_list){
                categories_data_rt_cy[0].push(cy_key_list[i])
            }


            let subCategoryMap = {}
            for(let i in categories_data_rt_py[0]){
                let month = (categories_data_rt_py[0][i]['MonthYear']).slice(0,2)
                let year = (categories_data_rt_py[0][i]['MonthYear']).slice(2)
                let monthYear = month+(parseInt(year)+ 1)
                subCategoryMap[`${monthYear}//${categories_data_rt_py[0][i]['channel_name']}//${categories_data_rt_py[0][i]['CustName']}`] = categories_data_rt_py[0][i]['Retailing_Sum']
            }
            for(let i in categories_data_rt_cy[0]){
                let obj = {
                    'cy_retailing_sum': categories_data_rt_cy[0][i]['Retailing_Sum'],
                    'py_retailing_sum': subCategoryMap[`${categories_data_rt_cy[0][i]['MonthYear']}//${categories_data_rt_cy[0][i]['channel_name']}//${categories_data_rt_cy[0][i]['CustName']}`] ? subCategoryMap[`${categories_data_rt_cy[0][i]['MonthYear']}//${categories_data_rt_cy[0][i]['channel_name']}//${categories_data_rt_cy[0][i]['CustName']}`] : 0,
                    'MonthYear': categories_data_rt_cy[0][i]['MonthYear'],
                    'channel_name': categories_data_rt_cy[0][i]['channel_name'],
                    'CustName': categories_data_rt_cy[0][i]['CustName']
                }
                mergedArr.push(obj)
            }

            // TODO Change this condition into that where we don't have any value in db
            // if(mergedArr.length<=0){
            //     res.status(400).send({successful: false, message: "DB do not have data for this filter"})
            //     return 0
            // }


            let channelObj = {}
            for(let i in mergedArr){
                for(let j in calendar_month_cy_list){
                    if(calendar_month_cy_list[j] === mergedArr[i]['MonthYear']){
                        let obj = {}
                        let key  = `${mergedArr[i]['MonthYear']}//${mergedArr[i]['channel_name']}`
                        if (key in channelObj){
                            channelObj[`${key}`]['cy_retailing_sum'] += mergedArr[i]['cy_retailing_sum']
                            channelObj[`${key}`]['py_retailing_sum'] += mergedArr[i]['py_retailing_sum']
                            if(channelObj[`${key}`]['py_retailing_sum'] === 0){
                                channelObj[`${key}`]['retailing_iya'] = parseFloat(((((channelObj[`${key}`]['cy_retailing_sum'])/(1) * 100))).toFixed(2))
                            }else{
                                channelObj[`${key}`]['retailing_iya'] = parseFloat(((((channelObj[`${key}`]['cy_retailing_sum'])/(channelObj[`${key}`]['py_retailing_sum']) * 100))).toFixed(2))
                            }
                        }else{
                            obj={
                                'cy_retailing_sum': mergedArr[i]['cy_retailing_sum'],
                                'py_retailing_sum': mergedArr[i]['py_retailing_sum'],
                                'MonthYear': mergedArr[i]['MonthYear'],
                                'channel_name': mergedArr[i]['channel_name'],
                                'CustName': mergedArr[i]['CustName'],
                                'Store' : []
                            }
                            if(mergedArr[i]['py_retailing_sum'] === 0){mergedArr[i]['py_retailing_sum'] = 1}
                            obj['retailing_iya'] =  parseFloat(((mergedArr[i]['cy_retailing_sum']) / (mergedArr[i]['py_retailing_sum']) * 100).toFixed(2)),
                                channelObj[key] = obj
                        }
                    }
                }
            }

            let storeObj = {}
            for(let i in mergedArr){
                for(let j in calendar_month_cy_list){
                    if(calendar_month_cy_list[j] === mergedArr[i]['MonthYear']){
                        let obj = {}
                        let key  = `${mergedArr[i]['MonthYear']}//${mergedArr[i]['channel_name']}//${mergedArr[i]['CustName']}`
                        if (key in storeObj){
                            storeObj[`${key}`]['cy_retailing_sum'] += mergedArr[i]['cy_retailing_sum']
                            storeObj[`${key}`]['py_retailing_sum'] += mergedArr[i]['py_retailing_sum']
                            if(storeObj[`${key}`]['py_retailing_sum'] === 0){
                                storeObj[`${key}`]['retailing_iya'] = parseFloat(((((storeObj[`${key}`]['cy_retailing_sum'])/(1) * 100))).toFixed(2))
                            }else{
                                storeObj[`${key}`]['retailing_iya'] = parseFloat(((((storeObj[`${key}`]['cy_retailing_sum'])/(storeObj[`${key}`]['py_retailing_sum']) * 100))).toFixed(2))
                            }
                        }else{
                            obj={
                                'cy_retailing_sum': mergedArr[i]['cy_retailing_sum'],
                                'py_retailing_sum': mergedArr[i]['py_retailing_sum'],
                                'MonthYear': mergedArr[i]['MonthYear'],
                                'channel_name': mergedArr[i]['channel_name'],
                                'CustName': mergedArr[i]['CustName']
                            }
                            if(mergedArr[i]['py_retailing_sum'] === 0){mergedArr[i]['py_retailing_sum'] = 1}
                            obj['retailing_iya'] =  parseFloat(((mergedArr[i]['cy_retailing_sum']) / (mergedArr[i]['py_retailing_sum']) * 100).toFixed(2)),
                                storeObj[key] = obj
                        }
                    }
                }
            }

            for( let i in storeObj){
                let key = i
                key = i.split("//")
                key.pop()
                key = key.join("//")
                channelObj[key]['Store'].push(storeObj[i])
            }
            for(let i in channelObj){
                final_data.push(channelObj[i])
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
