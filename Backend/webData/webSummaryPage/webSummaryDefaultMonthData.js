const {sequelize} = require('../../databaseConnection/sql_connection');

var cache = require('memory-cache');

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

function copyObject(obj) {
    return JSON.parse(JSON.stringify(obj));
}

function getFormatedNumberValue_FB_GP(value){
    value = parseFloat(value)
    let formatedValue = '0'
    console.log("Your Value Before Format", value)
    if(value>=1000000){
        formatedValue = ((value/1000000).toFixed(2).split(".")[0])+'MM'
    }

    else if(value>=1000 && value<100000){
        formatedValue = ((value/1000).toFixed(2).split(".")[0])+'M'
    }
    console.log("Your Value After Format", formatedValue)
    return formatedValue
}

function getFormatedNumberValue_RT(value){
    let formatedValue = '0'
    console.log("Your Value Before Format", value)
    if(value>=10000000 ){
        formatedValue = ((value/10000000).toFixed(2).split(".")[0])+'Cr'
    }

    else if(value>=100000 && value<10000000){
        formatedValue = ((value/100000).toFixed(2).split(".")[0])+'Lk'
    }
    console.log("Your Value After Format", formatedValue)
    return formatedValue
}

async function getRetailingObj(dataObj){
    let date = dataObj.date;
    let year = new Date()
    let current_year = parseInt(date.split("-")[1])
    let previous_year = current_year-1
    let data = {}
    let filter_key;
    let filter_data;
    let filter_type = copyObject(dataObj)
    delete filter_type.date;
    for(let key in filter_type){
        filter_key = key
        filter_data = filter_type[key]
    }

    let current_year_rt = getPNMList(date.split("-")[1], date.split("-")[0], 1, 'string')
    let previous_year_rt = getPNMList((date.split("-")[1])-1, date.split("-")[0], 1, 'string')
    // let current_year_rt = `CY${date.split("-")[1]}-${date.split("-")[0]}`
    // let previous_year_rt = `CY${parseInt(date.split("-")[1])-1}-${date.split("-")[0]}`

    if(filter_key==="site"){filter_key="SiteName"}
    if(filter_key==="branch"){filter_key="BranchName"}
    if(filter_key==="allIndia"){filter_key="Division"
        filter_data = "allIndia"
    }

    let new_rt_query_current_month
    let new_rt_query_previous_month

    if(filter_data === 'allIndia'){
        filter_data = "%"
        new_rt_query_current_month = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_rt_Division_cluster_site_branch] where [MonthYear] = ${current_year_rt} and [Division] in ('N-E', 'S-W') `
        new_rt_query_previous_month = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_rt_Division_cluster_site_branch] where [MonthYear] = ${previous_year_rt} and [Division] in ('N-E', 'S-W') `
    }
    else{
        new_rt_query_current_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_rt_Division_cluster_site_branch] where [${filter_key}] = '${filter_data}' and [MonthYear] = ${current_year_rt}`
        new_rt_query_previous_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_rt_Division_cluster_site_branch] where [${filter_key}] = '${filter_data}' and [MonthYear] = ${previous_year_rt}`
    }

    let rt_data_current_month = await sequelize.query(new_rt_query_current_month)
    let rt_data_previous_month = await sequelize.query(new_rt_query_previous_month)
    let retailing_sum_current_month = 0
    let retailing_sum_previous_month = 1
    if(rt_data_current_month[0][0] !== undefined){
        retailing_sum_current_month = rt_data_current_month[0][0]['Retailing_Sum']
    }
    if(rt_data_previous_month[0][0] !== undefined){
        retailing_sum_previous_month = rt_data_previous_month[0][0]['Retailing_Sum']
    }

    if(retailing_sum_previous_month===null || retailing_sum_previous_month===0 || retailing_sum_previous_month===undefined){retailing_sum_previous_month=1}
    let rt_iya = (retailing_sum_current_month / retailing_sum_previous_month) * 100

    while(rt_iya>1000){rt_iya = rt_iya/100}

    retailing_sum_current_month = getFormatedNumberValue_RT(retailing_sum_current_month)

    let mtdRetailing = {
        "cmIya": (rt_iya).toFixed(2).split('.')[0],
        "cmSellout": (retailing_sum_current_month),
    }
    if(filter_data === '%'){filter_data = 'All India'}
    mtdRetailing['filter'] = `${filter_data}`
    mtdRetailing['month'] = `${date}`
    data["mtdRetailing"]=(mtdRetailing)
    return mtdRetailing
}

async function getGPObj(dataObj){
    let date = dataObj.date;
    let year = new Date()
    let current_year = parseInt(date.split("-")[1])
    let previous_year = current_year-1
    let data = {}
    let filter_key;
    let filter_data;
    let filter_type = copyObject(dataObj)
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
        gp_new_query_current_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_geo_site] where [Calendar Month] = '${current_year_gp}' and [Division] not in ('')`
        gp_new_query_previous_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_geo_site] where [Calendar Month] = '${previous_year_gp}' and [Division] not in ('')`
    }
    else{
        gp_new_query_current_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_geo_site] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_gp}'`
        gp_new_query_previous_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_geo_site] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_gp}'`
    }

    let gp_gf_p3m_current_year = await sequelize.query(gp_new_query_current_year)

    let gp_target_current_year = 1
    if(gp_gf_p3m_current_year[0][0] === undefined){
        gp_gf_p3m_current_year = 0
    }else {
        gp_target_current_year = gp_gf_p3m_current_year[0][0]['gp_target_sum']
        gp_gf_p3m_current_year = gp_gf_p3m_current_year[0][0]['gp_gap_fill_sum']
    }

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

    if(gp_gf_p3m_current_year === null || gp_gf_p3m_current_year === undefined){ gp_gf_p3m_current_year = 0 }
    if(gp_gf_p3m_previous_year === null || gp_gf_p3m_previous_year === undefined){ gp_gf_p3m_previous_year = 1 }
    if(gp_target_current_year === null || gp_target_current_year === undefined){ gp_target_current_year = 1 }

    let gp_iya = (gp_gf_p3m_current_year / gp_gf_p3m_previous_year) * 100
    let gp_achievement = (gp_gf_p3m_current_year / gp_target_current_year) * 100
    let gp_abs = gp_gf_p3m_current_year

    gp_abs = getFormatedNumberValue_FB_GP(gp_abs)

    let dgpcompliance ={
        "gpAbs": (gp_abs),
        "gpIYA": (gp_iya).toFixed(2),
    }
    if(filter_data === '%'){filter_data = 'All India'}
    dgpcompliance['filter'] = `${filter_data}`
    dgpcompliance['month'] = `${date}`
    data["dgpCompliance"]=(dgpcompliance)

    return dgpcompliance
}

async function getFBObj(dataObj){
    let date = dataObj.date;
    let year = new Date()
    let current_year = parseInt(date.split("-")[1])
    let previous_year = current_year-1
    let data = {}
    let filter_key;
    let filter_data;
    let filter_type = copyObject(dataObj)
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

    let fb_data = await sequelize.query(new_fb_query)
    let fb_achieved_current_year = 0
    let fb_target_current_year = 1

    if(fb_data[0][0] !== undefined){
        fb_achieved_current_year = fb_data[0][0]['fb_achieved_sum']
        fb_target_current_year = fb_data[0][0]['fb_target_sum']
    }

    if(fb_target_current_year === 0){fb_target_current_year = 1}
    let fb_iya = (fb_achieved_current_year / fb_target_current_year) * 100
    if(fb_target_current_year === 1){fb_target_current_year = 0}

    fb_achieved_current_year = getFormatedNumberValue_FB_GP(fb_achieved_current_year)
    fb_target_current_year = getFormatedNumberValue_FB_GP(fb_target_current_year)

    let focusbrand ={
        "fbActual": fb_achieved_current_year,
        "fbTarget": fb_target_current_year,
        "fbIYA": (parseInt(fb_iya).toFixed(2).split(".")[0]),
    }
    if(filter_data === "allIndia"){filter_data = "All India"}
    focusbrand['filter'] = `${filter_data}`
    focusbrand['month'] = `${date}`

    data["focusBrand"]=(focusbrand)
    return focusbrand
}

async function getCCObj(dataObj){
    let date = dataObj.date;
    let year = new Date()
    let current_year = parseInt(date.split("-")[1])
    let previous_year = current_year-1
    let data = {}
    let filter_key;
    let filter_data;
    let filter_type = copyObject(dataObj)
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
        cc_new_query_current_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_new] where [Calendar Month] = '${current_year_cc}' and [Division] not in ('')`
        cc_new_query_previous_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_new] where [Calendar Month] = '${previous_year_cc}' and [Division] not in ('')`
    }
    else{
        cc_new_query_current_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_cc}' `
        cc_new_query_previous_year = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_cc}' `
    }

    let cc_achieved_current_year = await sequelize.query(cc_new_query_current_year)

    let cc_target_current_year = 1
    if(cc_achieved_current_year[0][0] !== undefined){
        cc_target_current_year = cc_achieved_current_year[0][0]['target_calls_sum']
        cc_achieved_current_year = cc_achieved_current_year[0][0]['calls_made_sum']
    }else{
        cc_achieved_current_year = 0
    }


    let cc_target_previous_year = 1
    let cc_achieved_previous_year = await sequelize.query(cc_new_query_previous_year)
    if(cc_achieved_previous_year[0][0] !== undefined){
        cc_target_previous_year = cc_achieved_previous_year[0][0]['target_calls_sum']
        cc_achieved_previous_year = cc_achieved_previous_year[0][0]['calls_made_sum']
    }else{
        cc_achieved_previous_year = 1
    }


    if(cc_achieved_current_year === null || cc_achieved_current_year === undefined){ cc_achieved_current_year = 0 }
    if(cc_target_current_year === null || cc_target_current_year === undefined){ cc_target_current_year = 1 }

    let cc_iya_current_month = (cc_achieved_current_year / cc_target_current_year) * 100

    if(cc_achieved_previous_year === null || cc_achieved_previous_year === undefined){ cc_achieved_previous_year = 0 }
    if(cc_target_previous_year === null || cc_target_previous_year === undefined){ cc_target_previous_year = 1 }


    let cc_iya_previous_month = (cc_achieved_previous_year / cc_target_previous_year) * 100

    while (cc_target_current_year>1000){cc_target_current_year = cc_target_current_year/100}
    while (cc_target_previous_year>1000){cc_target_previous_year = cc_target_previous_year/100}

    let cc = {
        "ccCurrentMonth": parseFloat(cc_iya_current_month.toFixed(2)),
        "ccCurrentMonthTarget": cc_target_current_year.toFixed(2),
        "ccPreviousMonth": parseFloat(cc_iya_previous_month.toFixed(2)),
        "ccPreviousMonthTarget": cc_target_previous_year.toFixed(2),
    }
    if(filter_data === '%'){filter_data = 'All India'}
    cc['filter'] = `${filter_data}`
    cc['month'] = `${date}`

    data["callCompliance"]=(cc)
    return cc
}

async function getCBPObj(dataObj){
    let date = dataObj.date;
    let year = new Date()
    let current_year = parseInt(date.split("-")[1])
    let previous_year = current_year-1
    let data = {}
    let filter_key;
    let filter_data;
    let filter_type = copyObject(dataObj)
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


    let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)

    let billing = 0
    let coverage = 1
    let target_calls = 1

    if(billing_and_coverage_data[0][0] !== undefined){
        billing = billing_and_coverage_data[0][0]['billed_sum']
        coverage = billing_and_coverage_data[0][0]['coverage_sum']
    }

    if(coverage === 0){coverage = 1}
    let billing_per = (billing / coverage) * 100
    if(coverage === 1){coverage = 0}

    while(billing_per>100){billing_per = billing_per / 100}
    while(coverage>1000){coverage = coverage / 100}

    let objData = {
        "Billing_Per": parseInt(`${billing_per}`.split(".")[0]),
        "Coverage": parseInt(coverage.toFixed(2).split(".")[0]),
    }
    if(filter_data === '%'){filter_data = 'All India'}
    objData['filter'] = `${filter_data}`
    objData['month'] = `${date}`
    data["coverage"]=(objData)
    return objData
}

async function getProductivityObj(dataObj){
    let date = dataObj.date;
    let year = new Date()
    let current_year = parseInt(date.split("-")[1])
    let previous_year = current_year-1
    let data = {}
    let filter_key;
    let filter_data;
    let filter_type = copyObject(dataObj)
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

    let new_producitivity_query_current_month
    if(filter_data === 'allIndia'){
        filter_data = "%"
        new_producitivity_query_current_month = `select sum ([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_new] where [Division] in ('N-E', 'S-W') and [Calendar Month] = '${calendar_month_cy}'`
    }
    else{
        new_producitivity_query_current_month = `select sum ([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}' `
    }

    let productivity_data = await sequelize.query(new_producitivity_query_current_month)

    let productive_calls = 0
    let target_calls = 1

    if(productivity_data[0][0] !== undefined) {
        productive_calls = productivity_data[0][0]['productivity_calls']
        target_calls = productivity_data[0][0]['target_calls']
    }


    if(target_calls === 0){target_calls = 1}
    let productivity_per = (productive_calls / target_calls) * 100
    if(target_calls === 1){target_calls = 0}

    while(productivity_per>100){productivity_per = productivity_per / 100}

    let objData = {
        "Productive_Per": parseInt(`${productivity_per}`.split(".")[0]),
        "Productive_Target": parseInt(`${target_calls}`.split(".")[0]),
    }
    if(filter_data === '%'){filter_data = 'All India'}
    objData['filter'] = `${filter_data}`
    objData['month'] = `${date}`

    data["productivity"]=(objData)
    return objData
}

function deepEqual(obj1, obj2) {
    // Convert objects to JSON strings and compare them
    const json1 = JSON.stringify(obj1);
    const json2 = JSON.stringify(obj2);

    return json1 === json2;
}

async function getDataFromDB(data){
    let queryData = data
    if(queryData.length === 1){queryData = queryData[0]}
    let finalData = []
    for(let i in queryData){
        let obj = {}
        let dataList = []
        for(let j in queryData[i]['query']){
            let dataObj = {}
            if(queryData[i]['filter_key'] === 'retailing'){
                dataObj = await getRetailingObj(queryData[i]['query'][j])
            }
            if(queryData[i]['filter_key'] === 'gp'){
                dataObj = await getGPObj(queryData[i]['query'][j])
            }
            if(queryData[i]['filter_key'] === 'fb'){
                dataObj = await getFBObj(queryData[i]['query'][j])
            }
            if(queryData[i]['filter_key'] === 'cc'){
                dataObj = await getCCObj(queryData[i]['query'][j])
            }
            if(queryData[i]['filter_key'] === 'coverage'){
                dataObj = await getCBPObj(queryData[i]['query'][j])
            }
            if(queryData[i]['filter_key'] === 'productivity'){
                dataObj = await getProductivityObj(queryData[i]['query'][j])
            }
            dataList.push(dataObj)
        }
        obj['filter_key'] = queryData[i]['filter_key']
        obj['data'] = dataList
        finalData.push(obj)
    }
    return finalData
}

let getSummaryPageData = async (req, res) =>{
    try {
        // let time_to_live = 7*24*60*60*1000 // Time in milliseconds for 7 days
        // let cacheKey = 'summaryDefaultMonth'
        // if(cache.get(cacheKey)){
        //     let cacheData = cache.get(cacheKey)
        //     let dataMatched = false
        //     let matchedIndex = 0
        //     for(let k in cacheData){
        //         if(dataMatched){
        //             break
        //         }
        //         let sameQuery = true
        //         let cachebodyData = cacheData[k]['reqBody']
        //         let curReq= req.body
        //         for(let i=0; i<curReq.length; i++){
        //             if(!sameQuery){
        //                 break
        //             }
        //             for(let l=0; l<cachebodyData.length; l++){
        //                 if(curReq[i]['filter_key'] === cachebodyData[l]['filter_key']){
        //                     for(let j=0; j<curReq[i]['query'].length; j++){
        //                         if (deepEqual(cachebodyData[l]['query'][j], curReq[i]['query'][j]) === false) {
        //                             console.log("Obj are different")
        //                             sameQuery = false
        //                             break
        //                         }
        //                     }
        //                 }
        //             }
        //         }
        //         if(sameQuery){
        //             dataMatched = true
        //             matchedIndex = k
        //         }
        //     }
        //
        //     if(dataMatched){
        //         console.log("Fetched data from cache")
        //         res.status(200).json(cacheData[matchedIndex]['resData']);
        //     }else {
        //         let dataList = []
        //         let finalData = await getDataFromDB(req.body)
        //         let obj ={
        //             'reqBody': req.body,
        //             'resData': finalData
        //         }
        //         for(let m in cacheData){
        //             dataList.push(cacheData[m])
        //         }
        //         dataList.push(obj)
        //         cache.put(cacheKey, dataList, time_to_live);
        //         console.log("Putting data into cache");
        //         res.status(200).json(finalData);
        //     }
        //
        // }else{
            let finalData = await getDataFromDB(req.body)
            let obj ={
                'reqBody': req.body,
                'resData': finalData
            }

            // cache.put(cacheKey, [obj], time_to_live);
            // console.log("Putting data into cache");

            res.status(200).json(finalData);
        // }
    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

module.exports = {
    getSummaryPageData
}
