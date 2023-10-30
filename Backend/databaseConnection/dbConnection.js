const { AuthenticationContext } = require('adal-node');
const { Connection, Request } = require('tedious');

// Azure SQL Database information
const serverName = process.env.serverName;
const databaseName = process.env.database;

// Service principal credentials
const clientId = process.env.dbClientID;
const clientSecret = process.env.dbClientSecret;
const tenantId = process.env.tenantId;

async function acquireAccessToken() {
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

async function connectToDatabase(accessToken) {
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
            validateBulkLoadParameters: true,
            trustServerCertificate: true,
            useUTC: false,
            timezone: process.env.TZ,
            requestTimeout: 3000000,
            connectTimeout: 60000
        },
    };

    return new Promise((resolve, reject) => {
        const connection = new Connection(config);

        connection.connect((err) => {
            if (err) {
                console.log("Error:",err)
                reject(err);
            } else {
                // console.log("Connected to the Database:",config['options']['database'])
                resolve(connection);
            }
        });
    });
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
                // console.log(`Query executed successfully. Rows affected: ${rowCount}`);
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

async function getConnection(){
    try {
        const accessToken = await acquireAccessToken();
        return await connectToDatabase(accessToken)
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

module.exports ={
    getConnection,
    getQueryData
}
