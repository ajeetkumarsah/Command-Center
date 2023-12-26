// const {sequelize} = require('../../../databaseConnection/sql_connection');
const {getConnection, getQueryData} = require('../../../databaseConnection/dbConnection');

function getFormatedNumber(number){
    if(number>100000){
        number=(number/100000).toFixed(2)+"L"
    }else if(number>1000){
        number=(number/1000).toFixed(2)+"K"
    }else {
        number = number.toFixed(2)
    }
    return number
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

function getFormatedDate(dateArr){
    let newDateArr = []
    for(let i in dateArr){
        let date = dateArr[i].split("-")[0]+"-"+getMonthDigit(dateArr[i].split("-")[1])
        newDateArr.push(date)
    }
    return newDateArr
}

function getPhysicalYear(year){
    const currentYear = new Date().getFullYear();
    const currentDate = new Date();
    const currentMonth = currentDate.getMonth() + 1;
    let physicalYearList = []
    console.log(typeof(currentYear))
    if(currentYear.toString() === year){
        console.log(currentYear, year)
        for(let i = 7; i!==currentMonth+1; i++){
            if(i === 12){
                let yearMonth = year+"-"+i
                physicalYearList.push(yearMonth)
                year -= 1
                i = 1
            }else{
                if(i>9){
                    let yearMonth = year+"-"+i
                    physicalYearList.push(yearMonth)

                }else{
                    let yearMonth = year+"-0"+i
                    physicalYearList.push(yearMonth)

                }
            }
        }

    }else{
        let month = 7
        do {
            if(month === 12){
                let yearMonth = year+"-"+month
                physicalYearList.push(yearMonth)
                year -= 1
                month = 1
            }else{
                if(month>9){
                    let yearMonth = year+"-"+month
                    physicalYearList.push(yearMonth)
                    month++
                }else{
                    let yearMonth = year+"-0"+month
                    physicalYearList.push(yearMonth)
                    month++
                }

            }
        }while(month-1 !== 6);
    }
    return physicalYearList
}

function getQuery(data){
    let dataQuery = ''
    let Subbf_Name = 'NULL'
    let DestinationCity = 'NULL'
    let Cat_Name = 'NULL'
    let SourceCity = 'NULL'
    let VehicleType = 'NULL'
    let Movement = 'NULL'
    let dateValues = 'NULL'
    const currentYear = new Date().getFullYear();
    let physicalYear = data['physicalYear'] ? data['physicalYear'] : currentYear.toString()
    if(data['date'].length>0){
        dateValues = "'"+ getFormatedDate(data['date']).join(',') +"'"
    }else{
        let physicalYearList = getPhysicalYear(physicalYear)
        dateValues = "'"+ (physicalYearList).join(',') +"'"
    }
    // if(data['date'].length>0){ dateValues = data['date'].map(item => `('${item}')`).join(',') }

    if(data['category'].length>0){ Cat_Name = "'"+ data['category'].join(',') +"'" }
    if(data['subBrandForm'].length>0){ Subbf_Name = "'"+ data['subBrandForm'].join(',') +"'" }
    if(data['destinationCity'].length>0){ DestinationCity = "'"+ data['destinationCity'].join(',') +"'" }
    if(data['sourceCity'].length>0){ SourceCity = "'"+ data['sourceCity'].join(',') +"'" }
    if(data['vehicleType'].length>0){ VehicleType = "'"+ data['vehicleType'].join(',') +"'" }
    if(data['movement']){ Movement = "'"+ data['movement'] +"'" }
    // console.log("category:", data['category'] === '')

    dataQuery = `EXEC [dbo].[GetMetricData_MONTH]
                    @Subbf_Name = ${Subbf_Name},
                     @DestinationCity = ${DestinationCity},
                     @Cat_Name = ${Cat_Name},
                     @SourceCity = ${SourceCity},
                     @VehicleType = ${VehicleType},
                     @Movement = ${Movement},
                     @month_date = ${dateValues};`

    // if(data['date'].length>0){
    //
    //     dataQuery = `DECLARE @DateList DateList;
    //             INSERT INTO @DateList (DateValue)
    //             VALUES ${dateValues};
    //                 EXEC [dbo].[GetMetricData_MONTH]
    //                 @Subbf_Name = ${Subbf_Name},
    //                  @DestinationCity = ${DestinationCity},
    //                  @Cat_Name = ${Cat_Name},
    //                  @SourceCity = ${SourceCity},
    //                  @VehicleType = ${VehicleType},
    //                  @Movement = ${Movement},
    //                  @month_date = ${dateValues};`
    // }else{
    //     dataQuery = `EXEC [dbo].[GetMetricData_MONTH]
    //                 @Subbf_Name = ${Subbf_Name},
    //                  @DestinationCity = ${DestinationCity},
    //                  @Cat_Name = ${Cat_Name},
    //                  @SourceCity = ${SourceCity},
    //                  @VehicleType = ${VehicleType},
    //                  @Movement = ${Movement},
    //                  @month_date = ${dateValues};`
    // }
    console.log("dataQuery", dataQuery)
    return dataQuery
}

let getTransportationPageData = async (req, res) => {
    try{
        let reqData = req.body;

        let dataQuery = getQuery(reqData)
        // console.log("Body", reqData)
        let connection = await getConnection()
        let data = await getQueryData(connection, dataQuery);
        // let data = await sequelize.query(dataQuery);
        let iterableData = data[0]
        let finalData = {}
        let menuData = {
            "data": []
        }
        let cardData = {
            "data": []
        }

        let menuItemNo2 = {}

        let obj = {}
        obj['title'] = 'Net saving %'
        obj['num'] = 0
        obj['percentage'] = '0%'
        obj['check'] = false
        menuData['data'].push(obj)

        for(let i in iterableData){
            let obj = {}
            if(i === 'Avg Vol/SU'){
                obj['title'] = 'Avg Volume/SU'
                obj['message'] = 'Certain number of cases make 1 SU. This metric shows Avg vol of 1 SU'
                obj['num'] = ((getFormatedNumber(iterableData[i]!==null? iterableData[i] : 0)))
                obj['actualNum'] = (((iterableData[i]!==null? iterableData[i] : 0)))
                obj['percentage'] = '2%'
                obj['check'] = true
                cardData['data'].push(obj)

            }else if(i === 'Avg Wt/SU'){
                obj['title'] = 'Avg Wt/SU'
                obj['message'] = 'Certain number of cases make 1 SU. This metric shows Avg Wt of 1 SU'
                obj['num'] = ((getFormatedNumber(iterableData[i]!==null? iterableData[i] : 0)))
                obj['actualNum'] = (((iterableData[i]!==null? iterableData[i] : 0)))
                obj['percentage'] = '2%'
                obj['check'] = true
                cardData['data'].push(obj)

            }else if(i === 'KM/MSU'){
                obj['title'] = 'KM/MSU'
                obj['message'] = 'How much an MSU travels at category/sbf/source-destination level to reach to custome'
                obj['num'] = ((getFormatedNumber(iterableData[i]!==null? iterableData[i] : 0)))
                obj['actualNum'] = (((iterableData[i]!==null? iterableData[i] : 0)))
                obj['percentage'] = '2%'
                obj['check'] = true
                cardData['data'].push(obj)

            }else if(i === 'Avg MSU/Truck'){
                obj['title'] = 'Avg MSU/Truck'
                obj['message'] = 'Different MSU definition for different p-codes, and multiple p-codes are shipped in 1 truck'
                obj['num'] = ((getFormatedNumber(iterableData[i]!==null? iterableData[i] : 0)))
                obj['actualNum'] = (((iterableData[i]!==null? iterableData[i] : 0)))
                obj['percentage'] = '2%'
                obj['check'] = true
                cardData['data'].push(obj)

            }else if(i === 'Indent pallets'){
                obj['title'] = 'Pallets'
                obj['message'] = 'Pallets are storage units. Costs are allocated based on pallets. Number of pallets loaded in a truck, costs are bifurcated basis that particular category'
                obj['num'] = ((getFormatedNumber(iterableData[i]!==null? iterableData[i] : 0)))
                obj['actualNum'] = (((iterableData[i]!==null? iterableData[i] : 0)))
                obj['percentage'] = '2%'
                obj['check'] = true
                cardData['data'].push(obj)

            }else if(i === 'Vol in MSU'){
                obj['title'] = 'MSU shipment'
                obj['message'] = 'Number of MSUs shipped on the defined lanes. includes both PG-PG and PG-Customers'
                obj['num'] = ((getFormatedNumber(iterableData[i]!==null? iterableData[i] : 0)))
                obj['actualNum'] = (((iterableData[i]!==null? iterableData[i] : 0)))
                obj['percentage'] = '2%'
                obj['check'] = true
                menuData['data'].push(obj)

            }else if(i === 'Total Cost Incurred ($M)'){
                obj['title'] = 'Total Cost Incurred ($M)'
                obj['message'] = 'Summation of all the costs incurred during transportation including base freight, detention, loading, unloading charges etc'
                obj['num'] = ((getFormatedNumber(iterableData[i]!==null? iterableData[i] : 0)))
                obj['actualNum'] = (((iterableData[i]!==null? iterableData[i] : 0)))
                obj['percentage'] = '2%'
                obj['check'] = true
                menuData['data'].push(obj)

            }else if(i === 'No of trucks dispatched'){
                obj['title'] = 'Trucks Dispatched'
                obj['message'] = 'Total number of trucks dispatched during a particular period. For 1 shipment number there is 1 truck'
                obj['num'] = (((iterableData[i]!==null? iterableData[i] : 0)))
                obj['percentage'] = '2%'
                obj['check'] = true
                menuData['data'].push(obj)

            }else if(i === 'Avg $/SU'){
                obj['title'] = 'Avg $/SU'
                obj['message'] = 'How much money spent to ship 1 statistical unit on the defined lanes.'
                obj['num'] = ((getFormatedNumber(iterableData[i]!==null? iterableData[i] : 0)))
                obj['actualNum'] = (((iterableData[i]!==null? iterableData[i] : 0)))
                obj['percentage'] = '2%'
                obj['check'] = true
                menuItemNo2 = obj
                // menuData['data'].push(obj)

            }

        }
        obj = {}
        obj['title'] = 'Avg VFR'
        obj['message'] = 'On avg, how much truck volume we have been able to utilize'
        obj['num'] = 0
        obj['percentage'] = '0%'
        obj['check'] = false

        cardData['data'].push(obj)
        obj = {}
        obj['title'] = 'Spots'
        obj['message'] = 'No of trucks from transporters that were not initially allocated to those transporters in annual contract13'
        obj['num'] = 0
        obj['percentage'] = '0%'
        obj['check'] = false

        cardData['data'].push(obj)
        obj = {}
        obj['title'] = 'Detentions'
        obj['message'] = 'Amount paid whenever a vehicle stays in our premise beyond the agreed contracted time.'
        obj['num'] = 0
        obj['percentage'] = '0%'
        obj['check'] = false

        cardData['data'].push(obj)
        obj = {}
        obj['title'] = 'Non Network'
        obj['message'] = 'Whenever there is a shipment beyond a pre-defined network.'
        obj['num'] = 0
        obj['percentage'] = '0%'
        obj['check'] = false

        cardData['data'].push(obj)
        obj = {}
        obj['title'] = 'INR/tonne'
        obj['num'] = 0
        obj['percentage'] = '0%'
        obj['check'] = false

        cardData['data'].push(obj)
        obj = {}
        obj['title'] = 'INR/cubic m'
        obj['num'] = 0
        obj['percentage'] = '0%'
        obj['check'] = false

        cardData['data'].push(obj)
        obj = {}
        obj['title'] = 'Avg km Travelled'
        obj['num'] = 0
        obj['percentage'] = '0%'
        obj['check'] = false

        cardData['data'].push(obj)

        obj = {}
        obj['title'] = 'Avg. Truck Rate (INR)'
        obj['message'] = 'Weighted average rate, per lane per truck type combination.'
        obj['num'] =  {
            "actual" : 0,
            "expected":  0
        }
        obj['percentage'] = '0%'
        obj['check'] = false
        menuData['data'].push(obj)


        menuData['data'].splice(1, 0, menuItemNo2);


        finalData['menuData']=(menuData['data'])
        finalData['cardData']=(cardData['data'])
        res.status(200).send([finalData])
    }catch (e) {
        console.log('error', e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

module.exports = {
    getTransportationPageData
}

