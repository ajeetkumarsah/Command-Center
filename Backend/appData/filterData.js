// const {sequelize} = require('../databaseConnection/sql_connection');
const {getConnection, getQueryData} = require('../databaseConnection/dbConnection');
// const {sequelize2} = require('../databaseConnection/sql_connection2');

let getDivisionFilterData = async (req, res) =>{
    try {
        // console.log("getDivisionFilterData invoked")
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct Division FROM [da].[locationHierarchy_updated]`)
        // console.log("getDivisionFilterData invoked2")
        let division = []
        for(let div in data){
            if(data[div]['Division'] === 'DIV_0001'){ data[div]['Division'] = 'South-West'; division.push(data[div]['Division'])}
            if(data[div]['Division'] === 'DIV_0002'){ data[div]['Division'] = 'North-East'; division.push(data[div]['Division'])}
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
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [SiteName] FROM [da].[locationHierarchy_updated]`)
        let site = []
        for(let div in data){
            site.push(data[div]['SiteName'])
            console.log((data[div]['SiteName']))
        }
        res.status(200).send({successful: true, data: site})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.' })
    }
}

let getCategoryFilterData = async (req, res) =>{
    try {
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [CategoryName] from [sdm].[productMaster]`)
        let category = []
        for(let i in data){
            category.push(data[i]['CategoryName'])
            console.log((data[i]['CategoryName']))
        }
        res.status(200).send({successful: true, data: category})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.' })
    }
}

let getBrandFilterData = async (req, res) =>{
    try {
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [BrandName] from [sdm].[productMaster]`)
        let brand = []
        for(let i in data){
            brand.push(data[i]['BrandName'])
            console.log((data[i]['BrandName']))
        }
        res.status(200).send({successful: true, data: brand})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getBrandFormFilterData = async (req, res) =>{
    try {
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [BrandformName] from [sdm].[productMaster]`)
        let brandForm = []
        for(let i in data){
            brandForm.push(data[i]['BrandformName'])
            console.log((data[i]['BrandformName']))
        }
        res.status(200).send({successful: true, data: brandForm})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getSubBrandFormFilterData = async (req, res) =>{
    try {
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [SubbfName] from [sdm].[productMaster]`)
        let subBrandForm = []
        for(let i in data){
            subBrandForm.push(data[i]['SubbfName'])
            console.log((data[i]['SubbfName']))
        }
        res.status(200).send({successful: true, data: subBrandForm})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getBranchFilterData = async (req, res) =>{
    try {
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [BranchName] FROM [da].[locationHierarchy_updated]`)
        let branch = []
        for(let div in data){
            // Here we are using replace because there is more <""> are there in data so to remove that
            branch.push(data[div]['BranchName'].replace(/^"|"$/g, ''))
            console.log((data[div]['BranchName']))
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
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [ClusterName] FROM [da].[locationHierarchy_updated]`)
        let cluster = []
        for(let div in data){
            if(data[div]['ClusterName'] === null){
                data[div]['ClusterName'] = "NULL"
            }
            cluster.push(data[div]['ClusterName'])
            console.log((data[div]['ClusterName']))
        }
        res.status(200).send({successful: true, data: cluster})
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getSubBrandFormGroupFilterData = async (req, res) =>{
    try {
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [SubbfGroupName]  from [sdm].[productMaster] order by [SubbfGroupName]`)
        let subBrandGroup = []
        for(let i in data){
            subBrandGroup.push(data[i]['SubbfGroupName'])
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

        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        let category = []
        for(let i in data){
            category.push(data[i]['CategoryName'])
            console.log((data[i]['CategoryName']))
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

        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        let brand = []
        for(let i in data){
            brand.push(data[i]['BrandName'])
            console.log((data[i]['BrandName']))
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

        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        let brand = []
        for(let i in data){
            brand.push(data[i]['BFName'])
            console.log((data[i]['BFName']))
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

        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        let brand = []
        for(let i in data){
            brand.push(data[i]['SBFGroup'])
            console.log((data[i]['SBFGroup']))
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

        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        let channel = []
        for(let i in data){
            channel.push(data[i]['ChannelName'])
            console.log((data[i]['ChannelName']))
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
