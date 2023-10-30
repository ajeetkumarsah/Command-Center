// const {sequelize} = require('../../../databaseConnection/sql_connection');
// const {sequelize2} = require('../databaseConnection/sql_connection2');
const rtDailyData = require('../../../webData/webDeepDivePage/retailing/retailingDayLevelData')
const rtMonthlyData = require('./retailingStructureData/retailingMonthlyData')
const rtDivisionData = require('./retailingStructureData/retailingDivisionData')
const rtSiteData = require('./retailingStructureData/retailingSiteData')
const rtBranchData = require('./retailingStructureData/retailinBranchData')
const rtChannelData = require('./retailingStructureData/retailingChannelData')
const rtSubChannelData = require('./retailingStructureData/retailingSUbChannelData')
const rtCategoryData = require('./retailingStructureData/retailingCategoryData')

function getStructuredData(data){
    // console.log("Structured Data....")
    let rawData = data['data']
    let finalData = []
    for(let j in rawData){
        let newKey = ''
        let finalArray = []
        let unstructuredData = rawData[j][0]
        let structuredData = {"table": []}
        for(let i in unstructuredData){
            if(i === 'cm' || i === 'p1m' || i === 'p3m' || i === 'p6m' || i === 'p12m' || i === 'financial_year'){
                let obj = {"key": i}
                obj['data'] = unstructuredData[i]
                structuredData["table"].push(obj)
            }else if((i === 'site' || i === 'branch') && unstructuredData[i] !== undefined){
                newKey = unstructuredData[i]
                structuredData[i] = unstructuredData[i]
            }else{
               structuredData[i] = unstructuredData[i]
            }
            // console.log("key:",i, "value:", unstructuredData[i])
        }
        if(newKey !== ''){
            structuredData['filter_key'] = newKey
        }
        finalArray.push(structuredData)
        finalData.push(finalArray)
        // console.log(rawData[i][0]['cm'])
    }
        // console.log(data)
    return finalData
}

let getData = async (req, res) =>{
    try {
        let reqData = req.body;
        // let finalData = []

        let reqName = reqData['name']
        let reqType = reqData['type']
        if(reqName === 'daily'){
            // delete req.body[0].apiType
            let data = await rtDailyData.getDeepDivePageData(req, res)
        }
        else if(reqName === 'channel'){
            // delete req.body[0].apiType
            if(reqType === 'monthlyData'){
                let data = await rtMonthlyData.getDeepDivePageData(req.body['query'], res)
                if(data["successful"]){
                    data = getStructuredData(data)
                    res.status(200).json(data)
                }else {
                    res.status(200).json(data)
                }
            }else if(reqType === 'division'){
                let data = await rtDivisionData.getDeepDivePageData(req.body['query'], res)
               if(data["successful"]){
                    data = getStructuredData(data)
                    res.status(200).json(data)
                }else {
                    res.status(200).json(data)
                }
            }else if(reqType === 'site'){
                let data = await rtSiteData.getDeepDivePageData(req.body['query'], res)
               if(data["successful"]){
                    data = getStructuredData(data)
                    res.status(200).json(data)
                }else {
                    res.status(200).json(data)
                }
            }else if(reqType === 'branch'){
                let data = await rtBranchData.getDeepDivePageData(req.body['query'], res)
               if(data["successful"]){
                    data = getStructuredData(data)
                    res.status(200).json(data)
                }else {
                    res.status(200).json(data)
                }
            }else if(reqType === 'channel'){
                let data = await rtChannelData.getDeepDivePageData(req.body['query'], res)
               if(data["successful"]){
                    data = getStructuredData(data)
                    res.status(200).json(data)
                }else {
                    res.status(200).json(data)
                }
            }else if(reqType === 'subChannel'){
                let data = await rtSubChannelData.getDeepDivePageData(req.body['query'], res)
               if(data["successful"]){
                    data = getStructuredData(data)
                    res.status(200).json(data)
                }else {
                    res.status(200).json(data)
                }
            }
        }else if(reqName === 'category'){
            if(reqType === 'category' || reqType === 'brand' || reqType === 'brandForm' || reqType === 'subBrandForm'){
                for(let i in req.body['query']){
                    req.body['query'][i]['filter'] = reqType
                }
                // req.body['query']
                let data = await rtCategoryData.getDeepDivePageData(req.body['query'], res)
                if(data["successful"]){
                    data = getStructuredData(data)
                    res.status(200).json(data)
                }else {
                    res.status(200).json(data)
                }
            }else {
                res.status(502).json("No Data For This Query")
            }
        }else {
            res.status(502).json("No Data For This Query")
        }
        // TODO Need to create api for category mobile data...;;;;
        // res.status(200).json(finalData)

    } catch (error) {
        // Handle any errors that occurred during the Promise execution
        console.error("Error retrieving retailing data:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

module.exports = {
    getData
}
