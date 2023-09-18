const {sequelize} = require('../databaseConnection/sql_connection');
// const {sequelize2} = require('../databaseConnection/sql_connection2');

let getDivisionFilterData = async (req, res) =>{
    try {
        // console.log("getDivisionFilterData invoked")
        let data = await sequelize.query(`select distinct Division FROM [da].[locationHierarchy_updated]`)
        // console.log("getDivisionFilterData invoked2")
        let division = []
        for(let div in data[0]){
            if(data[0][div]['Division'] === 'DIV_0001'){ data[0][div]['Division'] = 'South-West'; division.push(data[0][div]['Division'])}
            if(data[0][div]['Division'] === 'DIV_0002'){ data[0][div]['Division'] = 'North-East'; division.push(data[0][div]['Division'])}
        }
        // console.log("getDivisionFilterData fetched data successfully")
        res.status(200).send({successful: true, data: division})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.' })
    }
}

let getSiteFilterData = async (req, res) =>{
    try {
        let data = await sequelize.query(`select distinct [SiteName] FROM [da].[locationHierarchy_updated]`)
        let site = []
        for(let div in data[0]){
            site.push(data[0][div]['SiteName'])
            console.log((data[0][div]['SiteName']))
        }
        res.status(200).send({successful: true, data: site})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.' })
    }
}

let getCategoryFilterData = async (req, res) =>{
    try {
        let data = await sequelize.query(`select distinct [CategoryName] from [sdm].[productMaster]`)
        let category = []
        for(let i in data[0]){
            category.push(data[0][i]['CategoryName'])
            console.log((data[0][i]['CategoryName']))
        }
        res.status(200).send({successful: true, data: category})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.' })
    }
}

let getBrandFilterData = async (req, res) =>{
    try {
        let data = await sequelize.query(`select distinct [BrandName] from [sdm].[productMaster]`)
        let brand = []
        for(let i in data[0]){
            brand.push(data[0][i]['BrandName'])
            console.log((data[0][i]['BrandName']))
        }
        res.status(200).send({successful: true, data: brand})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getBrandFormFilterData = async (req, res) =>{
    try {
        let data = await sequelize.query(`select distinct [BrandformName] from [sdm].[productMaster]`)
        let brandForm = []
        for(let i in data[0]){
            brandForm.push(data[0][i]['BrandformName'])
            console.log((data[0][i]['BrandformName']))
        }
        res.status(200).send({successful: true, data: brandForm})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getSubBrandFormFilterData = async (req, res) =>{
    try {
        let data = await sequelize.query(`select distinct [SubbfName] from [sdm].[productMaster]`)
        let subBrandForm = []
        for(let i in data[0]){
            subBrandForm.push(data[0][i]['SubbfName'])
            console.log((data[0][i]['SubbfName']))
        }
        res.status(200).send({successful: true, data: subBrandForm})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getBranchFilterData = async (req, res) =>{
    try {
        let data = await sequelize.query(`select distinct [BranchName] FROM [da].[locationHierarchy_updated]`)
        let branch = []
        for(let div in data[0]){
            // Here we are using replace because there is more <""> are there in data so to remove that
            branch.push(data[0][div]['BranchName'].replace(/^"|"$/g, ''))
            console.log((data[0][div]['BranchName']))
        }
        res.status(200).send({successful: true, data: branch})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getChannelFilterData = async (req, res) =>{
    try {
        let channel_list = [
            'CONVENIENCE',
            'MINIMARKET',
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
        res.status(200).send({successful: true, data: channel_list})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}


let getClusterFilterData = async (req, res) =>{
    try {
        let data = await sequelize.query(`select distinct [ClusterName] FROM [da].[locationHierarchy_updated]`)
        let cluster = []
        for(let div in data[0]){
            if(data[0][div]['ClusterName'] === null){
                data[0][div]['ClusterName'] = "NULL"
            }
            cluster.push(data[0][div]['ClusterName'])
            console.log((data[0][div]['ClusterName']))
        }
        res.status(200).send({successful: true, data: cluster})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getSubBrandFormGroupFilterData = async (req, res) =>{
    try {
        let data = await sequelize.query(`select distinct [SubbfGroupName]  from [sdm].[productMaster] order by [SubbfGroupName]`)
        let subBrandGroup = []
        for(let i in data[0]){
            subBrandGroup.push(data[0][i]['SubbfGroupName'])
        }
        res.status(200).send({successful: true, data: subBrandGroup})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getCategoryFilterDataByChannel = async (req, res) =>{
    try {
        let temp_table_name = "[dbo].[tbl_command_center_tableName_new]"
        let table_name = req.body.table
        let date = req.body.date
        let channel = req.body.channel
        let current_year = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if(table_name !== ""){
            if(table_name === 'fb' || table_name === 'gp'){
                temp_table_name = temp_table_name.replace("new", "new2")
                table_name = temp_table_name.replace("tableName", table_name)
            }else{
                table_name = temp_table_name.replace("tableName", table_name)
            }
        }

        let sql_query = ''
        if(channel === ""){
            sql_query = `select distinct [CategoryName] from ${table_name} where [Calendar Month] = '${current_year}' `
        }else {
            sql_query = `select distinct [CategoryName] from ${table_name} where [Calendar Month] = '${current_year}' and [ChannelName] = '${channel}' `
        }

        let data = await sequelize.query(sql_query)
        let category = []
        for(let i in data[0]){
            category.push(data[0][i]['CategoryName'])
            console.log((data[0][i]['CategoryName']))
        }
        res.status(200).send({successful: true, data: category})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getBrandFilterDataByChannel = async (req, res) =>{
    try {
        let temp_table_name = "[dbo].[tbl_command_center_tableName_new]"
        let table_name = req.body.table
        let date = req.body.date
        let channel = req.body.channel
        let category_name = req.body.category
        let current_year = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if(table_name !== ""){
            if(table_name === 'fb' || table_name === 'gp'){
                temp_table_name = temp_table_name.replace("new", "new2")
                table_name = temp_table_name.replace("tableName", table_name)
            }else{
                table_name = temp_table_name.replace("tableName", table_name)
            }
        }

        let sql_query = ''
        if(channel === ''){
            sql_query = `select distinct [BrandName] from ${table_name} where [Calendar Month] = '${current_year}' and [CategoryName] = '${category_name}' `
        }else {
            sql_query = `select distinct [BrandName] from ${table_name} where [Calendar Month] = '${current_year}' and [ChannelName] = '${channel}' and [CategoryName] = '${category_name}' `
        }

        let data = await sequelize.query(sql_query)
        let brand = []
        for(let i in data[0]){
            brand.push(data[0][i]['BrandName'])
            console.log((data[0][i]['BrandName']))
        }
        res.status(200).send({successful: true, data: brand})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getBrandFormFilterDataByChannel = async (req, res) =>{
    try {
        let temp_table_name = "[dbo].[tbl_command_center_tableName_new]"
        let table_name = req.body.table
        let date = req.body.date
        let channel = req.body.channel
        let category_name = req.body.category
        let brand_name = req.body.brand
        let current_year = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if(table_name !== ""){
            if(table_name === 'fb' || table_name === 'gp'){
                temp_table_name = temp_table_name.replace("new", "new2")
                table_name = temp_table_name.replace("tableName", table_name)
            }else{
                table_name = temp_table_name.replace("tableName", table_name)
            }
        }

        let sql_query = ''
        if(channel === ''){
            sql_query = `select distinct [BFName] from ${table_name} where [Calendar Month] = '${current_year}' and [CategoryName] = '${category_name}' and [BrandName] = '${brand_name}' `
        }else {
            sql_query = `select distinct [BFName] from ${table_name} where [Calendar Month] = '${current_year}' and [ChannelName] = '${channel}' and [CategoryName] = '${category_name}' and [BrandName] = '${brand_name}' `
        }

        let data = await sequelize.query(sql_query)
        let brand = []
        for(let i in data[0]){
            brand.push(data[0][i]['BFName'])
            console.log((data[0][i]['BFName']))
        }
        res.status(200).send({successful: true, data: brand})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getSBFGroupFilterDataByChannel = async (req, res) =>{
    try {
        let temp_table_name = "[dbo].[tbl_command_center_tableName_new]"
        let table_name = req.body.table
        let date = req.body.date
        let channel = req.body.channel
        let category_name = req.body.category
        let brand_name = req.body.brand
        let brandForm = req.body.brandForm
        let current_year = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if(table_name !== ""){
            if(table_name === 'fb' || table_name === 'gp'){
                temp_table_name = temp_table_name.replace("new", "new2")
                table_name = temp_table_name.replace("tableName", table_name)
            }else{
                table_name = temp_table_name.replace("tableName", table_name)
            }
        }

        let sql_query = ''
        if(channel === ''){
            sql_query = `select distinct [SBFGroup] from ${table_name} where [Calendar Month] = '${current_year}' and [CategoryName] = '${category_name}' and [BrandName] = '${brand_name}' and [BFName] = '${brandForm}' `
        }else {
            sql_query = `select distinct [SBFGroup] from ${table_name} where [Calendar Month] = '${current_year}' and [ChannelName] = '${channel}' and [CategoryName] = '${category_name}' and [BrandName] = '${brand_name}' and [BFName] = '${brandForm}' `
        }

        let data = await sequelize.query(sql_query)
        let brand = []
        for(let i in data[0]){
            brand.push(data[0][i]['SBFGroup'])
            console.log((data[0][i]['SBFGroup']))
        }
        res.status(200).send({successful: true, data: brand})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getChannelFilterDataByCategory = async (req, res) =>{
    try {
        let temp_table_name = "[dbo].[tbl_command_center_tableName_new]"
        let table_name = req.body.table
        let date = req.body.date
        let filter_key = '';
        let filter_data;
        let filter_type = req.body
        delete filter_type.date;
        delete filter_type.table;
        for(let key in filter_type){
            filter_key = key
            filter_data = filter_type[key]
        }
        let current_year = `CY${date.split("-")[1]}-${date.split("-")[0]}`
        if(table_name !== ""){
            if(table_name === 'fb'){
                temp_table_name = temp_table_name.replace("new", "new2")
                table_name = temp_table_name.replace("tableName", table_name)
            }else{
                table_name = "[dbo].[tbl_command_center_gp_channel_category_mapping]"
            }
        }
        let sql_query = ''
        if(filter_key === ''){
            sql_query = `select distinct [ChannelName] from ${table_name} where [Calendar Month] = '${current_year}' `
        }
        if(filter_key === 'category'){
            sql_query = `select distinct [ChannelName] from ${table_name} where [Calendar Month] = '${current_year}' and [CategoryName] = '${filter_data}' `
        }
        if(filter_key === 'brand'){
            sql_query = `select distinct [ChannelName] from ${table_name} where [Calendar Month] = '${current_year}' and [BrandName] = '${filter_data}' `
        }
        if(filter_key === 'brandForm'){
            sql_query = `select distinct [ChannelName] from ${table_name} where [Calendar Month] = '${current_year}' and [BFName] = '${filter_data}' `
        }
        if(filter_key === 'sbfGroup'){
            sql_query = `select distinct [ChannelName] from ${table_name} where [Calendar Month] = '${current_year}' and [SBFGroup] = '${filter_data}' `
        }

        let data = await sequelize.query(sql_query)
        let channel = []
        for(let i in data[0]){
            channel.push(data[0][i]['ChannelName'])
            console.log((data[0][i]['ChannelName']))
        }
        res.status(200).send({successful: true, data: channel})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

module.exports = {
    getDivisionFilterData,
    getSiteFilterData,
    getBranchFilterData,
    getClusterFilterData,
    getChannelFilterData,
    getCategoryFilterData,
    getBrandFilterData,
    getBrandFormFilterData,
    getSubBrandFormFilterData,
    getSubBrandFormGroupFilterData,
    getCategoryFilterDataByChannel,
    getBrandFilterDataByChannel,
    getBrandFormFilterDataByChannel,
    getSBFGroupFilterDataByChannel,
    getChannelFilterDataByCategory
}
