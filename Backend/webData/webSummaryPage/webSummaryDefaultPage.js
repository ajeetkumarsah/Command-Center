// const {sequelize} = require('../../databaseConnection/sql_connection');
//
// let getSummaryPageData = async (req, res) =>{
//     try {
//         let date = req.query.date;
//         let year = new Date()
//         let current_year = parseInt(date.split("-")[1])
//         let previous_year = current_year-1
//         let data = {}
//         let filter_key;
//         let filter_data;
//         let filter_type = req.query
//         delete filter_type.date;
//         for(let key in filter_type){
//             filter_key = key
//             filter_data = filter_type[key]
//         }
//
//         let current_year_rt = `CY${date.split("-")[1]}-${date.split("-")[0]}`
//
//         if(filter_key==="site"){filter_key="Site Name"}
//         if(filter_key==="branch"){filter_key="Branch Name"}
//         if(filter_key==="allIndia"){filter_key="Division"
//             filter_data = "%"
//         }
//
//         //--------------------------------------------------------------------------------------------------
//         // ------------------------------------------ Retailing Start --------------------------------------
//         // -------------------------------------------------------------------------------------------------
//         let previous_year_rt = `CY${parseInt(date.split("-")[1])-1}-${date.split("-")[0]}`
//         let new_rt_query_current_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_rt}'`
//         let new_rt_query_current_month_all_india = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${current_year_rt}' and [Division] not in ('') `
//         let new_rt_query_previous_month_all_india = `select sum([Retailing]) as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [Calendar Month] = '${previous_year_rt}' and [Division] not in ('') `
//         let new_rt_query_previous_month = `select [Retailing] as Retailing_Sum from [dbo].[tbl_command_center_retailing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_rt}'`
//         let rt_data_current_month = await sequelize.query(new_rt_query_current_month)
//         let rt_data_current_month_all_india = await sequelize.query(new_rt_query_current_month_all_india)
//         let rt_data_previous_month_all_india = await sequelize.query(new_rt_query_previous_month_all_india)
//         let rt_data_previous_month = await sequelize.query(new_rt_query_previous_month)
//         let retailing_sum_current_month = 0
//         let retailing_sum_current_month_all_india = 1
//         let retailing_sum_previous_month_all_india = 1
//         let retailing_sum_previous_month = 1
//         if(rt_data_current_month[0][0] !== undefined){
//             retailing_sum_current_month = rt_data_current_month[0][0]['Retailing_Sum']
//         }
//         if(rt_data_current_month_all_india[0][0] !== undefined){
//             retailing_sum_current_month_all_india = rt_data_current_month_all_india[0][0]['Retailing_Sum']
//         }
//         if(rt_data_previous_month_all_india[0][0] !== undefined){
//             retailing_sum_previous_month_all_india = rt_data_previous_month_all_india[0][0]['Retailing_Sum']
//         }
//         if(rt_data_previous_month[0][0] !== undefined){
//             retailing_sum_previous_month = rt_data_previous_month[0][0]['Retailing_Sum']
//         }
//
//         if(retailing_sum_current_month_all_india === 0 || retailing_sum_current_month_all_india === null){
//             retailing_sum_current_month_all_india = 1
//         }
//         if(retailing_sum_previous_month_all_india === 0 || retailing_sum_previous_month_all_india === null){
//             retailing_sum_previous_month_all_india =1
//         }
//
//         if(retailing_sum_previous_month===null || retailing_sum_previous_month===0 || retailing_sum_previous_month===undefined){retailing_sum_previous_month=1}
//         let rt_iya = (retailing_sum_current_month / retailing_sum_previous_month) * 100
//         let rt_saliance = (retailing_sum_current_month / retailing_sum_current_month_all_india) * 100
//
//         if(retailing_sum_previous_month_all_india === 1 && retailing_sum_current_month_all_india === 1){
//             retailing_sum_current_month_all_india  = 0
//         }
//         let rt_iya_all_india = (retailing_sum_current_month_all_india / retailing_sum_previous_month_all_india) * 100
//
//         while(rt_iya_all_india>1000){rt_iya_all_india = rt_iya_all_india/100}
//
//         while(rt_iya>1000){rt_iya = rt_iya/100}
//
//         while(retailing_sum_current_month>1000){retailing_sum_current_month = retailing_sum_current_month/100}
//
//
//         let mtdRetailing = {
//             "cmIyaDivision": (rt_iya).toFixed(2).split('.')[0],
//             "cmSaliance": (rt_saliance).toFixed(2).split('.')[0],
//             "cmSellout": (retailing_sum_current_month).toFixed(2),
//             "cmIyaAllIndia": (rt_iya_all_india).toFixed(2).split('.')[0],
//         }
//         data["mtdRetailing"]=(mtdRetailing)
//
//
//         //--------------------------------------------------------------------------------------------------
//         // ------------------------------------------ GP Start ---------------------------------------------
//         // -------------------------------------------------------------------------------------------------
//
//         let previous_year_gp = `CY${parseInt(date.split("-")[1])-1}-${date.split("-")[0]}`
//         let current_year_gp = `CY${date.split("-")[1]}-${date.split("-")[0]}`
//         if (filter_data === "South-West"){filter_data="S-W"}
//         if (filter_data === "North-East"){filter_data="N-E"}
//         if(filter_key==="site"){filter_key="Site Name"}
//         if(filter_key==="branch"){filter_key="Branch Name"}
//
//         let gp_new_query_current_year = `select [Golden Points Gap Filled - P3M], [Golden Points Target] from [dbo].[tbl_command_center_gp_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${current_year_gp}'`
//         let gp_new_query_current_year_all_india = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [Calender Year] = '${current_year_gp}' and [Division] not in ('')`
//         let gp_new_query_previous_year = `select [Golden Points Gap Filled - P3M], [Golden Points Target] from [dbo].[tbl_command_center_gp_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] = '${previous_year_gp}'`
//         let gp_new_query_previous_year_all_india = `select sum([Golden Points Gap Filled - P3M]) as gp_gap_fill_sum , sum([Golden Points Target]) as gp_target_sum from [dbo].[tbl_command_center_gp_calculation] where [Calender Year] = '${previous_year_gp}' and [Division] not in ('')`
//
//         let gp_gf_p3m_current_year = await sequelize.query(gp_new_query_current_year)
//         let gp_gf_p3m_current_year_all_india = await sequelize.query(gp_new_query_current_year_all_india)
//
//         let gp_target_current_year = 1
//         if(gp_gf_p3m_current_year[0][0] === undefined){
//             gp_gf_p3m_current_year = 0
//         }else {
//             gp_target_current_year = gp_gf_p3m_current_year[0][0]['Golden Points Target']
//             gp_gf_p3m_current_year = gp_gf_p3m_current_year[0][0]['Golden Points Gap Filled - P3M']
//         }
//
//         let gp_target_current_year_all_india = 1
//         if(gp_gf_p3m_current_year_all_india[0][0] === undefined){
//             gp_gf_p3m_current_year_all_india = 0
//         }else {
//             gp_target_current_year_all_india = gp_gf_p3m_current_year_all_india[0][0]['gp_target_sum']
//             gp_gf_p3m_current_year_all_india = gp_gf_p3m_current_year_all_india[0][0]['gp_gap_fill_sum']
//         }
//
//
//         let gp_target_previous_year = 1
//         let gp_gf_p3m_previous_year = await sequelize.query(gp_new_query_previous_year)
//         if(gp_gf_p3m_previous_year[0][0] === undefined){
//             gp_target_previous_year = 1
//             gp_gf_p3m_previous_year = 1
//         }
//         else {
//             gp_target_previous_year = gp_gf_p3m_previous_year[0][0]['Golden Points Target']
//             gp_gf_p3m_previous_year = gp_gf_p3m_previous_year[0][0]['Golden Points Gap Filled - P3M']
//         }
//
//         let gp_target_previous_year_all_india = 1
//         let gp_gf_p3m_previous_year_all_india = await sequelize.query(gp_new_query_previous_year_all_india)
//         if(gp_gf_p3m_previous_year_all_india[0][0] === undefined){
//             gp_target_previous_year_all_india = 1
//             gp_gf_p3m_previous_year_all_india = 1
//         }
//         else {
//             gp_target_previous_year_all_india = gp_gf_p3m_previous_year_all_india[0][0]['gp_target_sum']
//             gp_gf_p3m_previous_year_all_india = gp_gf_p3m_previous_year_all_india[0][0]['gp_gap_fill_sum']
//         }
//
//         if(gp_gf_p3m_current_year === null || gp_gf_p3m_current_year === undefined){ gp_gf_p3m_current_year = 0 }
//         if(gp_gf_p3m_previous_year === null || gp_gf_p3m_previous_year === undefined){ gp_gf_p3m_previous_year = 1 }
//         if(gp_target_current_year === null || gp_target_current_year === undefined){ gp_target_current_year = 1 }
//
//         if(gp_gf_p3m_current_year_all_india === null || gp_gf_p3m_current_year_all_india === undefined){ gp_gf_p3m_current_year_all_india = 0 }
//         if(gp_gf_p3m_previous_year_all_india === null || gp_gf_p3m_previous_year_all_india === undefined){ gp_gf_p3m_previous_year_all_india = 1 }
//         if(gp_target_current_year_all_india === null || gp_target_current_year_all_india === undefined){ gp_target_current_year_all_india = 1 }
//
//         let gp_iya = (gp_gf_p3m_current_year / gp_gf_p3m_previous_year) * 100
//         let gp_achievement = (gp_gf_p3m_current_year / gp_target_current_year) * 100
//         let gp_abs = gp_gf_p3m_current_year
//
//         let gp_iya_all_india = (gp_gf_p3m_current_year_all_india / gp_gf_p3m_previous_year_all_india) * 100
//         let gp_achievement_all_india = (gp_gf_p3m_current_year_all_india / gp_target_current_year_all_india) * 100
//         let gp_abs_all_india = gp_gf_p3m_current_year_all_india
//
//         while (gp_abs>1000){gp_abs = gp_abs/100}
//         while (gp_abs_all_india>1000){gp_abs_all_india = gp_abs_all_india/100}
//         // while (fb_iya_all_india>1000){fb_iya_all_india = fb_iya_all_india/100}
//         // while (fb_achieved_current_year_all_india>1000){fb_achieved_current_year_all_india = fb_achieved_current_year_all_india/100}
//
//         let dgpcompliance ={
//             "gpAchievememt": (gp_achievement).toFixed(2),
//             "gpAbs": (gp_abs).toFixed(2),
//             "gpIYA": (gp_iya).toFixed(2),
//             "gpAchievememtAllIndia": (gp_achievement_all_india).toFixed(2),
//             "gpAbsAllIndia": (gp_abs_all_india).toFixed(2),
//             "gpIYAAllIndia": (gp_iya_all_india).toFixed(2),
//         }
//         data["dgpCompliance"]=(dgpcompliance)
//
//
//         //--------------------------------------------------------------------------------------------------
//         // ------------------------------------------ FB Start ---------------------------------------------
//         // -------------------------------------------------------------------------------------------------
//
//         let previous_year_fb = `CY${parseInt(date.split("-")[1])-1}-${date.split("-")[0]}`
//         let current_year_fb = `CY${date.split("-")[1]}-${date.split("-")[0]}`
//         let new_fb_query = `select [FB Points achieved Sum], [FB Target Sum] FROM [dbo].[tbl_command_center_fb_calculation] where [${filter_key}] = '${filter_data}' and [Calender Year] like '${current_year_fb}'`
//         let new_fb_query_all_india = `select sum([FB Points achieved Sum]) as fb_achieved_sum, sum([FB Target Sum]) as fb_target_sum FROM [dbo].[tbl_command_center_fb_calculation] where [Division] not in ('') and [Calender Year] like '${current_year_fb}' `
//         let fb_data = await sequelize.query(new_fb_query)
//         let fb_data_all_india = await sequelize.query(new_fb_query_all_india)
//         let fb_achieved_current_year = 0
//         let fb_target_current_year = 1
//         let fb_achieved_current_year_all_india = 0
//         let fb_target_current_year_all_india = 1
//         if(fb_data[0][0] !== undefined){
//             fb_achieved_current_year = fb_data[0][0]['FB Points achieved Sum']
//             fb_target_current_year = fb_data[0][0]['FB Target Sum']
//         }
//         if(fb_data_all_india[0][0] !== undefined){
//             fb_achieved_current_year_all_india = fb_data_all_india[0][0]['fb_achieved_sum']
//             fb_target_current_year_all_india = fb_data_all_india[0][0]['fb_target_sum']
//         }
//         if(fb_achieved_current_year_all_india === null){fb_achieved_current_year_all_india = 0}
//         if(fb_target_current_year_all_india === null){fb_target_current_year_all_india = 1}
//
//         let fb_iya = (fb_achieved_current_year / fb_target_current_year) * 100
//         let fb_iya_all_india = (fb_achieved_current_year_all_india / fb_target_current_year_all_india) * 100
//
//         while (fb_iya>1000){fb_iya = fb_iya/100}
//         while (fb_achieved_current_year>1000){fb_achieved_current_year = fb_achieved_current_year/100}
//         while (fb_iya_all_india>1000){fb_iya_all_india = fb_iya_all_india/100}
//         while (fb_achieved_current_year_all_india>1000){fb_achieved_current_year_all_india = fb_achieved_current_year_all_india/100}
//
//         let focusbrand ={
//             "fbActual": parseInt(fb_achieved_current_year).toFixed(2).split(".")[0],
//             "fbActualAllIndia": parseInt(fb_achieved_current_year_all_india).toFixed(2).split(".")[0],
//             "fbAchievement": (parseInt(fb_iya).toFixed(2).split(".")[0]),
//             "fbAchievementAllIndia": (parseInt(fb_iya_all_india).toFixed(2).split(".")[0]),
//         }
//         data["focusBrand"]=(focusbrand)
//
//
//
//         //--------------------------------------------------------------------------------------------------
//         // ------------------------------------------ CC Start ---------------------------------------------
//         // -------------------------------------------------------------------------------------------------
//
//         let previous_year_cc = `CY${parseInt(date.split("-")[1])-1}-${date.split("-")[0]}`
//         let current_year_cc = `CY${date.split("-")[1]}-${date.split("-")[0]}`
//         let cc_new_query_current_year = `select [Calls Made], [Target Calls] from [dbo].[tbl_command_center_cc_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${current_year_cc}' `
//         let cc_new_query_current_year_all_india = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_calculation] where [Calendar Month] = '${current_year_cc}' and [Division] not in ('')`
//         let cc_new_query_previous_year = `select [Calls Made], [Target Calls] from [dbo].[tbl_command_center_cc_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${previous_year_cc}' `
//         let cc_new_query_previous_year_all_india = `select sum([Calls Made]) as calls_made_sum, sum([Target Calls]) as target_calls_sum from [dbo].[tbl_command_center_cc_calculation] where [Calendar Month] = '${previous_year_cc}' and [Division] not in ('')`
//
//         let cc_achieved_current_year = await sequelize.query(cc_new_query_current_year)
//
//         let cc_target_current_year = 1
//         if(cc_achieved_current_year[0][0] !== undefined){
//             cc_target_current_year = cc_achieved_current_year[0][0]['Target Calls']
//             cc_achieved_current_year = cc_achieved_current_year[0][0]['Calls Made']
//         }else{
//             cc_achieved_current_year = 0
//         }
//
//         let cc_achieved_current_year_all_india = await sequelize.query(cc_new_query_current_year_all_india)
//
//         let cc_target_current_year_all_india = 1
//         if(cc_achieved_current_year_all_india[0][0] !== undefined){
//             cc_target_current_year_all_india = cc_achieved_current_year_all_india[0][0]['target_calls_sum']
//             cc_achieved_current_year_all_india = cc_achieved_current_year_all_india[0][0]['calls_made_sum']
//         }else{
//             cc_achieved_current_year_all_india = 0
//         }
//
//         let cc_target_previous_year = 1
//         let cc_achieved_previous_year = await sequelize.query(cc_new_query_previous_year)
//         if(cc_achieved_previous_year[0][0] !== undefined){
//             cc_target_previous_year = cc_achieved_previous_year[0][0]['Target Calls']
//             cc_achieved_previous_year = cc_achieved_previous_year[0][0]['Calls Made']
//         }else{
//             cc_achieved_previous_year = 1
//         }
//
//         let cc_target_previous_year_all_india = 1
//         let cc_achieved_previous_year_all_india = await sequelize.query(cc_new_query_previous_year_all_india)
//         if(cc_achieved_previous_year_all_india[0][0] !== undefined){
//             cc_target_previous_year_all_india = cc_achieved_previous_year_all_india[0][0]['target_calls_sum']
//             cc_achieved_previous_year_all_india = cc_achieved_previous_year_all_india[0][0]['calls_made_sum']
//         }else{
//             cc_achieved_previous_year_all_india = 1
//         }
//
//         if(cc_achieved_current_year === null || cc_achieved_current_year === undefined){ cc_achieved_current_year = 0 }
//         if(cc_target_current_year === null || cc_target_current_year === undefined){ cc_target_current_year = 1 }
//
//         let cc_iya_current_month = (cc_achieved_current_year / cc_target_current_year) * 100
//
//         if(cc_achieved_previous_year === null || cc_achieved_previous_year === undefined){ cc_achieved_previous_year = 0 }
//         if(cc_target_previous_year === null || cc_target_previous_year === undefined){ cc_target_previous_year = 1 }
//
//
//         if(cc_achieved_current_year_all_india === null || cc_achieved_current_year_all_india === undefined){ cc_achieved_current_year_all_india = 0 }
//         if(cc_target_current_year_all_india === null || cc_target_current_year_all_india === undefined){ cc_target_current_year_all_india = 1 }
//
//         let cc_iya_current_month_all_india = (cc_achieved_current_year / cc_target_current_year) * 100
//
//         if(cc_achieved_previous_year_all_india === null || cc_achieved_previous_year_all_india === undefined){ cc_achieved_previous_year_all_india = 0 }
//         if(cc_target_previous_year_all_india === null || cc_target_previous_year_all_india === undefined){ cc_target_previous_year_all_india = 1 }
//
//
//         let cc_iya_previous_month = (cc_achieved_previous_year / cc_target_previous_year) * 100
//         let cc_iya_previous_month_all_india = (cc_achieved_previous_year_all_india / cc_target_previous_year_all_india) * 100
//
//         // while (fb_iya>1000){fb_iya = fb_iya/100}
//         // while (fb_achieved_current_year>1000){fb_achieved_current_year = fb_achieved_current_year/100}
//         // while (fb_iya_all_india>1000){fb_iya_all_india = fb_iya_all_india/100}
//         // while (fb_achieved_current_year_all_india>1000){fb_achieved_current_year_all_india = fb_achieved_current_year_all_india/100}
//
//         let cc = {
//             "ccCurrentMonth": cc_iya_current_month.toFixed(2),
//             "ccPreviousMonth": cc_iya_previous_month.toFixed(2),
//             "ccCurrentMonthAllIndia": cc_iya_current_month_all_india.toFixed(2),
//             "ccPreviousMonthAllIndia": cc_iya_previous_month_all_india.toFixed(2)
//         }
//         data["callCompliance"]=(cc)
//
//
//         //--------------------------------------------------------------------------------------------------
//         // ------------------------------------------ CBP Start --------------------------------------------
//         // -------------------------------------------------------------------------------------------------
//
//
//         let calendar_month_cy = `CY${date.split("-")[1]}-${date.split("-")[0]}`
//         let sql_query_no_of_billing_current_year_all_india = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum  FROM [dbo].[tbl_command_center_billing_calculation] where [Division] not in ('') and [Calendar Month] = '${calendar_month_cy}'`
//         let new_producitivity_query_current_month_all_india = `select sum ([Productive Calls]) as productivity_calls, sum([Target Calls]) as target_calls FROM [dbo].[tbl_command_center_productivity_calculation] where [Division] not in ('') and [Calendar Month] = '${calendar_month_cy}'`
//
//         let sql_query_no_of_billing_current_year = `select [No of stores billed atleast once] as billed_sum , [Coverage] as coverage_sum from [dbo].[tbl_command_center_billing_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
//         let new_producitivity_query_current_month = `select [Productive Calls] as productivity_calls, [Target Calls] as target_calls FROM [dbo].[tbl_command_center_productivity_calculation] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
//
//
//         let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)
//         let productivity_data = await sequelize.query(new_producitivity_query_current_month)
//
//         let billing_and_coverage_data_all_india = await sequelize.query(sql_query_no_of_billing_current_year_all_india)
//         let productivity_data_all_india = await sequelize.query(new_producitivity_query_current_month_all_india)
//
//         let billing = 0
//         let coverage = 1
//         let productive_calls = 0
//         let target_calls = 1
//
//
//         let billing_all_india = 0
//         let coverage_all_india = 1
//         let productive_calls_all_india = 0
//         let target_calls_all_india = 1
//
//
//         if(billing_and_coverage_data[0][0] !== undefined){
//             billing = billing_and_coverage_data[0][0]['billed_sum']
//             coverage = billing_and_coverage_data[0][0]['coverage_sum']
//         }
//         if(productivity_data[0][0] !== undefined) {
//             productive_calls = productivity_data[0][0]['productivity_calls']
//             target_calls = productivity_data[0][0]['target_calls']
//         }
//
//         if(billing_and_coverage_data_all_india[0][0] !== undefined){
//             billing_all_india = billing_and_coverage_data_all_india[0][0]['billed_sum']
//             coverage_all_india = billing_and_coverage_data_all_india[0][0]['coverage_sum']
//         }
//         if(productivity_data_all_india[0][0] !== undefined) {
//             productive_calls_all_india = productivity_data_all_india[0][0]['productivity_calls']
//             target_calls_all_india = productivity_data_all_india[0][0]['target_calls']
//         }
//
//         if(billing_all_india === null){billing_all_india = 0}
//         if(coverage_all_india === null){coverage_all_india = 1}
//         if(productive_calls_all_india === null){productive_calls_all_india = 0}
//         if(target_calls_all_india === null || target_calls_all_india === 0){target_calls_all_india = 1}
//         if(target_calls === null || target_calls === 0){target_calls = 1}
//
//
//         let billing_per = (billing / coverage) * 100
//         let productivity_per = (productive_calls / target_calls) * 100
//
//         let billing_per_all_india = (billing_all_india / coverage_all_india) * 100
//         let productivity_per_all_india = (productive_calls_all_india / target_calls_all_india) * 100
//
//         if(coverage === 1){coverage = 0}
//         if(coverage_all_india === 1){coverage_all_india = 0}
//
//         while(productivity_per>100){productivity_per = productivity_per / 100}
//         while(productivity_per_all_india>100){productivity_per_all_india = productivity_per_all_india / 100}
//         while(billing_per>100){billing_per = billing_per / 100}
//         while(billing_per_all_india>100){billing_per_all_india = billing_per_all_india / 100}
//         while(coverage>1000){coverage = coverage / 100}
//         while(coverage_all_india>1000){coverage_all_india = coverage_all_india / 100}
//
//         let objData = {
//             "Billing": parseInt(`${billing_per}`.split(".")[0]),
//             "Coverage": parseInt(coverage.toFixed(2).split(".")[0]),
//             "Productive Calls": parseInt(`${productivity_per}`.split(".")[0]),
//             "BillingAllIndia": parseInt(`${billing_per_all_india}`.split(".")[0]),
//             "CoverageAllIndia": parseInt(coverage_all_india.toFixed(2).split(".")[0]),
//             "ProductiveCallsAllIndia": parseInt(`${productivity_per_all_india}`.split(".")[0]),
//         }
//
//         data["CBP_Data"]=(objData)
//
//
//         res.status(200).json([data]);
//
//     }catch (e) {
//         console.log('error',e)
//         res.status(500).send({successful: false, error: 'An internal server error occurred.'})
//     }
// }
//
// module.exports = {
//     getSummaryPageData
// }
