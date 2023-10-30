// const {sequelize} = require('../databaseConnection/sql_connection');
const {getConnection, getQueryData} = require('../databaseConnection/dbConnection');
// const {sequelize} = require('../databaseConnection/sql_connection');

async function getDivisionFilterData() {
    try {
        // console.log("getDivisionFilterData invoked")
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct Division FROM [da].[locationHierarchy_updated]`)
        // let data = await sequelize.query(`select distinct Division FROM [da].[locationHierarchy_updated]`)
        // console.log("getDivisionFilterData invoked2")
        let division = []
        for(let div in data){
            if(data[div]['Division'] === 'DIV_0001'){ data[div]['Division'] = 'South-West'; division.push(data[div]['Division'])}
            if(data[div]['Division'] === 'DIV_0002'){ data[div]['Division'] = 'North-East'; division.push(data[div]['Division'])}
        }
        // console.log("getDivisionFilterData fetched data successfully")
        return (division)
    }catch (e){
        console.log('error',e)
        return []
    }
}

async function getSiteFilterData() {
    try {
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [SiteName] FROM [da].[locationHierarchy_updated]`)
        // let data = await sequelize.query(`select distinct [SiteName] FROM [da].[locationHierarchy_updated]`)
        let site = []
        for(let div in data){
            site.push(data[div]['SiteName'])
            console.log((data[div]['SiteName']))
        }
        return (site)
    }catch (e){
        console.log('error',e)
        return  []
    }
}

async function getBranchFilterData(){
    try {
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [BranchName] FROM [da].[locationHierarchy_updated]`)
        // let data = await sequelize.query(`select distinct [BranchName] FROM [da].[locationHierarchy_updated]`)
        let branch = []
        for(let div in data){
            // Here we are using replace because there is more <""> are there in data so to remove that
            branch.push(data[div]['BranchName'].replace(/^"|"$/g, ''))
            console.log((data[div]['BranchName']))
        }
        return branch
    }catch (e){
        console.log('error',e)
        return []
    }
}

async function getClusterFilterData(){
    try {
        let connection = await getConnection()
        let data = await getQueryData(connection, `select distinct [ClusterName] FROM [da].[locationHierarchy_updated]`)
        // let data = await sequelize.query(`select distinct [ClusterName] FROM [da].[locationHierarchy_updated]`)
        let cluster = []
        for(let div in data){
            if(data[div]['ClusterName'] === null){
                data[div]['ClusterName'] = "NULL"
            }
            cluster.push(data[div]['ClusterName'])
            console.log((data[div]['ClusterName']))
        }
        return cluster
    }catch (e){
        console.log('error',e)
        return []
    }
}

let getFilterData = async (req, res) =>{
    try {
        let data = req.query
        let filter_data = []
        if(data.filter === 'site'){filter_data = await getSiteFilterData()}
        if(data.filter === 'division'){filter_data = await getDivisionFilterData()}
        if(data.filter === 'cluster'){filter_data = await getClusterFilterData()}
        if(filter_data.length>0){res.status(200).json({success: true, data: filter_data});}
        if(filter_data.length === 0){res.status(200).json({success: false, data: filter_data});}
    } catch (error) {
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

module.exports = {
    getFilterData
}
