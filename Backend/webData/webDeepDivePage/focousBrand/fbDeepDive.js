const {sequelize} = require('../../../databaseConnection/sql_connection');
const lodash = require("lodash");
const {QueryTypes} = require("sequelize");

function sanitizeInput(input) {
    const sanitizedInput = input.trim();
    if (/^[a-zA-Z\s\W_]+$/.test(sanitizedInput)) {
        return sanitizedInput; // Return the sanitized input if it contains only alphabet and special characters
    } else {
        throw new Error('Invalid input'); // Throw an error for invalid input
    }
}

let getDeepDivePageDataBySBF = async (req, res) =>{

    try {
        let date = req.body.date;
        let filter_key;
        let filter_data;
        let filter_type = req.body
        delete filter_type.date;
        for(let key in filter_type){
            filter_key = key
            filter_data = filter_type[key]
        }

        if(filter_key==="allIndia"){filter_key="Division"
            filter_data = "allIndia"
        }

        let calendar_month_cy = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West"){filter_data="S-W"}
        if (filter_data === "North-East"){filter_data="N-E"}

        let category_query_fb
        if(filter_data === 'allIndia'){
            category_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum  , [CategoryName], [BrandName], [BFName], [SBFName] FROM [dbo].[tbl_command_center_fb_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') group by [CategoryName], [BrandName], [BFName], [SBFName] order by [CategoryName] ASC`
        }
        else{
            category_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum  , [CategoryName], [BrandName], [BFName], [SBFName] FROM [dbo].[tbl_command_center_fb_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' group by [CategoryName], [BrandName], [BFName], [SBFName] order by [CategoryName] ASC`
        }
        let categories_data_fb = await sequelize.query(category_query_fb)

        let categorySet = {}
        for(let i in categories_data_fb[0]){
            let data = sanitizeInput(categorySet[`${categories_data_fb[0][i]['CategoryName']}`])
            if(data){
                data['fb_target'] = data['fb_target'] + categories_data_fb[0][i]['fb_target_sum']
                data['fb_achieved'] = data['fb_achieved'] + categories_data_fb[0][i]['fb_achieve_sum']
                data['fb_IYA'] = (data['fb_IYA'] + ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100))/2
            }
            else{
                categorySet[`${categories_data_fb[0][i]['CategoryName']}`] = {
                    'fb_target':  categories_data_fb[0][i]['fb_target_sum'],
                    'fb_achieved': categories_data_fb[0][i]['fb_achieve_sum'],
                    'fb_IYA': ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100)
                }
            }
        }
        let brandObj = {}
        for(let i in categories_data_fb[0]){
            let obj = {}
            let key  = sanitizeInput(categories_data_fb[0][i]['CategoryName'])
            if (key in brandObj){
                if(brandObj[`${categories_data_fb[0][i]['BrandName']}`]){
                    brandObj[`${categories_data_fb[0][i]['BrandName']}`] = categories_data_fb[0][i]['BrandName']
                    brandObj[`${categories_data_fb[0][i]['fb_achieved']}`] += categories_data_fb[0][i]['fb_achieve_sum']
                    brandObj[`${categories_data_fb[0][i]['fb_target']}`] += categories_data_fb[0][i]['fb_target_sum']
                    brandObj[`${categories_data_fb[0][i]['fb_IYA']}`] = (brandObj[`${categories_data_fb[0][i]['fb_IYA']}`] + ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100))/2
                    brandObj[`${categories_data_fb[0][i]['BrandForm']}`] = []
                }else {
                    obj['BrandName'] = categories_data_fb[0][i]['BrandName']
                    obj['fb_achieved'] = categories_data_fb[0][i]['fb_achieve_sum']
                    obj['fb_target'] = categories_data_fb[0][i]['fb_target_sum']
                    obj['fb_IYA'] = ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100)
                    obj['BrandForm'] = []
                    brandObj[key].push(obj)
                }

            }else{
                obj['BrandName'] = categories_data_fb[0][i]['BrandName']
                obj['fb_achieved'] = categories_data_fb[0][i]['fb_achieve_sum']
                obj['fb_target'] = categories_data_fb[0][i]['fb_target_sum']
                obj['fb_IYA'] = ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100)
                obj['BrandForm'] = []

                brandObj[key] = [obj]
            }
        }

        let brandForm = {}
        for(let i in categories_data_fb[0]){
            let obj = {}
            let key  = categories_data_fb[0][i]['BrandName']
            if (key in brandForm){

                if(brandForm[`${categories_data_fb[0][i]['BrandForm']}`]){
                    brandForm[`${categories_data_fb[0][i]['BrandForm']}`] = categories_data_fb[0][i]['BrandForm']
                    brandForm[`${categories_data_fb[0][i]['fb_achieved']}`] += categories_data_fb[0][i]['fb_achieve_sum']
                    brandForm[`${categories_data_fb[0][i]['fb_target']}`] += categories_data_fb[0][i]['fb_target_sum']
                    brandForm[`${categories_data_fb[0][i]['fb_IYA']}`] = (brandForm[`${categories_data_fb[0][i]['fb_IYA']}`] + ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100))/2
                    brandForm[`${categories_data_fb[0][i]['SBF']}`] = []
                }else {
                    obj['BrandForm'] = categories_data_fb[0][i]['BFName']
                    obj['fb_achieved'] = categories_data_fb[0][i]['fb_achieve_sum']
                    obj['fb_target'] = categories_data_fb[0][i]['fb_target_sum']
                    obj['fb_IYA'] = ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100)
                    obj['SBF'] = []
                    brandForm[key].push(obj)
                }
            }else{
                obj['BrandForm'] = categories_data_fb[0][i]['BFName']
                obj['fb_achieved'] = categories_data_fb[0][i]['fb_achieve_sum']
                obj['fb_target'] = categories_data_fb[0][i]['fb_target_sum']
                obj['fb_IYA'] = ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100)
                obj['SBF'] = []

                brandForm[key] = [obj]
            }
        }

        let SBForm = {}
        for(let i in categories_data_fb[0]){
            let obj = {}
            let key  = categories_data_fb[0][i]['BFName']
            if (key in SBForm){

                if(SBForm[`${categories_data_fb[0][i]['SBForm']}`]){
                    SBForm[`${categories_data_fb[0][i]['SBForm']}`] = categories_data_fb[0][i]['SBForm']
                    SBForm[`${categories_data_fb[0][i]['fb_achieved']}`] += categories_data_fb[0][i]['fb_achieve_sum']
                    SBForm[`${categories_data_fb[0][i]['fb_target']}`] += categories_data_fb[0][i]['fb_target_sum']
                    SBForm[`${categories_data_fb[0][i]['fb_IYA']}`] = (SBForm[`${categories_data_fb[0][i]['fb_IYA']}`] + ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100))/2
                }else {
                    obj['SBForm'] = categories_data_fb[0][i]['SBFName']
                    obj['fb_achieved'] = categories_data_fb[0][i]['fb_achieve_sum']
                    obj['fb_target'] = categories_data_fb[0][i]['fb_target_sum']
                    obj['fb_IYA'] = ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100)
                    SBForm[key].push(obj)
                }
            }else{
                obj['SBForm'] = categories_data_fb[0][i]['SBFName']
                obj['fb_achieved'] = categories_data_fb[0][i]['fb_achieve_sum']
                obj['fb_target'] = categories_data_fb[0][i]['fb_target_sum']
                obj['fb_IYA'] = ((categories_data_fb[0][i]['fb_achieve_sum'])/(categories_data_fb[0][i]['fb_target_sum']) * 100)
                SBForm[key] = [obj]
            }
        }


        for( let i in brandForm){
            for(let j in brandForm[i]){
                if((brandForm[i][j]['BrandForm']) in SBForm){
                    brandForm[i][j]['SBF'] = SBForm[`${brandForm[i][0]['BrandForm']}`]
                }
            }

        }

        for( let i in brandObj){
            for(let j in brandObj[i]){
                if((brandObj[i][j]['BrandName']) in brandForm){
                    brandObj[i][j]['BrandForm'] = brandForm[`${brandObj[i][0]['BrandName']}`]
                }
            }

        }

        for( let i in categorySet){
            if(i in brandObj){
                categorySet[i]['BrandName'] = brandObj[`${i}`]
            }
        }


        let sql_query_no_of_fb_current_year
        // let sql_query_no_of_productivity_current_year

        if(filter_data === 'allIndia'){
            sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieved_sum , SUM([FB Target]) as fb_target_sum  FROM [dbo].[tbl_command_center_fb_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W')`
        }
        else{
            sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieved_sum , SUM([FB Target]) as fb_target_sum  FROM [dbo].[tbl_command_center_fb_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
        }


        let fb_data = await sequelize.query(sql_query_no_of_fb_current_year)

        let fb_achieved_current_year = 0
        let fb_target_current_year = 1

        if(fb_data[0][0] !== undefined){
            fb_achieved_current_year = fb_data[0][0]['fb_achieved_sum']
            fb_target_current_year = fb_data[0][0]['fb_target_sum']
        }

        if(fb_target_current_year === 0){fb_target_current_year = 1}
        let fb_iya = (fb_achieved_current_year / fb_target_current_year) * 100
        if(fb_target_current_year === 1){fb_target_current_year = 0}

        let categoryList = []
        for(let i in categorySet){
            let obj = {}
            obj[`${i}`] = categorySet[i]
            categoryList.push(obj)
        }

        let focusbrand ={
            "fbActual": fb_achieved_current_year,
            "fbTarget": fb_target_current_year,
            "fbIYA": (parseInt(fb_iya).toFixed(2).split(".")[0]),
        }
        if(filter_data === "allIndia"){filter_data = "All India"}
        focusbrand['filter'] = `${filter_data}`
        focusbrand['month'] = `${date}`
        focusbrand['Category'] = categoryList

        res.status(200).json([focusbrand]);

    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: e})
    }
}

let getDeepDivePageDataBySBF2 = async (req, res) =>{

    try {
        let all_data = req.body;
        let final_data = []
        for(let i in all_data){
            let data = all_data[i]
            let date = data.date;
            let filter_key;
            let filter_data;
            let filter_type = data
            let channel = data.channel
            delete filter_type.date;
            delete filter_type.channel;
            for(let key in filter_type){
                filter_key = key
                filter_data = filter_type[key]
            }
            if(filter_key==="allIndia"){filter_key="Division"
                filter_data = "allIndia"
            }

            let calendar_month_cy = `CY${date.split("-")[1]}-${date.split("-")[0]}`
            if (filter_data === "South-West"){filter_data="S-W"}
            if (filter_data === "North-East"){filter_data="N-E"}

            let db_data = []
            if(filter_data === "allIndia"){
                let data_query_ne = `select top(5) * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and Division = 'N-E' `
                let data_query_sw = `select top(5) * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and Division = 'S-W' `
                let db_data_ne = await sequelize.query(data_query_ne);
                let db_data_sw = await sequelize.query(data_query_sw);
                db_data = [...db_data_ne[0], ...db_data_sw[0]]
                // db_data=(db_data_ne)
                // db_data[0].push(db_data_sw[0])
            }else {
                let data_query = `select top(10) * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' `
                let db_data_filter = await sequelize.query(data_query);
                db_data=(db_data_filter[0])
            }

            let mergedArr = []
            if(db_data.length>5 && (db_data[0]['channelFilter'] === false)){
                if(filter_data === "allIndia"){
                    let data_query = ''
                    if(channel === ''){
                        data_query = `select * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') `
                    }else{
                        data_query = `select * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W')  and [ChannelName] = '${channel}'`
                    }
                    let db_data = await sequelize.query(data_query);
                    mergedArr = db_data[0]
                }else {
                    let data_query = ''
                    if(channel === ''){
                        data_query = `select * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' `
                    }else{
                        data_query = `select * FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' and [ChannelName] = '${channel}'`
                    }
                    let db_data = await sequelize.query(data_query);
                    mergedArr = db_data[0]
                }
                console.log("Data is already inserted.....")
            }
            else{

                let channel_query_billing
                let channel_query_productivity
                let exist_data_query = `delete FROM [dbo].[tbl_coverageDeepDiveData] where [Calendar Month] = '${calendar_month_cy}'`
                let delete_data = await sequelize.query(exist_data_query);

                if(channel === ''){
                    if(filter_data === 'allIndia'){
                        channel_query_billing = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum ,Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') group by Division ,[Cluster], [Site Name], [Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                        channel_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W')  group by Division ,[Cluster] ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`

                    }
                    else{

                        channel_query_billing = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum ,Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' group by Division ,[Cluster], [Site Name], [Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                        channel_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' group by Division ,[Cluster] ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`

                    }
                }else {
                    if(filter_data === 'allIndia'){
                        channel_query_billing = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum ,Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and [ChannelName] = '${channel}' group by Division ,[Cluster], [Site Name], [Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                        channel_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and [ChannelName] = '${channel}' group by Division ,[Cluster] ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`

                    }
                    else{

                        channel_query_billing = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum ,Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' and [ChannelName] = '${channel}' group by Division ,[Cluster], [Site Name], [Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`
                        channel_query_productivity = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum , Division ,[Cluster],[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}'  and [ChannelName] = '${channel}' group by Division ,[Cluster] ,[Site Name] ,[Branch Name], [ChannelName], [SubChannelName] order by [Division] ASC`

                    }
                }

                let categories_data_coverage = await sequelize.query(channel_query_billing)
                let categories_data_productivity = await sequelize.query(channel_query_productivity)

                let subChannelMap = {}
                for (let i = 0; i < categories_data_productivity[0].length; i++) {
                    subChannelMap[`${categories_data_productivity[0][i]['Division']}/${categories_data_productivity[0][i]['Site Name']}/${categories_data_productivity[0][i]['Branch Name']}/${categories_data_productivity[0][i]['ChannelName']}/${categories_data_productivity[0][i]['SubChannelName']}`] = (categories_data_productivity[0][i]['pro_sum']/categories_data_productivity[0][i]['target_sum'])*100
                }
                let channelFilter = false
                if(channel === ''){channelFilter = false}
                else{channelFilter = true}
                for (let i = 0; i < categories_data_coverage[0].length; i++) {
                    let obj = {
                        '[Calendar Month]': calendar_month_cy,
                        'Division' :   categories_data_coverage[0][i]['Division'],
                        'Site Name' :   categories_data_coverage[0][i]['Site Name'],
                        'Branch Name' :   categories_data_coverage[0][i]['Branch Name'],
                        'ChannelName' :   categories_data_coverage[0][i]['ChannelName'],
                        'SubChannelName' :   categories_data_coverage[0][i]['SubChannelName'],
                        'billed_sum' :   categories_data_coverage[0][i]['billed_sum'],
                        'coverage_sum' :   categories_data_coverage[0][i]['coverage_sum'],
                        'productivity_per' : subChannelMap[`${categories_data_coverage[0][i]['Division']}/${categories_data_coverage[0][i]['Site Name']}/${categories_data_coverage[0][i]['Branch Name']}/${categories_data_coverage[0][i]['ChannelName']}/${categories_data_coverage[0][i]['SubChannelName']}`] ? subChannelMap[`${categories_data_coverage[0][i]['Division']}/${categories_data_coverage[0][i]['Site Name']}/${categories_data_coverage[0][i]['Branch Name']}/${categories_data_coverage[0][i]['ChannelName']}/${categories_data_coverage[0][i]['SubChannelName']}`] : 0,
                        'user_id' : 1,
                        'channelFilter': channelFilter,
                        'Cluster' :   categories_data_coverage[0][i]['Cluster']
                    }
                    mergedArr.push(obj)
                }

                // console.time('making chunks')
                let chunks = lodash.chunk(mergedArr, 1000)
                for (let chunk of chunks) {
                    const columns = [
                        '[Calendar Month]',
                        '[Division]',
                        '[Site Name]',
                        '[Branch Name]',
                        '[ChannelName]',
                        '[SubChannelName]',
                        '[billed_sum]',
                        '[coverage_sum]',
                        '[productivity_per]',
                        '[user_id]',
                        '[channelFilter]',
                        '[Cluster]'
                    ];
                    const valuePlaceholders = chunk.map(() => `(${columns.map(() => '?').join(',')})`).join(',');
                    const values = chunk.map(obj => {
                        return Object.values(obj);
                    });
                    const flattenedValues = values.flat();
                    const query = `INSERT INTO [dbo].[tbl_coverageDeepDiveData] (${columns.join(',')}) VALUES ${valuePlaceholders}`;
                    sequelize.query(query, {replacements: flattenedValues, type: QueryTypes.INSERT});
                }
                // console.timeEnd('making chunks')
            }


            let DivisionObj = {}
            for(let i in mergedArr){
                let obj = {}
                let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                let Division = sanitizeInput(mergedArr[i]['Division'])
                let key  = `${Month}/${Division}`
                if(mergedArr[i]['billed_sum'] == null){mergedArr[i]['billed_sum'] = 0}
                if(mergedArr[i]['coverage_sum'] == null){mergedArr[i]['coverage_sum'] = 0}
                if(mergedArr[i]['productivity_per'] == null){mergedArr[i]['productivity_per'] = 0}
                if (key in DivisionObj){
                    DivisionObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                    DivisionObj[`${key}`]['coverage_sum'] += mergedArr[i]['coverage_sum']
                    DivisionObj[`${key}`]['productivity_per'] = parseFloat(((DivisionObj[`${key}`]['productivity_per'] + mergedArr[i]['productivity_per'])/2).toFixed(2))
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    DivisionObj[`${key}`]['billing_per'] = parseFloat(((DivisionObj[`${key}`]['billing_per'] + ((mergedArr[i]['billed_sum'])/(mergedArr[i]['coverage_sum']) * 100))/2).toFixed(2))
                }else{
                    obj={
                        'filter_key': mergedArr[i]['Division'],
                        'billed_sum': mergedArr[i]['billed_sum'],
                        'coverage_sum': mergedArr[i]['coverage_sum'],
                        'productivity_per': parseFloat((mergedArr[i]['productivity_per']).toFixed(2)),
                        'Site' : []
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    obj['billing_per'] =  parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                        DivisionObj[key] = obj
                }
            }

            let SiteObj = {}
            for(let i in mergedArr){
                let obj = {}
                let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                let Division = sanitizeInput(mergedArr[i]['Division'])
                let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                let key  = `${Month}/${Division}/${Site_Name}`
                if(mergedArr[i]['billed_sum'] == null){mergedArr[i]['billed_sum'] = 0}
                if(mergedArr[i]['coverage_sum'] == null){mergedArr[i]['coverage_sum'] = 0}
                if(mergedArr[i]['productivity_per'] == null){mergedArr[i]['productivity_per'] = 0}
                if (key in SiteObj){
                    SiteObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                    SiteObj[`${key}`]['coverage_sum'] += mergedArr[i]['coverage_sum']
                    SiteObj[`${key}`]['productivity_per'] = parseFloat(((SiteObj[`${key}`]['productivity_per'] + mergedArr[i]['productivity_per'])/2).toFixed(2))
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    SiteObj[`${key}`]['billing_per'] = parseFloat(((SiteObj[`${key}`]['billing_per'] + ((mergedArr[i]['billed_sum'])/(mergedArr[i]['coverage_sum']) * 100))/2).toFixed(2))
                }else{
                    obj={
                        'filter_key': mergedArr[i]['Site Name'],
                        'billed_sum': mergedArr[i]['billed_sum'],
                        'coverage_sum': mergedArr[i]['coverage_sum'],
                        'productivity_per': parseFloat((mergedArr[i]['productivity_per']).toFixed(2)),
                        'Branch' : []
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    obj['billing_per'] =  parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                        SiteObj[key] = obj
                }
            }


            let BranchObj = {}
            for(let i in mergedArr){
                let obj = {}
                let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                let Division = sanitizeInput(mergedArr[i]['Division'])
                let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                let key  = `${Month}/${Division}/${Site_Name}/${Branch_Name}`
                if(mergedArr[i]['billed_sum'] == null){mergedArr[i]['billed_sum'] = 0}
                if(mergedArr[i]['coverage_sum'] == null){mergedArr[i]['coverage_sum'] = 0}
                if(mergedArr[i]['productivity_per'] == null){mergedArr[i]['productivity_per'] = 0}
                if (key in BranchObj){
                    BranchObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                    BranchObj[`${key}`]['coverage_sum'] += mergedArr[i]['coverage_sum']
                    BranchObj[`${key}`]['productivity_per'] = parseFloat(((BranchObj[`${key}`]['productivity_per'] + mergedArr[i]['productivity_per'])/2).toFixed(2))
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    BranchObj[`${key}`]['billing_per'] = parseFloat(((BranchObj[`${key}`]['billing_per'] + ((mergedArr[i]['billed_sum'])/(mergedArr[i]['coverage_sum']) * 100))/2).toFixed(2))
                }else{
                    obj={
                        'filter_key': mergedArr[i]['Branch Name'],
                        'billed_sum': mergedArr[i]['billed_sum'],
                        'coverage_sum': mergedArr[i]['coverage_sum'],
                        'productivity_per': parseFloat((mergedArr[i]['productivity_per']).toFixed(2)),
                        'Channel' : []
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    obj['billing_per'] =  parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                        BranchObj[key] = obj
                }
            }


            let ChannelObj = {}
            for(let i in mergedArr){
                let obj = {}
                let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                let Division = sanitizeInput(mergedArr[i]['Division'])
                let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                let ChannelName = sanitizeInput(mergedArr[i]['ChannelName'])
                let key  = `${Month}/${Division}/${Site_Name}/${Branch_Name}/${ChannelName}`
                if(mergedArr[i]['billed_sum'] == null){mergedArr[i]['billed_sum'] = 0}
                if(mergedArr[i]['coverage_sum'] == null){mergedArr[i]['coverage_sum'] = 0}
                if(mergedArr[i]['productivity_per'] == null){mergedArr[i]['productivity_per'] = 0}
                if (key in ChannelObj){
                    ChannelObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                    ChannelObj[`${key}`]['coverage_sum'] += mergedArr[i]['coverage_sum']
                    ChannelObj[`${key}`]['productivity_per'] = parseFloat(((ChannelObj[`${key}`]['productivity_per'] + mergedArr[i]['productivity_per'])/2).toFixed(2))
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    ChannelObj[`${key}`]['billing_per'] = parseFloat(((ChannelObj[`${key}`]['billing_per'] + ((mergedArr[i]['billed_sum'])/(mergedArr[i]['coverage_sum']) * 100))/2).toFixed(2))
                }else{
                    obj={
                        'filter_key': mergedArr[i]['ChannelName'],
                        'billed_sum': mergedArr[i]['billed_sum'],
                        'coverage_sum': mergedArr[i]['coverage_sum'],
                        'productivity_per': parseFloat((mergedArr[i]['productivity_per']).toFixed(2)),
                        'SubChannel' : []
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    obj['billing_per'] =  parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                        ChannelObj[key] = obj
                }
            }


            let subChannelObj = {}
            for(let i in mergedArr){
                let obj = {}
                let Month = sanitizeInput(mergedArr[i]['Calendar Month'])
                let Division = sanitizeInput(mergedArr[i]['Division'])
                let Site_Name = sanitizeInput(mergedArr[i]['Site Name'])
                let Branch_Name = sanitizeInput(mergedArr[i]['Branch Name'])
                let ChannelName = sanitizeInput(mergedArr[i]['ChannelName'])
                let SubChannelName = sanitizeInput(mergedArr[i]['SubChannelName'])
                let key  = `${Month}/${Division}/${Site_Name}/${Branch_Name}/${ChannelName}/${SubChannelName}`
                if(mergedArr[i]['billed_sum'] == null){mergedArr[i]['billed_sum'] = 0}
                if(mergedArr[i]['coverage_sum'] == null){mergedArr[i]['coverage_sum'] = 0}
                if(mergedArr[i]['productivity_per'] == null){mergedArr[i]['productivity_per'] = 0}
                if (key in subChannelObj){
                    subChannelObj[`${key}`]['billed_sum'] += mergedArr[i]['billed_sum']
                    subChannelObj[`${key}`]['coverage_sum'] += mergedArr[i]['coverage_sum']
                    subChannelObj[`${key}`]['productivity_per'] = parseFloat(((subChannelObj[`${key}`]['productivity_per'] + mergedArr[i]['productivity_per'])/2).toFixed(2))
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    subChannelObj[`${key}`]['billing_per'] = parseFloat(((subChannelObj[`${key}`]['billing_per'] + ((mergedArr[i]['billed_sum'])/(mergedArr[i]['coverage_sum']) * 100))/2).toFixed(2))
                }else{
                    obj={
                        'filter_key': mergedArr[i]['SubChannelName'],
                        'billed_sum': mergedArr[i]['billed_sum'],
                        'coverage_sum': mergedArr[i]['coverage_sum'],
                        'productivity_per': parseFloat((mergedArr[i]['productivity_per']).toFixed(2))
                    }
                    if(mergedArr[i]['coverage_sum'] === 0){mergedArr[i]['coverage_sum'] = 1}
                    obj['billing_per'] =  parseFloat(((mergedArr[i]['billed_sum']) / (mergedArr[i]['coverage_sum']) * 100).toFixed(2)),
                        subChannelObj[key] = obj
                }
            }

            for( let i in subChannelObj){
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                ChannelObj[key]['SubChannel'].push(subChannelObj[i])
            }

            for( let i in ChannelObj){
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                BranchObj[key]['Channel'].push(ChannelObj[i])
            }

            for( let i in BranchObj){
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                SiteObj[key]['Branch'].push(BranchObj[i])
            }

            for( let i in SiteObj){
                let key = i
                key = i.split("/")
                key.pop()
                key = key.join("/")
                DivisionObj[key]['Site'].push(SiteObj[i])
            }




            let divList = []
            for(let i in DivisionObj){
                divList.push(DivisionObj[i])
            }

            let sql_query_no_of_billing_current_year
            let sql_query_no_of_productivity_current_year

            if(channel === ''){
                if(filter_data === 'allIndia'){
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where Division in ('N-E', 'S-W') and [Calendar Month] = '${calendar_month_cy}'`
                    sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W')`
                }
                else{
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}'`
                    sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}'`
                }
            }else {
                if(filter_data === 'allIndia'){
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where Division in ('N-E', 'S-W') and [Calendar Month] = '${calendar_month_cy}' and [ChannelName] = '${channel}'`
                    sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and [ChannelName] = '${channel}' `
                }
                else{
                    sql_query_no_of_billing_current_year = `select sum([No of stores billed atleast once]) as billed_sum , sum([Coverage]) as coverage_sum from [dbo].[tbl_command_center_billing_new] where [${filter_key}] = '${filter_data}' and [Calendar Month] = '${calendar_month_cy}' and [ChannelName] = '${channel}' `
                    sql_query_no_of_productivity_current_year = `select sum([Productive Calls]) as pro_sum , sum([Target Calls]) as target_sum FROM [dbo].[tbl_command_center_productivity_new] where [Calendar Month] = '${calendar_month_cy}' and [${filter_key}] = '${filter_data}' and [ChannelName] = '${channel}' `
                }
            }

            let billing_and_coverage_data = await sequelize.query(sql_query_no_of_billing_current_year)
            let productivity_data = await sequelize.query(sql_query_no_of_productivity_current_year)
            let billing = 0
            let productivity_call = 0
            let productivity_target = 1
            let coverage = 1
            let target_calls = 1

            if(billing_and_coverage_data[0][0] !== undefined){
                billing = billing_and_coverage_data[0][0]['billed_sum']
                coverage = billing_and_coverage_data[0][0]['coverage_sum']
            }

            if(productivity_data[0][0] !== undefined){
                productivity_call = productivity_data[0][0]['pro_sum']
                productivity_target = productivity_data[0][0]['target_sum']
            }

            if(billing === null){billing = 0}
            if(coverage === null){coverage = 1}
            if(productivity_call === null){productivity_call = 0}
            if(productivity_target === null){productivity_target = 1}
            if(coverage === 0){coverage = 1}
            let billing_per = (billing / coverage) * 100
            let productivity_per = (productivity_call / productivity_target) * 100
            if(coverage === 1){coverage = 0}

            let objData = {
                "billing_per": parseInt(`${billing_per}`.split(".")[0]),
                "Coverage": parseInt(coverage.toFixed(2).split(".")[0]),
                "productivity_per": parseInt(productivity_per.toFixed(2).split(".")[0])
            }
            if(filter_data === 'allIndia'){filter_data = 'All India'}
            objData['filter'] = `${filter_data}`
            objData['month'] = `${date}`
            objData["division"] = divList
            final_data.push([objData])


        }

        res.status(200).json(final_data);
        // console.timeEnd('api start')


    }catch (e) {
        console.log('error',e)
        res.status(500).send({successful: false, error: e})
    }
}


let getPostTest = async (req, res) =>{
    console.log("Post Api Called")
    res.send("Hello POST API called")
}

let getGetTest = async (req, res) =>{
    console.log("Post Api Called")
    res.send("Hello GET API called")
}


module.exports = {
    getDeepDivePageDataBySBF,
    getPostTest,
    getGetTest
}

