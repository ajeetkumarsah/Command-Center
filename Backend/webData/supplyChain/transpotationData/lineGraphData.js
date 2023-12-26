// const {sequelize} = require('../../../databaseConnection/sql_connection');
const {getConnection, getQueryData} = require('../../../databaseConnection/dbConnection')
// const connection = getConnection()
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

    if(data['category'].length>0){ Cat_Name = "'"+ data['category'].join(',') +"'" }
    if(data['subBrandForm'].length>0){ Subbf_Name = "'"+ data['subBrandForm'].join(',') +"'" }
    if(data['destinationCity'].length>0){ DestinationCity = "'"+ data['destinationCity'].join(',') +"'" }
    if(data['sourceCity'].length>0){ SourceCity = "'"+ data['sourceCity'].join(',') +"'" }
    if(data['vehicleType'].length>0){ VehicleType = "'"+ data['vehicleType'].join(',') +"'" }
    if(data['movement'].length>0){ Movement = "'"+ data['movement'].join(',') +"'" }

    dataQuery = `EXEC [dbo].[GetMetricData_last_12month]
                    @Subbf_Name = ${Subbf_Name},
                     @DestinationCity = ${DestinationCity},
                     @Cat_Name = ${Cat_Name},
                     @SourceCity = ${SourceCity},
                     @VehicleType = ${VehicleType},
                     @Movement = ${Movement},
                     @month_date = ${dateValues};`

    console.log(dataQuery)

    return dataQuery
}

function getGraphMapping(name){
    if(name === "MSU shipment"){name = "Vol in MSU"}
    if(name === "Avg Volume/SU"){name = "Avg Vol/SU"}
    if(name === "Avg Wt/SU"){name = "Avg Wt/SU"}
    if(name === "KM/MSU"){name = "KM/MSU"}
    if(name === "Avg MSU/Truck"){name = "Avg MSU/Truck"}
    if(name === "Pallets"){name = "Indent pallets"}
    if(name === "Total Cost Incurred ($M)"){name = "Total Cost Incurred ($M)"}
    if(name === "Trucks Dispatched"){name = "No of trucks dispatched"}
    if(name === "Avg $/SU"){name = "Avg $/SU"}
    // if(name === "MSU shipment"){name = "Vol in MSU"}
    // if(name === "MSU shipment"){name = "Vol in MSU"}
    // if(name === "MSU shipment"){name = "Vol in MSU"}
    return name
}

let getLineGraphData = async (req, res) => {
    try{
        let reqData = req.body;
        let graphDataType = req.body.name;
        let dataQuery = getQuery(reqData)
        const connection = await getConnection()
        let data2 = await getQueryData(connection, dataQuery)
        // const rowCount = await executeQuery(connection, dataQuery).then((data) => {
        //     console.log('Retrieved Data:', data);
        //     // sqlData = data
        // })
        // console.log("Pririncipal Data:",data2)
        // let data = await sequelize.query(dataQuery);
        let iterableData = data2
        let finalData = []
        let filterName = ''
        if(graphDataType !== ''){filterName = getGraphMapping(graphDataType)}
        else{res.status(502).send({success: false, data: "Please provide name in parameter"}); return 0}
        for(let i in iterableData){
            let month = iterableData[i]['MONTH_DATE'] ? iterableData[i]['MONTH_DATE'] : ''
            if(month !== ''){
                let year = (month.split("-")[0])
                let _month = getDigitMonth(month.split("-")[1])
                month = _month+"-"+year
            }
            let obj = {
                'month': month,
                'change': '50%',
                'check': true,
                'data': iterableData[i][filterName] ? parseFloat((iterableData[i][filterName]).toFixed(2)) : 0
            }
            finalData.push(obj)
        }

        // Define a custom sorting function
        const customSort = (a, b) => {
            // Parse the month values into Date objects
            const dateA = new Date(a.month);
            const dateB = new Date(b.month);

            // Compare the Date objects in descending order
            return dateA - dateB;
        };

        finalData.sort(customSort);

        res.status(200).send(finalData)
    }catch (e) {
        console.log('error', e)
        res.status(500).send({successful: false, error: 'An internal server error occurred.'})
    }
}

module.exports = {
    getLineGraphData
}
