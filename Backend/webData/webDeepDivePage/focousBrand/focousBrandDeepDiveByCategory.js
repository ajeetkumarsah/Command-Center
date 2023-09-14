const {sequelize} = require('../../../databaseConnection/sql_connection');

const cache = require("memory-cache");

function copyObject(obj) {
    return JSON.parse(JSON.stringify(obj));
}

function deepEqual(obj1, obj2) {
    // Convert objects to JSON strings and compare them
    const json1 = JSON.stringify(obj1);
    const json2 = JSON.stringify(obj2);

    return json1 === json2;
}

async function getTableData(bodyData){
    let reqDate = ''
    let all_data = copyObject(bodyData);
    let final_result = []
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

        if(filter_key === 'category'){filter_key = 'CategoryName'}
        if(filter_key === 'brand'){filter_key = 'BrandName'}
        if(filter_key === 'brandForm'){filter_key = 'BFName'}
        if(filter_key === 'sbfGroup'){filter_key = 'SBFGroup'}

        if(filter_key !== undefined & filter_data !== ''){
            filter_2 = {
                filter_key : filter_key,
                filter_data : filter_data
            }
        }

        let calendar_month_cy = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if (filter_data === "South-West") {
            filter_data = "S-W"
        }
        if (filter_data === "North-East") {
            filter_data = "N-E"
        }

        let mergedArr = []
        let channel_query_fb

        if (filter_2 === '') {
            if(channel.length === 0){
                if (filter_1['filter_data'] === 'allIndia') {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum ,[Calendar Month], Division ,[Site Name] ,[CategoryName], [BrandName], [BFName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in ('${calendar_month_cy}') and Division in ('N-E', 'S-W')  group by [FB Type], [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName] order by [Division] ASC`
                } else {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in ('${calendar_month_cy}') and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' group by [FB Type], [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName] order by [Division] ASC`
                }
            }else{
                if (filter_1['filter_data'] === 'allIndia') {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum ,[Calendar Month], Division ,[Site Name] ,[CategoryName], [BrandName], [BFName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in ('${calendar_month_cy}') and Division in ('N-E', 'S-W') and [ChannelName] in (${channel})  group by [FB Type], [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName] order by [Division] ASC`
                } else {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in ('${calendar_month_cy}') and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [ChannelName] in (${channel}) group by [FB Type], [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName] order by [Division] ASC`
                }
            }

        } else {
            if(channel.length === 0){
                if (filter_1['filter_data'] === 'allIndia') {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in ('${calendar_month_cy}') and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' group by [FB Type], [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName] order by [Division] ASC`
                } else {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in ('${calendar_month_cy}') and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' group by [FB Type], [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName] order by [Division] ASC`
                }
            }else {
                if (filter_1['filter_data'] === 'allIndia') {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in ('${calendar_month_cy}') and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [ChannelName] in (${channel}) group by [FB Type], [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName] order by [Division] ASC`
                } else {
                    channel_query_fb = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum , [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName], [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] in ('${calendar_month_cy}') and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [ChannelName] in (${channel}) group by [FB Type], [Calendar Month],Division ,[Site Name] ,[CategoryName], [BrandName], [BFName] order by [Division] ASC`
                }
            }

        }
        // console.time("Data Fetching")

        let categories_data_fb = await sequelize.query(channel_query_fb)
        // console.timeEnd("Data Fetching")
        mergedArr = categories_data_fb[0]
        if(mergedArr.length<=0){
            res.status(400).send({successful: false, message: "DB do not have data for this filter"})
            return 0
        }

        let CategoryObj = {}
        for (let i in mergedArr) {
            let fb_target_base = 0
            if (mergedArr[i]['FB Type'] === 'Base') {
                fb_target_base = mergedArr[i]['fb_target_sum']
            }
            let obj = {}
            let key = `${mergedArr[i]['Calendar Month']}/${mergedArr[i]['CategoryName']}`
            if (mergedArr[i]['fb_achieve_sum'] == null) {
                mergedArr[i]['fb_achieve_sum'] = 0
            }
            if (mergedArr[i]['fb_target_sum'] == null) {
                mergedArr[i]['fb_target_sum'] = 0
            }
            if (key in CategoryObj) {
                CategoryObj[`${key}`]['fb_achieve_sum'] = parseFloat((CategoryObj[`${key}`]['fb_achieve_sum'] + mergedArr[i]['fb_achieve_sum']).toFixed(2))
                CategoryObj[`${key}`]['fb_target_sum'] = parseFloat((CategoryObj[`${key}`]['fb_target_sum'] + mergedArr[i]['fb_target_sum']).toFixed(2))
                CategoryObj[`${key}`]['fb_target_base_sum'] = parseFloat((CategoryObj[`${key}`]['fb_target_base_sum'] + fb_target_base).toFixed(2))
                if (mergedArr[i]['fb_target_sum'] === 0) {
                    mergedArr[i]['fb_target_sum'] = 1
                }
                CategoryObj[`${key}`]['fb_per'] = parseFloat(((((CategoryObj[`${key}`]['fb_achieve_sum']) / (CategoryObj[`${key}`]['fb_target_base_sum']) * 100))).toFixed(2))
            } else {
                obj = {
                    'filter_key': mergedArr[i]['CategoryName'],
                    'fb_achieve_sum': parseFloat((mergedArr[i]['fb_achieve_sum']).toFixed(2)),
                    'fb_target_sum': parseFloat((mergedArr[i]['fb_target_sum']).toFixed(2)),
                    'fb_target_base_sum': fb_target_base,
                    'Brand': []
                }
                if (fb_target_base === 0) {
                    fb_target_base = 1
                }
                obj['fb_per'] = parseFloat((((mergedArr[i]['fb_achieve_sum']) / (fb_target_base)) * 100).toFixed(2)),
                    CategoryObj[key] = obj

            }
        }

        let BrandObj = {}
        for (let i in mergedArr) {
            let fb_target_base = 0
            if (mergedArr[i]['FB Type'] === 'Base') {
                fb_target_base = mergedArr[i]['fb_target_sum']
            }
            let obj = {}
            let key = `${mergedArr[i]['Calendar Month']}/${mergedArr[i]['CategoryName']}/${mergedArr[i]['BrandName']}`
            if (mergedArr[i]['fb_achieve_sum'] == null) {
                mergedArr[i]['fb_achieve_sum'] = 0
            }
            if (mergedArr[i]['fb_target_sum'] == null) {
                mergedArr[i]['fb_target_sum'] = 0
            }
            if (key in BrandObj) {
                BrandObj[`${key}`]['fb_achieve_sum'] = parseFloat((BrandObj[`${key}`]['fb_achieve_sum'] + mergedArr[i]['fb_achieve_sum']).toFixed(2))
                BrandObj[`${key}`]['fb_target_sum'] = parseFloat((BrandObj[`${key}`]['fb_target_sum'] + mergedArr[i]['fb_target_sum']).toFixed(2))
                BrandObj[`${key}`]['fb_target_base_sum'] = parseFloat((BrandObj[`${key}`]['fb_target_base_sum'] + fb_target_base).toFixed(2))
                if (mergedArr[i]['fb_target_sum'] === 0) {
                    mergedArr[i]['fb_target_sum'] = 1
                }
                BrandObj[`${key}`]['fb_per'] = parseFloat(((((BrandObj[`${key}`]['fb_achieve_sum']) / (BrandObj[`${key}`]['fb_target_base_sum']) * 100))).toFixed(2))
            } else {
                obj = {
                    'filter_key': mergedArr[i]['BrandName'],
                    'fb_achieve_sum': parseFloat((mergedArr[i]['fb_achieve_sum']).toFixed(2)),
                    'fb_target_sum': parseFloat((mergedArr[i]['fb_target_sum']).toFixed(2)),
                    'fb_target_base_sum': parseFloat((fb_target_base).toFixed(2)),
                    'BrandForm': []
                }
                if (fb_target_base === 0) {
                    fb_target_base = 1
                }
                obj['fb_per'] = parseFloat((((mergedArr[i]['fb_achieve_sum']) / (fb_target_base)) * 100).toFixed(2)),
                    BrandObj[key] = obj
            }
        }

        let BFObj = {}
        for (let i in mergedArr) {
            let fb_target_base = 0
            if (mergedArr[i]['FB Type'] === 'Base') {
                fb_target_base = mergedArr[i]['fb_target_sum']
            }
            let obj = {}
            let key = `${mergedArr[i]['Calendar Month']}/${mergedArr[i]['CategoryName']}/${mergedArr[i]['BrandName']}/${mergedArr[i]['BFName']}`
            if (mergedArr[i]['fb_achieve_sum'] == null) {
                mergedArr[i]['fb_achieve_sum'] = 0
            }
            if (mergedArr[i]['fb_target_sum'] == null) {
                mergedArr[i]['fb_target_sum'] = 0
            }
            if (key in BFObj) {
                BFObj[`${key}`]['fb_achieve_sum'] = parseFloat((BFObj[`${key}`]['fb_achieve_sum'] + mergedArr[i]['fb_achieve_sum']).toFixed(2))
                BFObj[`${key}`]['fb_target_sum'] = parseFloat((BFObj[`${key}`]['fb_target_sum'] + mergedArr[i]['fb_target_sum']).toFixed(2))
                BFObj[`${key}`]['fb_target_base_sum'] = parseFloat((BFObj[`${key}`]['fb_target_base_sum'] + fb_target_base).toFixed(2))
                if (mergedArr[i]['fb_target_sum'] === 0) {
                    mergedArr[i]['fb_target_sum'] = 1
                }
                BFObj[`${key}`]['fb_per'] = parseFloat(((((BFObj[`${key}`]['fb_achieve_sum']) / (BFObj[`${key}`]['fb_target_base_sum']) * 100))).toFixed(2))
            } else {
                obj = {
                    'filter_key': mergedArr[i]['BFName'],
                    'fb_achieve_sum': parseFloat((mergedArr[i]['fb_achieve_sum']).toFixed(2)),
                    'fb_target_base_sum': parseFloat((fb_target_base).toFixed(2)),
                    'fb_target_sum': parseFloat((mergedArr[i]['fb_target_sum']).toFixed(2)),
                }
                if (fb_target_base === 0) {
                    fb_target_base = 1
                }
                obj['fb_per'] = parseFloat((((mergedArr[i]['fb_achieve_sum']) / (fb_target_base)) * 100).toFixed(2)),
                    BFObj[key] = obj
            }
        }

        for (let i in BFObj) {
            let key = i
            key = i.split("/")
            key.pop()
            key = key.join("/")
            BrandObj[key]['BrandForm'].push(BFObj[i])
        }

        for (let i in BrandObj) {
            let key = i
            key = i.split("/")
            key.pop()
            key = key.join("/")
            CategoryObj[key]['Brand'].push(BrandObj[i])
        }

        let sql_query_no_of_fb_current_year

        if (filter_2 === '') {
            if(channel.length === 0){
                if (filter_1['filter_data'] === 'allIndia') {
                    sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum, [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') group by [FB Type]`
                } else {
                    sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum, [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' group by [FB Type]`
                }
            }else {
                if (filter_1['filter_data'] === 'allIndia') {
                    sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum, [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and [ChannelName] in (${channel}) group by [FB Type]`
                } else {
                    sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum, [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [ChannelName] in (${channel}) group by [FB Type]`
                }
            }

        } else {
            if(channel.length === 0){
                if (filter_1['filter_data'] === 'allIndia') {
                    sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum, [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' group by [FB Type]`
                } else {
                    sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum, [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' group by [FB Type]`
                }
            }else {
                if (filter_1['filter_data'] === 'allIndia') {
                    sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum, [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and Division in ('N-E', 'S-W') and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [ChannelName] in (${channel}) group by [FB Type]`
                } else {
                    sql_query_no_of_fb_current_year = `select SUM([FB Points achieved]) as fb_achieve_sum , SUM([FB Target]) as fb_target_sum, [FB Type] FROM [dbo].[tbl_command_center_fb_new2] where [Calendar Month] = '${calendar_month_cy}' and [${filter_1['filter_key']}] = '${filter_1['filter_data']}' and [${filter_2['filter_key']}] = '${filter_2['filter_data']}' and [ChannelName] in (${channel}) group by [FB Type]`
                }
            }

        }

        let fb_data = await sequelize.query(sql_query_no_of_fb_current_year)
        let fb_call = 0
        let fb_target = 1
        let fb_target_base = 1
        let coverage = 1

        // for (let i in DivisionObj) {
        //     fb_target_base = parseFloat((fb_target_base + DivisionObj[i]['fb_target_base_sum']).toFixed(2))
        // }
        for(let i in fb_data[0]){
            if (fb_data[0][i] !== undefined) {
                if(fb_data[0][i]['FB Type'] === 'Base'){
                    fb_call += parseFloat((fb_data[0][i]['fb_achieve_sum']).toFixed(2))
                    fb_target_base += parseFloat((fb_data[0][i]['fb_target_sum']).toFixed(2))
                    fb_target += parseFloat((fb_data[0][i]['fb_target_sum']).toFixed(2))
                }else {
                    fb_call += parseFloat((fb_data[0][i]['fb_achieve_sum']).toFixed(2))
                    fb_target += parseFloat((fb_data[0][i]['fb_target_sum']).toFixed(2))
                }
            }
        }

        if (fb_call === null) {
            fb_call = 0
        }
        if (fb_target === null) {
            fb_target = 1
        }
        if (coverage === 0) {
            coverage = 1
        }
        let fb_per = (fb_call / fb_target_base) * 100
        if (coverage === 1) {
            coverage = 0
        }

        let objData = {
            "fb_per": parseInt(fb_per.toFixed(2).split(".")[0])
        }
        let catList = []
        for (let i in CategoryObj) {
            catList.push(CategoryObj[i])
        }
        if (filter_data === 'allIndia') {
            filter_data = 'All India'
        }
        objData['filter_key'] = `${filter_1['filter_data']}`
        objData['filter_key2'] = `${filter_2['filter_data'] ? filter_2['filter_data'] : ''}`
        objData['channel'] = channel_list.map(item => item).join("/")
        objData['month'] = `${calendar_month_cy}`
        objData['fb_achieve_sum'] = parseFloat(`${fb_call}`)
        objData['fb_target_sum'] = parseFloat(`${fb_target}`)
        objData['fb_target_base_sum'] = parseFloat(`${fb_target_base}`)
        objData["Category"] = catList
        final_data.push(objData)
        if (filter_data === 'All India') {
            filter_data = 'allIndia'
        }
        final_result.push(final_data)
    }
    return final_result;
}

let getDeepDivePageData = async (req, res) => {
    try {
        let time_to_live = 7*24*60*60*1000 // Time in milliseconds for 7 days
        let cacheKey = 'fbCategoryDeepDiveData'
        let final_result = []
        if(cache.get(cacheKey)){
            let cacheData = cache.get(cacheKey)
            let nonMatchedIndex = []
            let matchedDataList = []
            for(let k in cacheData){
                let cachebodyData = cacheData[k]['reqBody']
                let curReq = req.body
                for(let i=0; i<curReq.length; i++){
                    let matched = false
                    for(let n = 0; n<cachebodyData.length; n++){
                        if (deepEqual(cachebodyData[n], curReq[i])) {
                            if((cachebodyData[n]['channel'].map(item => `'${item}'`).join(", ")) === (curReq[i]['channel'].map(item => `'${item}'`).join(", "))){
                                matchedDataList.push(cacheData[k]['resData'][n])
                                matched = true
                                console.log("Data fetched from cache")
                            }
                        }
                    }
                    if(!matched){
                        nonMatchedIndex.push(curReq[i])
                    }
                }
            }

            let finalData = await getTableData(nonMatchedIndex)
            for(let i in nonMatchedIndex){
                if(finalData.length>0){
                    matchedDataList.push(finalData[i])
                    cacheData[0]['reqBody'].push(nonMatchedIndex[i])
                    cacheData[0]['resData'].push(finalData[i])
                    console.log("Putting data into cache")
                }else{
                    console.log("There is no data for this query");
                }
            }
            res.status(200).json(matchedDataList);
        }else {
            final_result = await getTableData(req.body)
            if(final_result.length>0){
                let obj ={
                    'reqBody': req.body,
                    'resData': final_result
                }
                cache.put(cacheKey, [obj], time_to_live);
                console.log("Putting data into cache");
            }else{
                console.log("There is no data for this query");
            }
            res.status(200).json(final_result);
        }

    } catch (e) {
        console.log('error', e)
        res.status(500).send({successful: false, error: e})
    }
}

module.exports = {
    getDeepDivePageData
}
