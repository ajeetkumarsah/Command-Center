// const {sequelize} = require('../databaseConnection/sql_connection');
const {getConnection, getQueryData} = require('../databaseConnection/dbConnection');

function getFilterArray(arrList){
    arrList = arrList.filter(item => item !== null);
    return arrList
}

function getQuery(data, colName){
    let queryBody = data
    let sbf_val = `'%'`
    let cat_val = `'%'`
    let des_opretor = 'like'
    let des_val = `'%'`
    let source_city_val = `'%'`
    let vehicle_type_val = `'%'`
    let monthDateValue = `'Primary', 'Secondary'`

    if(queryBody.movement !== ""){
        monthDateValue = `'${queryBody.movement}'`
    }

    let sql_query = `select distinct ${colName} FROM [pando].[pando_filter_records] where [month_date] in (${monthDateValue})`

    let additionalQuery =  ``

    if(queryBody.subBrandForm.length>0){
        // sbf_opretor = 'in'
        sbf_val = queryBody.subBrandForm.map(item => `'${item}'`).join(", ")
        additionalQuery = ` and [Subbf_Name] in (${sbf_val})`
        sql_query +=additionalQuery
    }
    if(queryBody.destination.length>0){
        des_opretor = 'in'
        des_val = queryBody.destination.map(item => `'${item}'`).join(", ")
        additionalQuery = ` and [Destination_city] in (${des_val})`
        sql_query +=additionalQuery
    }
    if(queryBody.sourceCity.length>0){
        // source_city_opretor = 'in'
        source_city_val = queryBody.sourceCity.map(item => `'${item}'`).join(", ")
        additionalQuery = ` and [Source_city] in (${source_city_val})`
        sql_query +=additionalQuery
    }
    if(queryBody.vehicleType.length>0){
        // vehicle_type_opretor = 'in'
        vehicle_type_val = queryBody.vehicleType.map(item => `'${item}'`).join(", ")
        additionalQuery = ` and [Vehicle_type] in (${vehicle_type_val})`
        sql_query +=additionalQuery
    }
    if(queryBody.category.length>0){
        // cat_opretor = 'in'
        cat_val = queryBody.category.map(item => `'${item}'`).join(", ")
        additionalQuery = ` and [Cat_Name] in (${cat_val})`
        sql_query +=additionalQuery
    }
    return sql_query
}

let getSBFGroupFilterData = async (req, res) =>{
    try {
        // let table_name = "[pando].[commandcenter_fcmxfp_metric]"
        let queryBody = req.body;
        let colName = `[Subbf_Name]`
        let sql_query = getQuery(queryBody, colName)
        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        // let data = await sequelize.query(sql_query)
        let dataList = []
        for(let i in data){
            dataList.push(data[i]['Subbf_Name'])
            console.log((data[i]['Subbf_Name']))
        }
        dataList = getFilterArray(dataList)
        dataList.sort()
        res.status(200).send(dataList)
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getDestinationCityFilterData = async (req, res) =>{
    try {
        // let table_name = "[pando].[commandcenter_fcmxfp_metric]"

        let queryBody = req.body;
        let colName = `[Destination_city]`
        let sql_query = getQuery(queryBody, colName)
        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        // let data = await sequelize.query(sql_query)
        let dataList = []
        for(let i in data){
            dataList.push(data[i]['Destination_city'])
            console.log((data[i]['Destination_city']))
        }
        dataList = getFilterArray(dataList)
        dataList.sort()
        res.status(200).send(dataList)
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getCategoryFilterData = async (req, res) =>{
    try {
        // let table_name = "[pando].[commandcenter_fcmxfp_metric]"

        let queryBody = req.body;
        let colName = `[Cat_Name]`
        let sql_query = getQuery(queryBody, colName)
        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        // let data = await sequelize.query(sql_query)
        let dataList = []
        for(let i in data){
            dataList.push(data[i]['Cat_Name'])
            console.log((data[i]['Cat_Name']))
        }
        dataList = getFilterArray(dataList)
        dataList.sort()
        res.status(200).send(dataList)
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getSourceCityFilterData = async (req, res) =>{
    try {
        // let table_name = "[pando].[commandcenter_fcmxfp_metric]"
        let queryBody = req.body;
        let colName = `[Source_city]`
        let sql_query = getQuery(queryBody, colName)
        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        // let data = await sequelize.query(sql_query)
        let dataList = []
        for(let i in data){
            dataList.push(data[i]['Source_city'])
            console.log((data[i]['Source_city']))
        }
        dataList = getFilterArray(dataList)
        dataList.sort()
        res.status(200).send(dataList)
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getVehicleTypeFilterData = async (req, res) =>{
    try {
        // let table_name = "[pando].[commandcenter_fcmxfp_metric]"
        let queryBody = req.body;
        let colName = `[Vehicle_type]`
        let sql_query = getQuery(queryBody, colName)
        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        // let data = await sequelize.query(sql_query)
        let dataList = []
        for(let i in data){
            dataList.push(data[i]['Vehicle_type'])
            console.log((data[i]['Vehicle_type']))
        }
        dataList = getFilterArray(dataList)
        dataList.sort()
        res.status(200).send(dataList)
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

let getMovementFilterData = async (req, res) =>{
    try {
        // let table_name = "[pando].[commandcenter_fcmxfp_metric]"

        let sql_query = `exec [dbo].get_distinct_movement `
        let connection = await getConnection()
        let data = await getQueryData(connection, sql_query)
        // let data = await sequelize.query(sql_query)
        let dataList = []
        for(let i in data){
            dataList.push(data[i]['movement'])
            console.log((data[i]['movement']))
        }
        dataList = getFilterArray(dataList)
        dataList.sort()
        res.status(200).send(dataList)
    }catch (e){
        console.log('error',e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}





module.exports = {
    getSBFGroupFilterData,
    getSourceCityFilterData,
    getVehicleTypeFilterData,
    getMovementFilterData,
    getDestinationCityFilterData,
    getCategoryFilterData
}
