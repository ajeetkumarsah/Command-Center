const {sequelize} = require('../databaseConnection/sql_connection');
const {sequelize2} = require('../databaseConnection/sql_connection2');

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

async function getRetailingData(req, res){
    let date = req.query.date;
    let month = getMonthDigit(date.split("-")[0])
    let year = date.split("-")[1]
    let day = (new Date()).getDate()
    let filter_key;
    let filter_data;
    let filter_type = req.query
    delete filter_type.date;
    for(let key in filter_type){
        filter_key = key
        filter_data = filter_type[key]
    }

    let day_level_filter_key = filter_key
    if((filter_key.split(" ")).length>1){
        day_level_filter_key = filter_key.split(" ")[0] + filter_key.split(" ")[1]
    }

    if((filter_key.split(" ")).length>1){
        filter_key = `[${filter_key}]`
    }

    let current_year = year
    let current_date = parseInt(day)
    if(current_date<10){
        current_date = '0'+current_date
    }
    let current_month = month
    let today_date = `${current_year}-${current_month}-${current_date}`
    let py_today_date = `${parseInt(current_year)-1}-${current_month}-${current_date}`
    let calendar_month_cy = `CY${current_year}-${getDigitMonth(current_month)}`

    let p1m_list_cm = getPNMList(today_date, 1)
    let p3m_list_cm = getPNMList(today_date, 3)
    let p6m_list_cm = getPNMList(today_date, 6)
    let p12m_list_cm = getPNMList(today_date, 12)

    let p1m_list_pm = getPNMList(py_today_date, 1)
    let p3m_list_pm = getPNMList(py_today_date, 3)
    let p6m_list_pm = getPNMList(py_today_date, 6)
    let p12m_list_pm = getPNMList(py_today_date, 12)

    let fy_list_cy = getFinancialYearList((parseInt(current_month)-1), current_year)
    let fy_list_py = getFinancialYearList((parseInt(current_month)-1), parseInt(current_year)-1)

    let today_sales_query = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_cc_reatailing_day_level_calculation] where ${day_level_filter_key} = '${filter_data}' and [Date] = '${today_date}'`
    let today_sales = await sequelize.query(today_sales_query)
    if(today_sales[0][0]!==undefined){
        today_sales = today_sales[0][0]['Retailing_sum']
    }else{
        today_sales = 0
    }

    let month_sales_query = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${calendar_month_cy}' and ${filter_key} = '${filter_data}'`

    let p1_sales_query_cm = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] IN (${p1m_list_cm}) and ${filter_key} = '${filter_data}'`
    let p3_sales_query_cm = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] IN (${p3m_list_cm}) and ${filter_key} = '${filter_data}'`
    let p6_sales_query_cm = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] IN (${p6m_list_cm}) and ${filter_key} = '${filter_data}'`
    let p12_sales_query_cm = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] IN (${p12m_list_cm}) and ${filter_key} = '${filter_data}'`
    let fy_sales_query_cy = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] IN (${fy_list_cy}) and ${filter_key} = '${filter_data}'`

    let p1_sales_query_pm = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] IN (${p1m_list_pm}) and ${filter_key} = '${filter_data}'`
    let p3_sales_query_pm = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] IN (${p3m_list_pm}) and ${filter_key} = '${filter_data}'`
    let p6_sales_query_pm = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] IN (${p6m_list_pm}) and ${filter_key} = '${filter_data}'`
    let p12_sales_query_pm = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] IN (${p12m_list_pm}) and ${filter_key} = '${filter_data}'`
    let fy_sales_query_py = `select [Retailing] as Retailing_sum FROM [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] IN (${fy_list_py}) and ${filter_key} = '${filter_data}'`

    let m_sales_cm = await sequelize.query(month_sales_query)
    let p1m_sales_cm = await sequelize.query(p1_sales_query_cm)
    let p3m_sales_cm = await sequelize.query(p3_sales_query_cm)
    let p6m_sales_cm = await sequelize.query(p6_sales_query_cm)
    let p12m_sales_cm = await sequelize.query(p12_sales_query_cm)
    let fy_sales_cy = await sequelize.query(fy_sales_query_cy)

    let p1m_sales_pm = await sequelize.query(p1_sales_query_pm)
    let p3m_sales_pm = await sequelize.query(p3_sales_query_pm)
    let p6m_sales_pm = await sequelize.query(p6_sales_query_pm)
    let p12m_sales_pm = await sequelize.query(p12_sales_query_pm)
    let fy_sales_py = await sequelize.query(fy_sales_query_py)

    let total_sales_m_cm = 0
    if(m_sales_cm[0][0]!==undefined){
        total_sales_m_cm = m_sales_cm[0][0]['Retailing_sum']
    }

    let total_sales_p1m_cm = 0
    if(p1m_sales_cm[0][0]!==undefined){
        total_sales_p1m_cm = p1m_sales_cm[0][0]['Retailing_sum']
    }

    let total_sales_p3m_cm = 0
    let total_sales_p6m_cm = 0
    let total_sales_p12m_cm = 0
    let total_sales_fy_cy = 0


    let total_sales_p1m_pm = 1
    let total_sales_p3m_pm = 1
    let total_sales_p6m_pm = 1
    let total_sales_p12m_pm = 1
    let total_sales_fy_py = 1


    for(let i in p3m_sales_cm[0]){
        total_sales_p3m_cm +=p3m_sales_cm[0][i]['Retailing_sum']
    }
    for(let i in p6m_sales_cm[0]){
        total_sales_p6m_cm +=p6m_sales_cm[0][i]['Retailing_sum']
    }
    for(let i in p12m_sales_cm[0]){
        total_sales_p12m_cm +=p12m_sales_cm[0][i]['Retailing_sum']
    }
    for(let i in fy_sales_cy[0]){
        total_sales_fy_cy +=fy_sales_cy[0][i]['Retailing_sum']
    }


    for(let i in p1m_sales_pm[0]){
        total_sales_p1m_pm +=p1m_sales_pm[0][i]['Retailing_sum']
    }
    for(let i in p3m_sales_pm[0]){
        total_sales_p3m_pm +=p3m_sales_pm[0][i]['Retailing_sum']
    }
    for(let i in p6m_sales_pm[0]){
        total_sales_p6m_pm +=p6m_sales_pm[0][i]['Retailing_sum']
    }
    for(let i in p12m_sales_pm[0]){
        total_sales_p12m_pm +=p12m_sales_pm[0][i]['Retailing_sum']
    }
    for(let i in fy_sales_py[0]){
        total_sales_fy_py +=fy_sales_py[0][i]['Retailing_sum']
    }

    let p1m_iya = (total_sales_p1m_cm/total_sales_p1m_pm) * 100
    let p3m_iya = (total_sales_p3m_cm/total_sales_p3m_pm) * 100
    let p6m_iya = (total_sales_p6m_cm/total_sales_p6m_pm) * 100
    let p12m_iya = (total_sales_p12m_cm/total_sales_p12m_pm) * 100
    let fy_iya = (total_sales_fy_cy/total_sales_fy_py) * 100

    let _retailingSummary = {
        "Today's Sales": today_sales,
        "Month's Sales": total_sales_m_cm,
        "P1M IYA": p1m_iya,
        "P3M IYA": p3m_iya,
        "P6M IYA": p6m_iya,
        "P12M IYA": p12m_iya,
        "FYTD IYA": fy_iya,
        "CY FYTD Sales": total_sales_fy_cy
    }
    // console.log(retailingSummary)
    return _retailingSummary
}

async function getCoverageSummaryData(){
    const geo_1 = Math.floor(Math.random() * (3500 - 3400 + 1)) + 3400;
    const geo_2 = Math.floor(Math.random() * (3500 - 3400 + 1)) + 3400;
    const geo_3 = Math.floor(Math.random() * (3500 - 3400 + 1)) + 3400;
    const geo_4 = Math.floor(Math.random() * (3500 - 3400 + 1)) + 3400;

    let coverage = {
        "geo_1": geo_1,
        "geo_2": geo_2,
        "geo_3": geo_3,
        "geo_4": geo_4
    }
    // console.log(coverage)
    return coverage
}

async function getCoverageCategoryData(){
    const gp_actual = Math.floor(Math.random() * (3500 - 3400 + 1)) + 3400;
    const gp_opp = Math.floor(Math.random() * (3500 - 3400 + 1)) + 3400;
    const gp_comp = Math.floor(Math.random() * (3500 - 3400 + 1)) + 3400;

    let coverage = {
        "gp_actual": gp_actual,
        "gp_opp": gp_opp,
        "gp_comp": gp_comp
    }
    // console.log(coverage)
    return coverage
}

async function getGoldenPointsSummaryData(){
    const hfs = Math.floor(Math.random() * (3500 - 3400 + 1)) + 3400;
    const ws = Math.floor(Math.random() * (3500 - 3400 + 1)) + 3400;
    const small = Math.floor(Math.random() * (3500 - 3400 + 1)) + 3400;

    let coverage = {
        "hfs": hfs,
        "ws": ws,
        "small": small
    }
    // console.log(coverage)
    return coverage
}

let getTableData = async (req, res) =>{
    try {
        let data = await sequelize.query(`select [Golden Points Target] FROM [dbo].[tbl_command_center_gp_calculation] where [Cluster] = 'HR'`)
        res.status(200).send({successful: true, data: data})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

function getFinancialYearList(month, year) {
    const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    const financialYearList = [];
    const currentMonthIndex = month;
    if(currentMonthIndex>=6){
        for(let i=6; i<=currentMonthIndex; i++){
            let financialYearStart = `CY${year}-${months[i]}`
            financialYearList.push(financialYearStart)
        }

    }else {
        let prev_year = (parseInt(year)-1)
        for(let j=6; j<12; j++){
            let financialYearStart = `CY${prev_year}-${months[j]}`
            financialYearList.push(financialYearStart)
        }
        for(let k = 0; k<= currentMonthIndex; k++){
            let financialYearEnd = `CY${year}-${months[k]}`
            financialYearList.push(financialYearEnd)
        }

    }
    let fy_list_string = financialYearList.map(item => `'${item}'`).join(", ");

    return fy_list_string;
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

let getHomePageData = async (req, res) =>{
    try {
        let date = req.query.date;
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

        // ______________________________Retailing Data___________________________________

        let current_year_rt = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}
        let previous_year_rt = `CY${parseInt(date.split("-")[1])-1}-${date.split("-")[0]}`
        let new_rt_query_current_month
        let new_rt_query_current_month_all_india
        let new_rt_query_previous_month

        if(filter_key==="allIndia"){
            new_rt_query_current_month = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${current_year_rt}' and [Division] in ('North-East', 'South-West') `
            new_rt_query_current_month_all_india = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${current_year_rt}' and [Division] in ('North-East', 'South-West') `
            new_rt_query_previous_month = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${previous_year_rt}' and [Division] in ('North-East', 'South-West') `
        }else {
            new_rt_query_current_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_rt}'`
            new_rt_query_current_month_all_india = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${current_year_rt}' and [Division] in ('North-East', 'South-West') `
            new_rt_query_previous_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_rt}'`
        }

        let rt_data_current_month = await sequelize.query(new_rt_query_current_month)
        let rt_data_current_month_all_india = await sequelize.query(new_rt_query_current_month_all_india)
        let rt_data_previous_month = await sequelize.query(new_rt_query_previous_month)
        let retailing_sum_current_month = 0
        let retailing_sum_current_month_all_india = 1
        let retailing_sum_previous_month = 1
        if(rt_data_current_month[0][0] !== undefined){
            retailing_sum_current_month = rt_data_current_month[0][0]['Retailing_Sum']
        }
        if(rt_data_current_month_all_india[0][0] !== undefined){
            retailing_sum_current_month_all_india = rt_data_current_month_all_india[0][0]['Retailing_Sum']
        }
        if(rt_data_previous_month[0][0] !== undefined){
            retailing_sum_previous_month = rt_data_previous_month[0][0]['Retailing_Sum']
        }

        if(retailing_sum_current_month_all_india === 0){
            retailing_sum_current_month_all_india = 1
        }
        if(retailing_sum_previous_month===null || retailing_sum_previous_month===0 || retailing_sum_previous_month===undefined){retailing_sum_previous_month=1}
        let rt_iya = (retailing_sum_current_month / retailing_sum_previous_month) * 100
        let rt_saliance = (retailing_sum_current_month / retailing_sum_current_month_all_india) * 100


        //  For Focus Brand Calculation in Home Page.......................................
        let current_year_fb = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}
        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}
        let new_fb_query
        if(filter_key==="allIndia"){
            new_fb_query = `select sum([FB Points achieved]) as fb_achieved_sum , sum([FB Target]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_new] where [Division] in ('N-E', 'S-W')and [Calendar Month] = '${current_year_fb}'`
        }else {
            new_fb_query = `select sum([FB Points achieved]) as fb_achieved_sum , sum([FB Target]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_fb}'`
        }


        let fb_data = await sequelize.query(new_fb_query)
        let fb_achieved_current_year = 0
        let fb_target_current_year = 1
        if(fb_data[0][0] !== undefined){
            fb_achieved_current_year = fb_data[0][0]['fb_achieved_sum']
            fb_target_current_year = fb_data[0][0]['fb_target_sum']
        }

        let fb_iya = (fb_achieved_current_year / fb_target_current_year) * 100


        //  For Golden Point Calculation in Home Page.......................................
        let current_year_gp = `CY${current_year}-${(date).split("-")[0]}%`
        let previous_year_gp = `CY${previous_year}-${(date).split("-")[0]}%`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}
        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}
        let gp_new_query_current_year
        let gp_new_query_previous_year

        if(filter_key==="allIndia"){
            gp_new_query_current_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gf_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [Division] not in  ('') and [Calender Year] like '${current_year_gp}' and ChannelName is NULL`
            gp_new_query_previous_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gf_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [Division] not in  ('') and [Calender Year] like '${previous_year_gp}' and ChannelName is NULL`
        }else{
            gp_new_query_current_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gf_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] like '${current_year_gp}' and ChannelName is NULL`
            gp_new_query_previous_year = `select sum([Golden Points Gap Filled - P3M]) as gp_gf_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] like '${previous_year_gp}' and ChannelName is NULL`
        }

        let gp_gf_p3m_current_year = await sequelize.query(gp_new_query_current_year)

        let gp_target_current_year = 1
        if(gp_gf_p3m_current_year[0][0] === undefined){
            gp_gf_p3m_current_year = 0
        }else {
            gp_target_current_year = gp_gf_p3m_current_year[0][0]['gp_target_sum']
            gp_gf_p3m_current_year = gp_gf_p3m_current_year[0][0]['gp_gf_sum']
        }


        let gp_target_previous_year = 1
        let gp_gf_p3m_previous_year = await sequelize.query(gp_new_query_previous_year)
        if(gp_gf_p3m_previous_year[0][0] === undefined){
            gp_gf_p3m_previous_year = 1000000
        }
        else {
                gp_gf_p3m_previous_year = gp_gf_p3m_previous_year[0][0]['gp_gf_sum']
            }

        if(gp_gf_p3m_current_year === null || gp_gf_p3m_current_year === undefined){ gp_gf_p3m_current_year = 0 }
        if(gp_gf_p3m_previous_year === null || gp_gf_p3m_previous_year === undefined){ gp_gf_p3m_previous_year = 1 }
        if(gp_target_current_year === null || gp_target_current_year === undefined){ gp_target_current_year = 1 }

        let gp_iya = (gp_gf_p3m_current_year / gp_gf_p3m_previous_year) * 100
        let gp_achievement = (gp_gf_p3m_current_year / gp_target_current_year) * 100
        let gp_abs = gp_gf_p3m_current_year


        //  For CC Calculation in Home Page.......................................
        let current_year_cc = `CY${date.split("-")[1]}-${date.split("-")[0]}`

        let previous_year_cc = `CY${(parseInt(current_year, 10))-1}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}
        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}
        let cc_new_query_current_year
        let cc_new_query_previous_year

        if(filter_key==="allIndia"){
            cc_new_query_current_year = `select sum([Calls Made])as cm_sum, sum([Target Calls])as target_call_sum from [dbo].[tbl_command_center_cc_new] where [Division] in ('N-E', 'S-W') and [Calendar Month] = '${current_year_cc}' `
            cc_new_query_previous_year = `select sum([Calls Made])as cm_sum, sum([Target Calls])as target_call_sum from [dbo].[tbl_command_center_cc_new] where [Division] in ('N-E', 'S-W') and [Calendar Month] = '${previous_year_cc}' `
        }else{
            cc_new_query_current_year = `select sum([Calls Made])as cm_sum, sum([Target Calls])as target_call_sum from [dbo].[tbl_command_center_cc_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_cc}' `
            cc_new_query_previous_year = `select sum([Calls Made])as cm_sum, sum([Target Calls])as target_call_sum from [dbo].[tbl_command_center_cc_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_cc}' `
        }

        let cc_achieved_current_year = await sequelize.query(cc_new_query_current_year)

        let cc_target_current_year = 1
        if(cc_achieved_current_year[0][0] !== undefined){
            cc_target_current_year = cc_achieved_current_year[0][0]['target_call_sum']
            cc_achieved_current_year = cc_achieved_current_year[0][0]['cm_sum']
        }else{
            cc_achieved_current_year = 0
        }

        let cc_target_previous_year = 1
        let cc_achieved_previous_year = await sequelize.query(cc_new_query_previous_year)
        if(cc_achieved_previous_year[0][0] !== undefined){
            cc_target_previous_year = cc_achieved_previous_year[0][0]['target_call_sum']
            cc_achieved_previous_year = cc_achieved_previous_year[0][0]['cm_sum']
        }else{
            cc_achieved_previous_year = 1
        }

        if(cc_achieved_current_year === null || cc_achieved_current_year === undefined){ cc_achieved_current_year = 0 }
        if(cc_target_current_year === null || cc_target_current_year === undefined){ cc_target_current_year = 1 }

        let cc_iya_current_month = (cc_achieved_current_year / cc_target_current_year) * 100

        if(cc_achieved_previous_year === null || cc_achieved_previous_year === undefined){ cc_achieved_previous_year = 0 }
        if(cc_target_previous_year === null || cc_target_previous_year === undefined){ cc_target_previous_year = 1 }

        let cc_iya_previous_month = (cc_achieved_previous_year / cc_target_previous_year) * 100

        //  For Productivity Calculation in Home Page.......................................
        let curr_month = (date).split("-")[0]
        let current_month_pc = `CY${current_year}-${(date).split("-")[0]}%`
        let previous_month_pc = `CY${parseInt(current_year)-1}-${curr_month}%`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}
        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}
        let new_producitivity_query_current_month
        let new_producitivity_query_previous_month
        if(filter_key==="allIndia"){
            new_producitivity_query_current_month = `select sum([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_new] where [Division] in ('N-E', 'S-W') and [Calendar Month] like '${current_month_pc}'`
            new_producitivity_query_previous_month = `select sum([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_new] where [Division] in ('N-E', 'S-W') and [Calendar Month] like '${previous_month_pc}'`
        }else{
            new_producitivity_query_current_month = `select sum([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] like '${current_month_pc}'`
            new_producitivity_query_previous_month = `select sum([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] like '${previous_month_pc}'`
        }

        let productivity_call_sum_cm = await sequelize.query(new_producitivity_query_current_month)
        let target_call_current_month = 1

        let productivity_call_sum_pm = await sequelize.query(new_producitivity_query_previous_month)
        let target_call_previous_month = 1

        if(productivity_call_sum_pm[0][0]===undefined){
            productivity_call_sum_pm = 0
            target_call_previous_month = 1
        }
        else {
            target_call_previous_month = productivity_call_sum_pm[0][0]['target_calls']
            productivity_call_sum_pm = productivity_call_sum_pm[0][0]['productivity_calls']
        }

        if(productivity_call_sum_pm === null || productivity_call_sum_pm === undefined){
            productivity_call_sum_pm = 0
        }

        if(productivity_call_sum_cm[0][0]===undefined){
            productivity_call_sum_cm = 0
            target_call_current_month = 1
        }
        else {
            target_call_current_month = productivity_call_sum_cm[0][0]['target_calls']
            productivity_call_sum_cm = productivity_call_sum_cm[0][0]['productivity_calls']
        }

        if(productivity_call_sum_cm === null || productivity_call_sum_cm === undefined){
            productivity_call_sum_cm = 0
        }

        let productivity_for_current_month = (productivity_call_sum_cm / target_call_current_month) * 100
        let productivity_for_previous_month = (productivity_call_sum_pm / target_call_previous_month) * 100

        if(productivity_for_current_month>1000){
            productivity_for_current_month = productivity_for_current_month/1000000
        }
        if(productivity_for_previous_month>1000){
            productivity_for_previous_month = productivity_for_previous_month/1000000
        }

        //  For Billing Calculation in Home Page.......................................
        let current_year_bc = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}
        if(filter_key==="site"){filter_key="Site Name"}
        if(filter_key==="branch"){filter_key="Branch Name"}
        let sql_query_no_of_billing_current_year

        if(filter_key==="allIndia"){
            // filter_key="Division"
            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where [Division] in ('N-E', 'S-W') and [Calendar Month] = '${current_year_bc}'`
        }else {
            sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_bc}'`
        }

        let no_of_billing_current_year = await sequelize.query(sql_query_no_of_billing_current_year)

        let billing_coverage_current_year = 1
        if(no_of_billing_current_year[0][0] === undefined){
            no_of_billing_current_year = 0
        }else {
            billing_coverage_current_year = no_of_billing_current_year[0][0]['coverage_sum']
            no_of_billing_current_year = no_of_billing_current_year[0][0]['billed_sum']
        }

        if(no_of_billing_current_year === null || no_of_billing_current_year === undefined){ no_of_billing_current_year = 0 }
        if(billing_coverage_current_year === null || billing_coverage_current_year === undefined){ billing_coverage_current_year = 1 }

        let billing_iya = (no_of_billing_current_year / billing_coverage_current_year) * 100

        while(no_of_billing_current_year>1000){no_of_billing_current_year = no_of_billing_current_year/10}
        while(billing_coverage_current_year>1000){billing_coverage_current_year = billing_coverage_current_year/10}

        const cmSellout = Math.floor(Math.random() * (600 - 550 + 1)) + 550;

        const tgtIya = Math.floor(Math.random() * (cmSellout - (cmSellout-20) + 1)) + (cmSellout-20);
        const tgtSaliance = Math.floor(Math.random() * (cmSellout - (cmSellout-20) + 1)) + (cmSellout-20);
        const tgtSellout = Math.floor(Math.random() * (cmSellout - (cmSellout-20) + 1)) + (cmSellout-20);

        while (rt_iya>100){rt_iya = rt_iya/10}
        while (retailing_sum_current_month>100){retailing_sum_current_month = retailing_sum_current_month/10}
        let mtdRetailing = {
            "cmIya": (rt_iya).toFixed(2).split('.')[0],
            "cmSaliance": (rt_saliance).toString(),
            "cmSellout": (retailing_sum_current_month).toFixed(2).split('.')[0],
            "tgtIya": tgtIya,
            "tgtSaliance": tgtSaliance,
            "tgtSellout": tgtSellout
        }
        data["mtdRetailing"]=(mtdRetailing)

        const billing = Math.floor(Math.random() * (100 - 50 + 1)) + 50;

        let coverage = {
            "cmCoverage": billing_coverage_current_year.toFixed(2).split(".")[0],
            "billing": billing_iya.toFixed(2)+'%'
        }
        data["coverage"]=(coverage)

        let cc = {
            "ccCurrentMonth": cc_iya_current_month.toFixed(2),
            "ccPreviousMonth": cc_iya_previous_month.toFixed(2)
        }
        data["callCompliance"]=(cc)

        let productivity = {
            "productivityCurrentMonth": productivity_for_current_month.toFixed(2),
            "productivityPreviousMonth": productivity_for_previous_month.toFixed(2)+'%'
        }
        data["productivity"]=(productivity)

        let _billing = {
            "billingActual": no_of_billing_current_year.toFixed(2).split('.')[0],
            "billingIYA": billing_iya.toFixed(2)
        }
        data["billing"]=(_billing)

        let shipment = {
            "shipmentActual": 0,
            "shipmentIYA": 0
        }
        data["shipment"]=(shipment)

        let inventory = {
            "inventoryActual": 0,
            "inventoryIYA": 0
        }
        data["inventory"]=(inventory)

        const dgpCompliance = Math.floor(Math.random() * (100 - 50 + 1)) + 50;

        let dgpcompliance ={
            "gpAchievememt": (gp_achievement).toFixed(2),
            "gpAbs": (gp_abs/100000).toFixed(2),
            "gpIYA": (gp_iya).toFixed(2)
        }
        data["dgpCompliance"]=(dgpcompliance)

        const fb_opp = Math.floor(Math.random() * (600 - 550 + 1)) + 550;
        while(fb_achieved_current_year>1000){fb_achieved_current_year=fb_achieved_current_year/10}
        let focusbrand ={
            "fbActual": parseInt(fb_achieved_current_year).toFixed(2).split(".")[0],
            "fbOpportunity": fb_opp,
            "fbAchievement": (parseInt(fb_iya).toFixed(2).split(".")[0])
        }
        data["focusBrand"]=(focusbrand)

        res.status(200).json([data]);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getCoverageData = async (req, res) =>{
    try {
        let f_data = []
        let f_data2 = []

        f_data.push(await getCoverageSummaryData())
        f_data.push(await getCoverageSummaryData())
        f_data.push(await getCoverageSummaryData())

        f_data2.push(await getCoverageCategoryData())
        f_data2.push(await getCoverageCategoryData())
        f_data2.push(await getCoverageCategoryData())
        f_data2.push(await getCoverageCategoryData())
        f_data2.push(await getCoverageCategoryData())
        f_data2.push(await getCoverageCategoryData())

        const data = {
            coverageSummary: f_data,
            coverageByCategory: f_data2,
            focousBrandByChannel: f_data2

        };
        res.status(200).json([data]);
    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

function getP12MList(current_date, no_of_months){
    let pNm = []
    let current_year = current_date.split('-')[0]
    let current_month = current_date.split('-')[1]
    current_month = getDigitMonth(current_month)
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
    return pNm
}

let getCoverageBillingProductiveData = async (req, res) =>{
    try {
        let id = 0
        let date = req.query.date;
        let month = getMonthDigit(date.split("-")[0])
        let year = date.split("-")[1]
        let day = (new Date()).getDate()
        let _filter_key_list = [];
        let filter_data_list = [];
        let filter_type = req.query
        delete filter_type.date;
        for(let key in filter_type){
            _filter_key_list.push(key)
            filter_data_list.push(filter_type[key])
        }


        let allData = []

        for(let i=0; i<_filter_key_list.length; i++){
            let filter_key = _filter_key_list[i]
            let filter_data = filter_data_list[i]
            let day_level_filter_key = filter_key
            if((filter_key.split(" ")).length>1){
                day_level_filter_key = filter_key.split(" ")[0] + filter_key.split(" ")[1]
            }

            if((filter_key.split(" ")).length>1){
                filter_key = `[${filter_key}]`
            }
            if(filter_data === 'North-East'){
                filter_data = 'N-E'
            }
            if(filter_data === 'South-West'){
                filter_data = 'S-W'
            }
            if(filter_key === 'site'){
                filter_key = 'Site Name'
            }
            if(filter_key === 'channel'){
                filter_key = 'ChannelName'
            }

            let current_year = year
            let current_date = parseInt(day)
            if(current_date<10){
                current_date = '0'+current_date
            }

            let current_month = month
            let calendar_month_cy = `CY${current_year}-${getDigitMonth(current_month)}`
            let sql_query_no_of_billing_current_year = ''
            let new_producitivity_query_current_month = ''

            if(filter_key==='[All India]'){
                filter_key = 'Division'
                filter_data = ''
                sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum  FROM [dbo].[tbl_command_center_billing_calculation] where [${filter_key}] not in ('${filter_data}') and [Calendar Month] = '${calendar_month_cy}'`
                new_producitivity_query_current_month = `select sum ([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_calculation] where [${filter_key}] not in ('${filter_data}') and [Calendar Month] = '${calendar_month_cy}'`
            }else {
                sql_query_no_of_billing_current_year = `select [No of stores billed atleast once] as billed_sum , [Coverage] as coverage_sum from [dbo].[tbl_command_center_billing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
                new_producitivity_query_current_month = `select [Productive Calls] as productivity_calls, [Target Calls] as target_calls FROM [dbo].[tbl_command_center_productivity_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
            }

            let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)
            let productivity_data = await sequelize.query(new_producitivity_query_current_month)

            let billing = 0
            let coverage = 0
            let productive_calls = 0
            let target_calls = 1

            if(billing_and_coverage_data[0][0] !== undefined){
                billing = billing_and_coverage_data[0][0]['billed_sum']
                coverage = billing_and_coverage_data[0][0]['coverage_sum']
            }
            if(productivity_data[0][0] !== undefined) {
                productive_calls = productivity_data[0][0]['productivity_calls']
                target_calls = productivity_data[0][0]['target_calls']
            }

            let billing_per = (billing / coverage) * 100
            let productivity_per = (productive_calls / target_calls) * 100

            if(productivity_per>100){
                productivity_per = productivity_per / 100000
            }
            let obj = {}
            id+=1

            let objData = {
                "Billing": parseInt(`${billing_per}`.split(".")[0]),
                "Coverage": coverage,
                "Productive Calls": parseInt(`${productivity_per}`.split(".")[0])
            }
            if(filter_data === ""){
                filter_data = "All India"
            }
            obj["id"] = id
            obj[`city`] = filter_data
            obj[`data`] = objData
            allData.push(obj)
        }

        res.status(200).json(allData);
    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

let getCoverageBillingProductiveByChannelData = async (req, res) =>{
    try {

        let date = req.query.date;
        let month = getMonthDigit(date.split("-")[0])
        let year = date.split("-")[1]
        let day = (new Date()).getDate()
        let _filter_key_list = [];
        let filter_data_list = [];
        let filter_type = req.query
        let channel_list = [
            'Cash&Carry',
            'eCommerce',
            'Hyper',
            'Large A Beauty',
            'Large A Pharmacy',
            'Large A Traditional',
            'Large B Pharmacy',
            'Large B Traditional',
            'Medium Beauty',
            'Medium Pharmacy',
            'Medium Traditional',
            'MM 1',
            'MM 2',
            'New Beauty',
            'New Pharmacy',
            'New Traditional',
            'Other',
            'Other Non Retail - DTC',
            'Semi WS Beauty',
            'Semi WS Pharmacy',
            'Semi WS Traditional',
            'Semi WS Beauty & Pharmacy',
            'Small A Beauty',
            'Small A Pharmacy',
            'Small A Traditional',
            'Small B Traditional',
            'Small C Traditional',
            'Small D Pharmacy',
            'Small D Traditional',
            'Speciality',
            'Super',
            'Unknown',
            'WS Feeder Beauty',
            'WS Beauty & Pharmacy',
            'WS Feeder Pharmacy',
            'WS Feeder Traditional',
            'WS Non-Feeder Beauty',
            'WS Non-Feeder Pharmacy',
            'WS Non-Feeder Traditional',
            'WS Traditional'
        ]
        let channel = ''
        delete filter_type.date;
        for(let key in filter_type){
            if(key === 'channel'){
                if(filter_type[key] !== ''){channel = filter_type[key]}

            }
            else {
                _filter_key_list.push(key)
                filter_data_list.push(filter_type[key])
            }

        }
        if(channel !== ""){
            channel_list = []
            channel_list.push(channel)
        }

        let allData = []

        for(let channel_index in channel_list){
            let channel_name = channel_list[channel_index]
            for(let i=0; i<_filter_key_list.length; i++){
                let filter_key = _filter_key_list[i]
                let filter_data = filter_data_list[i]
                let day_level_filter_key = filter_key
                if((filter_key.split(" ")).length>1){
                    day_level_filter_key = filter_key.split(" ")[0] + filter_key.split(" ")[1]
                }

                if((filter_key.split(" ")).length>1){
                    filter_key = `[${filter_key}]`
                }
                if(filter_data === 'North-East'){
                    filter_data = 'N-E'
                }
                if(filter_data === 'South-West'){
                    filter_data = 'S-W'
                }
                if(filter_key === 'site'){
                    filter_key = 'Site Name'
                }

                let current_year = year
                let current_date = parseInt(day)
                if(current_date<10){
                    current_date = '0'+current_date
                }

                let current_month = month
                let calendar_month_cy = `CY${current_year}-${getDigitMonth(current_month)}`
                let sql_query_no_of_billing_current_year = ''
                let new_producitivity_query_current_month = ''

                if(filter_key==='[All India]'){
                    filter_key = 'Division'
                    filter_data = ''
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum  FROM [dbo].[tbl_command_center_billing_calculation] where [${filter_key}] not in ('${filter_data}') and [Calendar Month] = '${calendar_month_cy}' and [ChannelName] = '${channel_name}'`
                    new_producitivity_query_current_month = `select sum ([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_calculation] where [${filter_key}] not in ('${filter_data}') and [Calendar Month] = '${calendar_month_cy}' and [ChannelName] = '${channel_name}'`
                }else {
                    sql_query_no_of_billing_current_year = `select [No of stores billed atleast once] as billed_sum , [Coverage] as coverage_sum from [dbo].[tbl_command_center_billing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}' and [ChannelName] = '${channel_name}'`
                    new_producitivity_query_current_month = `select [Productive Calls] as productivity_calls, [Target Calls] as target_calls FROM [dbo].[tbl_command_center_productivity_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}' and [ChannelName] = '${channel_name}'`
                }

                let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)
                let productivity_data = await sequelize.query(new_producitivity_query_current_month)

                let billing = 0
                let coverage = 0
                let productive_calls = 0
                let target_calls= 0

                if(billing_and_coverage_data[0][0] !== undefined){
                    billing = billing_and_coverage_data[0][0]['billed_sum']
                    coverage = billing_and_coverage_data[0][0]['coverage_sum']
                }
                if(productivity_data[0][0] !== undefined) {
                    productive_calls = productivity_data[0][0]['productivity_calls']
                    target_calls = productivity_data[0][0]['target_calls']
                }

                let billing_per = (billing / coverage) * 100
                let productivity_per = (productive_calls / target_calls) * 100
                let channel_obj = {}
                let objData = {
                    "Billing": parseInt(`${billing_per}`.split(".")[0]),
                    "Coverage": coverage,
                    "Productive Calls": parseInt(`${productivity_per}`.split(".")[0])
                }
                if(filter_data === ""){
                    filter_data = "All India"
                }
                channel_obj[`channel`] = `${channel_name}`
                channel_obj[`data`] = objData
                allData.push(channel_obj)
            }
        }
        res.status(200).json(allData);
    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

let getCoverageTrendsData = async (req, res) =>{
    try {

        let date = req.query.date;
        let month = getMonthDigit(date.split("-")[0])
        let year = date.split("-")[1]
        let curr_date = `${year}-${month}`
        let day = (new Date()).getDate()
        let min = 0
        let max = 0
        let _filter_key_list = [];
        let filter_data_list = [];
        let filter_type = req.query
        delete filter_type.date;
        for(let key in filter_type){
            _filter_key_list.push(key)
            filter_data_list.push(filter_type[key])
        }
        let obj = {}
        let p12m_list = getP12MList(curr_date, 12)
        for(let j=0;j<p12m_list.length; j++){
            for(let i=0; i<_filter_key_list.length; i++){
                let filter_key = _filter_key_list[i]
                let filter_data = filter_data_list[i]
                let day_level_filter_key = filter_key
                if((filter_key.split(" ")).length>1){
                    day_level_filter_key = filter_key.split(" ")[0] + filter_key.split(" ")[1]
                }

                if((filter_key.split(" ")).length>1){
                    filter_key = `[${filter_key}]`
                }
                if(filter_data === 'North-East'){
                    filter_data = 'N-E'
                }
                if(filter_data === 'South-West'){
                    filter_data = 'S-W'
                }
                if(filter_key === 'site'){
                    filter_key = 'Site Name'
                }
                if(filter_key === 'channel'){
                    filter_key = 'ChannelName'
                }
                let current_year = year
                let current_date = parseInt(day)
                if(current_date<10){
                    current_date = '0'+current_date
                }

                let calendar_month_cy = p12m_list[j]

                let sql_query_no_of_billing_current_year = ''
                let new_producitivity_query_current_month = ''

                if(filter_key==='[All India]'){
                    filter_key = 'Division'
                    filter_data = ''
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum  FROM [dbo].[tbl_command_center_billing_calculation] where [${filter_key}] not in ('${filter_data}') and [Calendar Month] = '${calendar_month_cy}'`
                    new_producitivity_query_current_month = `select sum ([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_calculation] where [${filter_key}] not in ('${filter_data}') and [Calendar Month] = '${calendar_month_cy}'`
                }else {
                    sql_query_no_of_billing_current_year = `select [No of stores billed atleast once] as billed_sum , [Coverage] as coverage_sum from [dbo].[tbl_command_center_billing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
                    new_producitivity_query_current_month = `select [Productive Calls] as productivity_calls, [Target Calls] as target_calls FROM [dbo].[tbl_command_center_productivity_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
                }

                let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)
                let productivity_data = await sequelize.query(new_producitivity_query_current_month)

                let billing = 0
                let coverage = 0
                let productive_calls = 0
                let target_calls = 0

                if(billing_and_coverage_data[0][0] !== undefined){
                    billing = billing_and_coverage_data[0][0]['billed_sum']
                    coverage = billing_and_coverage_data[0][0]['coverage_sum']
                }
                if(productivity_data[0][0] !== undefined) {
                    productive_calls = productivity_data[0][0]['productivity_calls']
                    target_calls = productivity_data[0][0]['target_calls']
                }

                let billing_per = (billing / coverage) * 100
                let productivity_per = (productive_calls / target_calls) * 100

                if(billing<min){
                    min=billing
                }
                if(billing>max){
                    max=billing
                }
                if(coverage<min){
                    min=coverage
                }
                if(coverage>max){
                    max=coverage
                }
                if(productive_calls<min){
                    min=productive_calls
                }
                if(productive_calls>max){
                    max=productive_calls
                }

                if(filter_data === ""){
                    filter_data = "All India"
                }
                let objData = {
                    "Billing": parseInt(`${billing_per}`.split(".")[0]),
                    "Coverage": coverage,
                    "Productive Calls": parseInt(`${productivity_per}`.split(".")[0])
                }
                obj[`${calendar_month_cy.split("-")[1]}`] = objData
            }
        }

        obj[`min`] = min
        obj[`max`] = max
        obj[`average`] = (max+min)/2
        res.status(200).json(obj);
    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

let getDgpComplianceData = async (req, res) =>{
    try {
        let f_data = []
        let f_data2 = []

        f_data.push(await getGoldenPointsSummaryData())
        f_data.push(await getGoldenPointsSummaryData())
        f_data.push(await getGoldenPointsSummaryData())

        f_data2.push(await getCoverageCategoryData())
        f_data2.push(await getCoverageCategoryData())
        f_data2.push(await getCoverageCategoryData())
        f_data2.push(await getCoverageCategoryData())
        f_data2.push(await getCoverageCategoryData())
        f_data2.push(await getCoverageCategoryData())

        const data = {
            goldenPointsSummary: f_data,
            goldenPointsByCategory: f_data2,
            goldenPointsByChannel: f_data2
        };
        res.status(200).json([data]);
    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

function getPNMList(current_date, no_of_months){
    let pNm = []
    let current_year = current_date.split('-')[0]
    let current_month = current_date.split('-')[1]
    current_month = getDigitMonth(current_month)
    for(let i=0; i<no_of_months; i++){
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

let getMtdRetailingData = async (req, res) =>{
    try {
        let f_data = []
        f_data.push(await getRetailingData(req, res))
        const data = {
            retailingSummary: f_data,
            retailingByCategory: f_data,
            retailingByChannel: f_data,
            retailingByTrends: f_data
        };

        res.status(200).json([data]);
    } catch (error) {
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

let getFocusBrandDataByChannel = async (req, res) =>{
    try {

        let date = req.query.date;
        let month = getMonthDigit(date.split("-")[0])
        let year = date.split("-")[1]
        let day = (new Date()).getDate()
        let _filter_key_list = [];
        let filter_data_list = [];
        let filter_type = req.query
        let channel_list = [
            'Cash&Carry',
            'eCommerce',
            'Hyper',
            'Large A Beauty',
            'Large A Pharmacy',
            'Large A Traditional',
            'Large B Pharmacy',
            'Large B Traditional',
            'Medium Beauty',
            'Medium Pharmacy',
            'Medium Traditional',
            'MM 1',
            'MM 2',
            'New Beauty',
            'New Pharmacy',
            'New Traditional',
            'Other',
            'Other Non Retail - DTC',
            'Semi WS Beauty',
            'Semi WS Pharmacy',
            'Semi WS Traditional',
            'Semi WS Beauty & Pharmacy',
            'Small A Beauty',
            'Small A Pharmacy',
            'Small A Traditional',
            'Small B Traditional',
            'Small C Traditional',
            'Small D Pharmacy',
            'Small D Traditional',
            'Speciality',
            'Super',
            'Unknown',
            'WS Feeder Beauty',
            'WS Beauty & Pharmacy',
            'WS Feeder Pharmacy',
            'WS Feeder Traditional',
            'WS Non-Feeder Beauty',
            'WS Non-Feeder Pharmacy',
            'WS Non-Feeder Traditional',
            'WS Traditional'
        ]
        let channel = ''
        delete filter_type.date;
        for(let key in filter_type){
            if(key === 'channel'){
                if(filter_type[key] !== ''){channel = filter_type[key]}

            }
            else {
                _filter_key_list.push(key)
                filter_data_list.push(filter_type[key])
            }

        }
        if(channel !== ""){
            channel_list = []
            channel_list.push(channel)
        }

        let allData = []

        for(let channel_index in channel_list){
            let channel_name = channel_list[channel_index]
            for(let i=0; i<_filter_key_list.length; i++){
                let filter_key = _filter_key_list[i]
                let filter_data = filter_data_list[i]
                let day_level_filter_key = filter_key
                if((filter_key.split(" ")).length>1){
                    day_level_filter_key = filter_key.split(" ")[0] + filter_key.split(" ")[1]
                }

                if((filter_key.split(" ")).length>1){
                    filter_key = `[${filter_key}]`
                }
                if(filter_data === 'North-East'){
                    filter_data = 'N-E'
                }
                if(filter_data === 'South-West'){
                    filter_data = 'S-W'
                }
                if(filter_key === 'site'){
                    filter_key = 'Site Name'
                }

                let current_year = year
                let current_date = parseInt(day)
                if(current_date<10){
                    current_date = '0'+current_date
                }

                let current_month = month
                let calendar_month_cy = `CY${current_year}-${getDigitMonth(current_month)}`
                let sql_query_fb_current_year_all_india = ''
                let sql_query_fb_current_year = ''

                if(filter_key==='[All India]'){
                    filter_key = 'Division'
                    filter_data = ''
                    sql_query_fb_current_year_all_india = `select sum([FB Points achieved Sum]) as fb_achieved_sum, sum([FB Target Sum]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] not in ('${filter_data}') and [Calender Year] = '${calendar_month_cy}' and [ChannelName] = '${channel_name}'`
                }else {
                    sql_query_fb_current_year = `select [FB Points achieved Sum] as fb_achieved_sum, [FB Target Sum] as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${calendar_month_cy}' and [ChannelName] = '${channel_name}'`
                }

                let fb_data = await sequelize.query(sql_query_fb_current_year)

                let fb_achieved = 0
                let fb_target = 1

                if(fb_data[0][0] !== undefined){
                    fb_achieved = fb_data[0][0]['fb_achieved_sum']
                    fb_target = fb_data[0][0]['fb_target_sum']
                }

                if(fb_target === 0){fb_target = 1}
                let fb_iya = (fb_achieved / fb_target) * 100
                if(fb_target === 1){fb_target = 0}
                let channel_obj = {}
                let objData = {
                    "fbAchieved": parseInt(`${fb_iya}`.split(".")[0]),
                    "fbTarget": parseInt(`${fb_target}`.split(".")[0]),
                }
                if(filter_data === ""){
                    filter_data = "All India"
                }
                channel_obj[`channel`] = `${channel_name}`
                channel_obj[`data`] = objData

                allData.push(channel_obj)
            }
        }

        res.status(200).json([allData]);

    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

async function getCategoryList(){
    try {
        let data = await sequelize2.query(`select distinct [CategoryName] from [sdm].[productMaster]`)
        let category = []
        for(let i in data[0]){
            category.push(data[0][i]['CategoryName'])
            console.log((data[0][i]['CategoryName']))
        }
        return category
    }catch (e){
        console.log('error',e)
        return []
    }
}

let getFocusBrandDataByCategory = async (req, res) =>{
    try {

        let date = req.query.date;
        let month = getMonthDigit(date.split("-")[0])
        let year = date.split("-")[1]
        let day = (new Date()).getDate()
        let _filter_key_list = [];
        let filter_data_list = [];
        let filter_type = req.query
        let category_list = await getCategoryList()
        let category = ''
        delete filter_type.date;
        for(let key in filter_type){
            if(key === 'category'){
                if(filter_type[key] !== ''){category = filter_type[key]}

            }
            else {
                _filter_key_list.push(key)
                filter_data_list.push(filter_type[key])
            }

        }
        if(category !== ""){
            category_list = []
            category_list.push(category)
        }

        let allData = []

        for(let category_index in category_list){
            let category_name = category_list[category_index]
            for(let i=0; i<_filter_key_list.length; i++){
                let filter_key = _filter_key_list[i]
                let filter_data = filter_data_list[i]
                let day_level_filter_key = filter_key
                if((filter_key.split(" ")).length>1){
                    day_level_filter_key = filter_key.split(" ")[0] + filter_key.split(" ")[1]
                }

                if((filter_key.split(" ")).length>1){
                    filter_key = `[${filter_key}]`
                }
                if(filter_data === 'North-East'){
                    filter_data = 'N-E'
                }
                if(filter_data === 'South-West'){
                    filter_data = 'S-W'
                }
                if(filter_key === 'site'){
                    filter_key = 'Site Name'
                }

                let current_year = year
                let current_date = parseInt(day)
                if(current_date<10){
                    current_date = '0'+current_date
                }

                let current_month = month
                let calendar_month_cy = `CY${current_year}-${getDigitMonth(current_month)}`
                let sql_query_fb_current_year_all_india = ''
                let sql_query_fb_current_year = ''

                if(filter_key==='[All India]'){
                    filter_key = 'Division'
                    filter_data = ''
                    sql_query_fb_current_year_all_india = `select sum([FB Points achieved Sum]) as fb_achieved_sum, sum([FB Target Sum]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] not in ('${filter_data}') and [Calender Year] = '${calendar_month_cy}' and [CategoryName] = '${category_name}'`
                }else {
                    sql_query_fb_current_year = `select [FB Points achieved Sum] as fb_achieved_sum, [FB Target Sum] as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${calendar_month_cy}' and [CategoryName] = '${category_name}'`
                }

                let fb_data = await sequelize.query(sql_query_fb_current_year)

                let fb_achieved = 0
                let fb_target = 1

                if(fb_data[0][0] !== undefined){
                    fb_achieved = fb_data[0][0]['fb_achieved_sum']
                    fb_target = fb_data[0][0]['fb_target_sum']
                }

                if(fb_target === 0){fb_target = 1}
                let fb_iya = (fb_achieved / fb_target) * 100
                // let fb_iya_all_india = (fb_achieved_all_india / fb_target_all_india) * 100
                if(fb_target === 1){fb_target = 0}
                let category_obj = {}
                let objData = {
                    "fbAchieved": parseInt(`${fb_iya}`.split(".")[0]),
                    "fbTarget": parseInt(`${fb_target}`.split(".")[0]),
                }
                if(filter_data === ""){
                    filter_data = "All India"
                }
                category_obj[`category`] = `${category_name}`
                category_obj[`data`] = objData

                allData.push(category_obj)
            }
        }

        res.status(200).json([allData]);

    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

async function getBrandList(){
    try {
        let data = await sequelize2.query(`select distinct [BrandName] from [sdm].[productMaster]`)
        let brand = []
        for(let i in data[0]){
            brand.push(data[0][i]['BrandName'])
            console.log((data[0][i]['BrandName']))
        }
        return brand
    }catch (e){
        console.log('error',e)
        return []
    }
}

let getFocusBrandDataByBrand = async (req, res) =>{
    try {

        let date = req.query.date;
        let month = getMonthDigit(date.split("-")[0])
        let year = date.split("-")[1]
        let day = (new Date()).getDate()
        let _filter_key_list = [];
        let filter_data_list = [];
        let filter_type = req.query
        let brand_list = await getBrandList()
        let brand = ''
        delete filter_type.date;
        for(let key in filter_type){
            if(key === 'brand'){
                if(filter_type[key] !== ''){brand = filter_type[key]}

            }
            else {
                _filter_key_list.push(key)
                filter_data_list.push(filter_type[key])
            }

        }
        if(brand !== ""){
            brand_list = []
            brand_list.push(brand)
        }

        let allData = []

        for(let brand_index in brand_list){
            let brand_name = brand_list[brand_index]
            for(let i=0; i<_filter_key_list.length; i++){
                let filter_key = _filter_key_list[i]
                let filter_data = filter_data_list[i]
                let day_level_filter_key = filter_key
                if((filter_key.split(" ")).length>1){
                    day_level_filter_key = filter_key.split(" ")[0] + filter_key.split(" ")[1]
                }

                if((filter_key.split(" ")).length>1){
                    filter_key = `[${filter_key}]`
                }
                if(filter_data === 'North-East'){
                    filter_data = 'N-E'
                }
                if(filter_data === 'South-West'){
                    filter_data = 'S-W'
                }
                if(filter_key === 'site'){
                    filter_key = 'Site Name'
                }

                let current_year = year
                let current_date = parseInt(day)
                if(current_date<10){
                    current_date = '0'+current_date
                }

                let current_month = month

                let calendar_month_cy = `CY${current_year}-${getDigitMonth(current_month)}`

                let sql_query_fb_current_year_all_india = ''
                let sql_query_fb_current_year = ''

                if(filter_key==='[All India]'){
                    filter_key = 'Division'
                    filter_data = ''
                    sql_query_fb_current_year_all_india = `select sum([FB Points achieved Sum]) as fb_achieved_sum, sum([FB Target Sum]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] not in ('${filter_data}') and [Calender Year] = '${calendar_month_cy}' and [BrandName] = '${brand_name}'`
                }else {
                    sql_query_fb_current_year = `select [FB Points achieved Sum] as fb_achieved_sum, [FB Target Sum] as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${calendar_month_cy}' and [BrandName] = '${brand_name}'`
                }

                let fb_data = await sequelize.query(sql_query_fb_current_year)

                let fb_achieved = 0
                let fb_target = 1

                if(fb_data[0][0] !== undefined){
                    fb_achieved = fb_data[0][0]['fb_achieved_sum']
                    fb_target = fb_data[0][0]['fb_target_sum']
                }
                if(fb_target === 0){fb_target = 1}
                let fb_iya = (fb_achieved / fb_target) * 100
                if(fb_target === 1){fb_target = 0}
                let brand_obj = {}
                let objData = {
                    "fbAchieved": parseInt(`${fb_iya}`.split(".")[0]),
                    "fbTarget": parseInt(`${fb_target}`.split(".")[0]),
                }
                if(filter_data === ""){
                    filter_data = "All India"
                }
                brand_obj[`brand`] = `${brand_name}`
                brand_obj[`data`] = objData

                allData.push(brand_obj)
            }
        }

        res.status(200).json([allData]);

    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

async function getBrandFormList(){
    try {
        let data = await sequelize2.query(`select distinct [BrandformName] from [sdm].[productMaster]`)
        let brandForm = []
        for(let i in data[0]){
            brandForm.push(data[0][i]['BrandformName'])
            console.log((data[0][i]['BrandformName']))
        }
        return brandForm
    }catch (e){
        console.log('error',e)
        return []
    }
}

let getFocusBrandDataByBrandForm = async (req, res) =>{
    try {

        let date = req.query.date;
        let month = getMonthDigit(date.split("-")[0])
        let year = date.split("-")[1]
        let day = (new Date()).getDate()
        let _filter_key_list = [];
        let filter_data_list = [];
        let filter_type = req.query
        let brandForm_list = await getBrandFormList()
        let brandForm = ''
        delete filter_type.date;
        for(let key in filter_type){
            if(key === 'brandForm'){
                if(filter_type[key] !== ''){brandForm = filter_type[key]}

            }
            else {
                _filter_key_list.push(key)
                filter_data_list.push(filter_type[key])
            }

        }
        if(brandForm !== ""){
            brandForm_list = []
            brandForm_list.push(brandForm)
        }

        let allData = []

        for(let brandForm_index in brandForm_list){
            let brandForm_name = brandForm_list[brandForm_index]
            for(let i=0; i<_filter_key_list.length; i++){
                let filter_key = _filter_key_list[i]
                let filter_data = filter_data_list[i]
                let day_level_filter_key = filter_key
                if((filter_key.split(" ")).length>1){
                    day_level_filter_key = filter_key.split(" ")[0] + filter_key.split(" ")[1]
                }

                if((filter_key.split(" ")).length>1){
                    filter_key = `[${filter_key}]`
                }
                if(filter_data === 'North-East'){
                    filter_data = 'N-E'
                }
                if(filter_data === 'South-West'){
                    filter_data = 'S-W'
                }
                if(filter_key === 'site'){
                    filter_key = 'Site Name'
                }

                let current_year = year
                let current_date = parseInt(day)
                if(current_date<10){
                    current_date = '0'+current_date
                }

                let current_month = month
                let calendar_month_cy = `CY${current_year}-${getDigitMonth(current_month)}`
                let sql_query_fb_current_year_all_india = ''
                let sql_query_fb_current_year = ''

                if(filter_key==='[All India]'){
                    filter_key = 'Division'
                    filter_data = ''
                    sql_query_fb_current_year_all_india = `select sum([FB Points achieved Sum]) as fb_achieved_sum, sum([FB Target Sum]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] not in ('${filter_data}') and [Calender Year] = '${calendar_month_cy}' and [BFName] = '${brandForm_name}'`
                }else {
                    sql_query_fb_current_year = `select [FB Points achieved Sum] as fb_achieved_sum, [FB Target Sum] as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${calendar_month_cy}' and [BFName] = '${brandForm_name}'`
                }

                let fb_data = await sequelize.query(sql_query_fb_current_year)

                let fb_achieved = 0
                let fb_target = 1

                if(fb_data[0][0] !== undefined){
                    fb_achieved = fb_data[0][0]['fb_achieved_sum']
                    fb_target = fb_data[0][0]['fb_target_sum']
                }
                if(fb_target === 0){fb_target = 1}
                let fb_iya = (fb_achieved / fb_target) * 100
                if(fb_target === 1){fb_target = 0}
                let brandForm_obj = {}
                let objData = {
                    "fbAchieved": parseInt(`${fb_iya}`.split(".")[0]),
                    "fbTarget": parseInt(`${fb_target}`.split(".")[0]),
                }
                if(filter_data === ""){
                    filter_data = "All India"
                }
                brandForm_obj[`brandForm`] = `${brandForm_name}`
                brandForm_obj[`data`] = objData

                allData.push(brandForm_obj)
            }
        }

        res.status(200).json([allData]);

    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

async function getSubBrandFormList(){
    try {
        let data = await sequelize2.query(`select distinct [SubbfName] from [sdm].[productMaster]`)
        let subBrandForm = []
        for(let i in data[0]){
            subBrandForm.push(data[0][i]['SubbfName'])
            console.log((data[0][i]['SubbfName']))
        }
        return subBrandForm
    }catch (e){
        console.log('error',e)
        return []
    }
}

let getFocusBrandDataBySubBrandForm = async (req, res) =>{
    try {

        let date = req.query.date;
        let month = getMonthDigit(date.split("-")[0])
        let year = date.split("-")[1]
        let day = (new Date()).getDate()
        let _filter_key_list = [];
        let filter_data_list = [];
        let filter_type = req.query
        let subBrandForm_list = await getSubBrandFormList()
        let subBrandForm = ''
        delete filter_type.date;
        for(let key in filter_type){
            if(key === 'subBrandForm'){
                if(filter_type[key] !== ''){subBrandForm = filter_type[key]}

            }
            else {
                _filter_key_list.push(key)
                filter_data_list.push(filter_type[key])
            }

        }
        if(subBrandForm !== ""){
            subBrandForm_list = []
            subBrandForm_list.push(subBrandForm)
        }

        let allData = []

        for(let subBrandForm_index in subBrandForm_list){
            let subBrandForm_name = subBrandForm_list[subBrandForm_index]
            for(let i=0; i<_filter_key_list.length; i++){
                let filter_key = _filter_key_list[i]
                let filter_data = filter_data_list[i]
                let day_level_filter_key = filter_key
                if((filter_key.split(" ")).length>1){
                    day_level_filter_key = filter_key.split(" ")[0] + filter_key.split(" ")[1]
                }

                if((filter_key.split(" ")).length>1){
                    filter_key = `[${filter_key}]`
                }
                if(filter_data === 'North-East'){
                    filter_data = 'N-E'
                }
                if(filter_data === 'South-West'){
                    filter_data = 'S-W'
                }
                if(filter_key === 'site'){
                    filter_key = 'Site Name'
                }

                let current_year = year
                let current_date = parseInt(day)
                if(current_date<10){
                    current_date = '0'+current_date
                }

                let current_month = month

                let calendar_month_cy = `CY${current_year}-${getDigitMonth(current_month)}`

                let sql_query_fb_current_year_all_india = ''
                let sql_query_fb_current_year = ''

                if(filter_key==='[All India]'){
                    filter_key = 'Division'
                    filter_data = ''
                    sql_query_fb_current_year_all_india = `select sum([FB Points achieved Sum]) as fb_achieved_sum, sum([FB Target Sum]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] not in ('${filter_data}') and [Calender Year] = '${calendar_month_cy}' and [SBFName] = '${subBrandForm_name}'`
                }else {
                    sql_query_fb_current_year = `select [FB Points achieved Sum] as fb_achieved_sum, [FB Target Sum] as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${calendar_month_cy}' and [SBFName] = '${subBrandForm_name}'`
                }

                let fb_data = await sequelize.query(sql_query_fb_current_year)

                let fb_achieved = 0
                let fb_target = 1

                if(fb_data[0][0] !== undefined){
                    fb_achieved = fb_data[0][0]['fb_achieved_sum']
                    fb_target = fb_data[0][0]['fb_target_sum']
                }

                if(fb_target === 0){fb_target = 1}
                let fb_iya = (fb_achieved / fb_target) * 100
                if(fb_target === 1){fb_target = 0}
                let subBrandForm_obj = {}
                let objData = {
                    "fbAchieved": parseInt(`${fb_iya}`.split(".")[0]),
                    "fbTarget": parseInt(`${fb_target}`.split(".")[0]),
                }
                if(filter_data === ""){
                    filter_data = "All India"
                }
                subBrandForm_obj[`subBrandForm`] = `${subBrandForm_name}`
                subBrandForm_obj[`data`] = objData

                allData.push(subBrandForm_obj)
            }
        }

        res.status(200).json([allData]);

    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

module.exports = {
    getHomePageData,
    getTableData,
    getCoverageData,
    getCoverageBillingProductiveData,
    getCoverageTrendsData,
    getCoverageBillingProductiveByChannelData,
    getDgpComplianceData,
    getMtdRetailingData,
    getFocusBrandDataByChannel,
    getFocusBrandDataByCategory,
    getFocusBrandDataByBrand,
    getFocusBrandDataByBrandForm,
    getFocusBrandDataBySubBrandForm
}
