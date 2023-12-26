const { AuthenticationContext } = require('adal-node');
const { Connection, Request } = require('tedious');

// Azure SQL Database information
const serverName = 'cmndcntr-db-dev.database.windows.net';
// const serverName = 'rbasynapseworkspace.sql.azuresynapse.net';
const databaseName = 'cmndctr';
// const databaseName = 'datahub_sql';

// Service principal credentials
const clientId = '8e2cb969-c154-4b6d-a407-550f8720b400';
const clientSecret = 'T~N8Q~CtLmxqvKjkleIYknpI2J9jUlTzTx-qzbyV';
const tenantId = '3596192b-fdf5-4e2c-a6fa-acb706c963d8';

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
        },
    };

    return new Promise((resolve, reject) => {
        const connection = new Connection(config);

        connection.connect((err) => {
            if (err) {
                console.log("Error:",err)
                reject(err);
            } else {
                console.log("Connected to the Database:",config['options']['database'])
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

const authorityUrl = `https://login.microsoftonline.com/${tenantId}`;
const context = new AuthenticationContext(authorityUrl);

async function myConnection(){
    const accessToken = await acquireAccessToken().then(token => {
        return token
    });
    const conn = await connectToDatabase(accessToken).then(con =>{
        return con
    });
    return conn

}

module.exports ={
    getConnection,
    getQueryData,
    myConnection
}

// console.log("length of data:",getData.length)
