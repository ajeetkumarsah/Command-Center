const {sequelize} = require('../../../databaseConnection/sql_connection');

function getTableName(data, table_name){
    if(data === 'Category'){table_name = table_name+"_category"}
    if(data === 'brand_name'){table_name = table_name+"_category_brand"}
    if(data === 'brandform_name'){table_name = table_name+"_BF"}
    if(data === 'sbf_name'){table_name = table_name+"_SBF"}
    return table_name
}

function getFinancialYearList(month, year) {
    const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    const financialYearList = [];
    let financialYearCount = 0
    const currentMonthIndex = month;
    if(currentMonthIndex>=6){
        for(let i=6; i<=currentMonthIndex; i++){
            let financialYearStart = `CY${year}-${months[i]}`
            financialYearList.push(financialYearStart)
            financialYearCount += 1
        }

    }else {
        let prev_year = (parseInt(year)-1)
        for(let j=6; j<12; j++){
            let financialYearStart = `CY${prev_year}-${months[j]}`
            financialYearList.push(financialYearStart)
            financialYearCount += 1
        }
        for(let k = 0; k<= currentMonthIndex; k++){
            let financialYearEnd = `CY${year}-${months[k]}`
            financialYearList.push(financialYearEnd)
            financialYearCount += 1
        }

    }
    let fy_list_string = financialYearList.map(item => `'${item}'`).join(", ");
    return financialYearCount
}

function getFinalDataOfPNMSet(cy_data, py_data, filter_1, filter_2, channel_list){
    let geo_filter = filter_1['filter_key'] === 'allIndia' ? 'division' : filter_1['filter_key']
    let mergedArr = []
    let subCategoryMap = {}
    for(let i in py_data){
        let key = `${py_data[i][geo_filter]}`
        subCategoryMap[key] = py_data[i]['Retailing_Sum']
    }
    for(let i in cy_data){
        let key = `${cy_data[i][geo_filter]}`
        if(filter_1 ['filter_key'] === 'division' || filter_1['filter_key'] === 'allIndia'){
            let obj = {
                'cy_retailing_sum': cy_data[i]['Retailing_Sum'],
                'py_retailing_sum': subCategoryMap[key] ? subCategoryMap[key] : 0,
                'MonthYear': cy_data[i]['MonthYear'],
                'division': cy_data[i]['division'],
                'site': cy_data[i]['SiteName'],
                'branch': cy_data[i]['BranchName'],
                'channel': channel_list.map(item => item).join("/"),
                'brand': cy_data[i]['brand_name'],
                'filter_key': `${filter_1['filter_data']}`,
                'filter_key2': `${filter_2['filter_data'] ? filter_2['filter_data'] : ''}`
            }
            obj['IYA'] = ((obj['cy_retailing_sum'] ? obj['cy_retailing_sum'] : 0) / (obj['py_retailing_sum'] ? obj['py_retailing_sum'] : 1)) * 100
            obj['IYA'] = parseInt((obj['IYA'].toFixed(2)).split(".")[0])
            while(obj['IYA']>200){obj['IYA'] = parseInt(((obj['IYA']/10).toFixed(2)).split(".")[0])}
            mergedArr.push(obj)
        }
        if(filter_1['filter_key'] === 'cluster'){
            let obj = {
                'cy_retailing_sum': cy_data[i]['Retailing_Sum'],
                'py_retailing_sum': subCategoryMap[key] ? subCategoryMap[key] : 0,
                'MonthYear': cy_data[i]['MonthYear'],
                'cluster': `${filter_1['filter_data']}`,
                'site': cy_data[i]['SiteName'],
                'branch': cy_data[i]['BranchName'],
                'channel': channel_list.map(item => item).join("/"),
                'brand': cy_data[i]['brand_name'],
                'filter_key': `${filter_1['filter_data']}`,
                'filter_key2': `${filter_2['filter_data'] ? filter_2['filter_data'] : ''}`
            }
            obj['IYA'] = ((obj['cy_retailing_sum'] ? obj['cy_retailing_sum'] : 0) / (obj['py_retailing_sum'] ? obj['py_retailing_sum'] : 1)) * 100
            obj['IYA'] = parseInt((obj['IYA'].toFixed(2)).split(".")[0])
            while(obj['IYA']>200){obj['IYA'] = parseInt(((obj['IYA']/10).toFixed(2)).split(".")[0])}
            mergedArr.push(obj)
        }

    }

    return mergedArr
}

function getPNMSet(data, monthsList, no_of_months, skip){
    let mergeArr = [];
    let set_index = 0
    for(let m = 0; m<no_of_months; m++){
        set_index +=1
        if(set_index<=skip){
            continue
        }
        for(let i in data){
            if(monthsList[m] === data[i]['MonthYear']){
                mergeArr.push(data[i])
            }
        }
    }
    return mergeArr
}

function getQuery(calendar_month, filter_2, filter_1, channel, site, branch){
    let channel_query_rt_cy = ''
    let geo_filter = filter_1['filter_key'] === 'allIndia' ? 'division' : filter_1['filter_key']
    let siteName = '%'
    let branchName = '%'
    if(site !== "" && site !== undefined ){siteName = site+"%"}
    if(branch !== "" && branch !== undefined){branchName = branch+"%"}
    if (filter_2 === '') {
        if(channel === ''){
            if (filter_1['filter_data'] === 'allIndia') {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear],  [brand_name] from [dbo].[tbl_command_center_rt_Division_cluster_site_branch_channel_subChannel_category_brand] where [MonthYear] in (${calendar_month}) and Division in ('N-E', 'S-W')  and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') and [SiteName] like '${siteName}' and [BranchName] like '${branchName}' group by [MonthYear],  [brand_name] order by [MonthYear] desc`
            } else {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear],  [brand_name] from [dbo].[tbl_command_center_rt_Division_cluster_site_branch_channel_subChannel_category_brand] where [MonthYear] in (${calendar_month}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}'  and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') and [SiteName] like '${siteName}' and [BranchName] like '${branchName}' group by [MonthYear],  [brand_name] order by [MonthYear] desc`
            }
        }else{
            if (filter_1['filter_data'] === 'allIndia') {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear],  [brand_name] from [dbo].[tbl_command_center_rt_Division_cluster_site_branch_channel_subChannel_category_brand] where [MonthYear] in (${calendar_month}) and Division in ('N-E', 'S-W')  and [channel_name] in (${channel}) and [SiteName] like '${siteName}' and [BranchName] like '${branchName}' group by [MonthYear],  [brand_name] order by [MonthYear] desc`
            } else {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear],  [brand_name] from [dbo].[tbl_command_center_rt_Division_cluster_site_branch_channel_subChannel_category_brand] where [MonthYear] in (${calendar_month}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}'  and [channel_name] in (${channel}) and [SiteName] like '${siteName}' and [BranchName] like '${branchName}' group by [MonthYear],  [brand_name] order by [MonthYear] desc`
            }
        }

    } else {
        let table_name = 'tbl_command_center_rt_Division_cluster_site_branch_channel_subChannel_category_brand'
        // table_name = getTableName(filter_2['filter_key'], table_name)
        if(channel === ''){
            if (filter_1['filter_data'] === 'allIndia') {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear],  [brand_name] from [dbo].[${table_name}] where [MonthYear] in (${calendar_month}) and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}'  and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') and [SiteName] like '${siteName}' and [BranchName] like '${branchName}' group by [MonthYear],  [brand_name] order by [MonthYear] desc`
            } else {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear],  [brand_name] from [dbo].[${table_name}] where [MonthYear] in (${calendar_month}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}'  and [channel_name] not in ('Aggregator SubD', 'SubD', 'SubD A', 'SubD B') and [SiteName] like '${siteName}' and [BranchName] like '${branchName}' group by [MonthYear],  [brand_name] order by [MonthYear] desc`
            }
        }else {
            if (filter_1['filter_data'] === 'allIndia') {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear],  [brand_name] from [dbo].[${table_name}] where [MonthYear] in (${calendar_month}) and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}'  and [channel_name] in (${channel}) and [SiteName] like '${siteName}' and [BranchName] like '${branchName}' group by [MonthYear],  [brand_name] order by [MonthYear] desc`
            } else {
                channel_query_rt_cy = `select sum([Retailing]) as Retailing_Sum, [MonthYear],  [brand_name] from [dbo].[${table_name}] where [MonthYear] in (${calendar_month}) and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}'  and [channel_name] in (${channel}) and [SiteName] like '${siteName}' and [BranchName] like '${branchName}' group by [MonthYear],  [brand_name] order by [MonthYear] desc`
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
        let all_data = req.body;
        let all_result = []
        for (let i in all_data) {
            let data = all_data[i]
            let date = data.date;
            let site = data.site;
            let branch = data.branch;
            let monthsList_cy = getPNMList(date.split("-")[1], date.split("-")[0], 12, "list")
            let monthsList_py = getPNMList(parseInt(date.split("-")[1])-1, date.split("-")[0], 12, "list")
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
            delete filter_type.site;
            delete filter_type.branch;
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

            let calendar_month_cy = getPNMList(date.split("-")[1], date.split("-")[0], 12, 'string')
            let calendar_month_py = getPNMList((date.split("-")[1])-1, date.split("-")[0], 12, 'string')
            let calendar_month_cy_list = getPNMList(date.split("-")[1], date.split("-")[0], 12, 'list')
            if (filter_data === "South-West") {
                filter_data = "S-W"
            }
            if (filter_data === "North-East") {
                filter_data = "N-E"
            }

            let channel_query_rt_cy = getQuery(calendar_month_cy, filter_2, filter_1, channel, site, branch)
            let channel_query_rt_py = getQuery(calendar_month_py, filter_2, filter_1, channel, site, branch)

            let categories_data_rt_cy = await sequelize.query(channel_query_rt_cy)
            let categories_data_rt_py = await sequelize.query(channel_query_rt_py)

            let cy_key = {}
            for(let i in categories_data_rt_cy[0]){
                cy_key[`${categories_data_rt_cy[0][i]['MonthYear']}/${categories_data_rt_cy[0][i]['channel_name']}/${categories_data_rt_cy[0][i]['CustName']}`] = categories_data_rt_cy[0][i]['Retailing_Sum']
            }

            let cy_key_list = []
            for(let i in categories_data_rt_py[0]){
                let month = (categories_data_rt_py[0][i]['MonthYear']).slice(0,2)
                let year = (categories_data_rt_py[0][i]['MonthYear']).slice(2)
                let monthYear = month+(parseInt(year)+ 1)
                if(!cy_key[`${monthYear}/${categories_data_rt_py[0][i]['channel_name']}/${categories_data_rt_py[0][i]['CustName']}`]){
                    let obj = {
                        'Retailing_Sum': 0,
                        'MonthYear': monthYear,
                        'channel_name': categories_data_rt_py[0][i]['channel_name'],
                        'CustName': categories_data_rt_py[0][i]['CustName']
                    }
                    cy_key_list.push(obj)
                }
            }

            for(let i in cy_key_list){
                categories_data_rt_cy[0].push(cy_key_list[i])
            }

            let cm_set_cy = getPNMSet(categories_data_rt_cy[0], monthsList_cy, 1, 0)
            let cm_set_py = getPNMSet(categories_data_rt_py[0], monthsList_py, 1, 0)
            let cmDataSetList = getFinalDataOfPNMSet(cm_set_cy, cm_set_py, filter_1, filter_2, channel_list)
            let cm_obj = {
                "name" : "cm",
                "data" : cmDataSetList
            }

            let p1m_set_cy = getPNMSet(categories_data_rt_cy[0], monthsList_cy, 2, 1)
            let p1m_set_py = getPNMSet(categories_data_rt_py[0], monthsList_py, 2, 1)
            let p1mDataSetList = getFinalDataOfPNMSet(p1m_set_cy, p1m_set_py, filter_1, filter_2, channel_list)
            let p1m_obj = {
                "name" : "p1m",
                "data" : p1mDataSetList
            }

            let p3m_set_cy = getPNMSet(categories_data_rt_cy[0], monthsList_cy, 3, 0)
            let p3m_set_py = getPNMSet(categories_data_rt_py[0], monthsList_py, 3, 0)
            let p3mDataSetList = getFinalDataOfPNMSet(p3m_set_cy, p3m_set_py, filter_1, filter_2, channel_list)
            let p3m_obj = {
                "name" : "p3m",
                "data" : p3mDataSetList
            }

            let p6m_set_cy = getPNMSet(categories_data_rt_cy[0], monthsList_cy, 6, 0)
            let p6m_set_py = getPNMSet(categories_data_rt_py[0], monthsList_py, 6, 0)
            let p6mDataSetList = getFinalDataOfPNMSet(p6m_set_cy, p6m_set_py, filter_1, filter_2, channel_list)
            let p6m_obj = {
                "name" : "p6m",
                "data" : p6mDataSetList
            }

            let p12m_set_cy = getPNMSet(categories_data_rt_cy[0], monthsList_cy, 12, 0)
            let p12m_set_py = getPNMSet(categories_data_rt_py[0], monthsList_py, 12, 0)
            let p12mDataSetList = getFinalDataOfPNMSet(p12m_set_cy, p12m_set_py, filter_1, filter_2, channel_list)
            let p12m_obj = {
                "name" : "p12m",
                "data" : p12mDataSetList
            }

            let financialYearCount = getFinancialYearList(parseInt(getMonthDigit(date.split("-")[0]))-1, date.split("-")[1])

            let py_set_cy = getPNMSet(categories_data_rt_cy[0], monthsList_cy, financialYearCount, 0)
            let py_set_py = getPNMSet(categories_data_rt_py[0], monthsList_py, financialYearCount, 0)
            let pyDataSetList = getFinalDataOfPNMSet(py_set_cy, py_set_py, filter_1, filter_2, channel_list)
            let py_obj = {
                "name" : "financial_year",
                "data" : pyDataSetList
            }

            let dataList = []
            dataList.push(cm_obj)
            dataList.push(p1m_obj)
            dataList.push(p3m_obj)
            dataList.push(p6m_obj)
            dataList.push(p12m_obj)
            dataList.push(py_obj)
            all_result.push(dataList)
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