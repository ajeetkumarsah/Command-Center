const { AuthenticationContext } = require('adal-node');
const { Connection, Request } = require('tedious');

// Azure SQL Database information
const serverName = 'cmndcntr-db-dev.database.windows.net';
// const serverName = 'rbasynapseworkspace.sql.azuresynapse.net';
const databaseName = 'cmndctr';
// const databaseName = 'datahub_sql';

let token = ''

// Service principal credentials
const clientId = '8e2cb969-c154-4b6d-a407-550f8720b400';
const clientSecret = 'T~N8Q~CtLmxqvKjkleIYknpI2J9jUlTzTx-qzbyV';
const tenantId = '3596192b-fdf5-4e2c-a6fa-acb706c963d8';

function acquireAccessToken() {
    const authorityUrl = `https://login.microsoftonline.com/${tenantId}`;
    const context = new AuthenticationContext(authorityUrl);

    return new Promise((resolve, reject) => {
        context.acquireTokenWithClientCredentials(
            'https://database.windows.net/',
            clientId,
            clientSecret,
            (err, tokenResponse) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(tokenResponse.accessToken);
                }
            }
        );
    });
}

function connectToDatabase(accessToken) {
    const config = {
        server: serverName,
        authentication: {
            type: 'azure-active-directory-access-token',
            options: {
                token: accessToken,
            },
        },
        options: {
            database: databaseName,
            encrypt: true, // Use encryption if needed
        },
    };

    // return new Promise((resolve, reject) => {
        const connection = new Connection(config);

        connection.connect(
        //     (err) => {
        //     if (err) {
        //         console.log("Error:",err)
        //         reject(err);
        //     } else {
        //         console.log("Connected to the Database:",config['options']['database'])
        //         resolve(connection);
        //     }
        // }
        );
        return connection
    // });
}

async function executeQuery(connection, sqlQuery) {

    return new Promise((resolve, reject) => {
        let myData = [];

        // Define your SQL query
        // const sqlQuery = 'SELECT TOP 10 * FROM [da].[locationHierarchy_updated]';

        const request = new Request(sqlQuery, (err, rowCount) => {
            if (err) {
                console.log(err);
                reject(err);
            } else {
                console.log(`Query executed successfully. Rows affected: ${rowCount}`);
                resolve(myData); // Resolve the promise with the collected data
            }

            // Close the database connection
            // connection.close();
        });

        // Handle rows returned by the query
        request.on('row', (columns) => {
            const row = {};
            columns.forEach((column) => {
                row[column.metadata.colName] = column.value;
            });
            myData.push(row);
        });

        // Execute the request
        connection.execSql(request);
    });
}


// (async () => {
//     try {
//         const accessToken = await acquireAccessToken();
//         const connection = await connectToDatabase(accessToken);
//         let sqlData = []
//         let sqlData2 = []
//         const sqlQuery = 'SELECT TOP 10 * FROM [da].[locationHierarchy_updated]';
//         const sqlQuery2 = 'SELECT TOP 5 * FROM [da].[locationHierarchy_updated]';
//         const rowCount = await executeQuery(connection, sqlQuery).then((data) => {
//             // console.log('Retrieved Data:', data);
//             sqlData = data
//         })
//             .catch((error) => {
//                 console.error('Error:', error);
//             });
//         const rowCount2 = await executeQuery(connection, sqlQuery2).then((data) => {
//             // console.log('Retrieved Data:', data);
//             sqlData2 = data
//         })
//             .catch((error) => {
//                 console.error('Error:', error);
//             });
//         console.log("data>>>>>>>>>>....",sqlData.length)
//         console.log("data>>>>>>>>>>....",sqlData2.length)
//     } catch (err) {
//         console.error('Error:', err.message);
//     }
// })();

function getConnection(){
    try {
        // const accessToken = await acquireAccessToken().then(token => {
        //     return token
        // });
        // console.log("Token", accessToken)
        let conn = connectToDatabase(token)
        // console.log(conn)
        return conn
    } catch (err) {
        console.error('Error:', err.message);
    }
}


async function getQueryData(connection, sqlQuery){
    try {
        let sqlData = []
        const rowCount = await executeQuery(connection, sqlQuery).then((data) => {
            // console.log('Retrieved Data:', data);
            sqlData = data
        })
        return sqlData
    } catch (err) {
        console.error('Error:', err.message);
    }
}

async function getToken(){
    token = await acquireAccessToken()
}

getToken()
setTimeout(() => {
    console.log("This is executed after 3 seconds");
}, 3000);
// console.log(getConnection())
// const conn = getConnection()
// const conn.getConnection().then((err) =>{
//     if(err){
//         console.log(err)
//     }else {
//         console.log("connected")
//     }
// });



// module.exports = {conn};

// module.exports ={
//     getConnection,
//     getQueryData
// }

// console.log("length of data:",getData.length)
