const { AuthenticationContext } = require('adal-node');
const Connection = require('tedious').Connection;
const Request = require('tedious').Request;

// Azure SQL Database information
const serverName = 'rbasynapseworkspace.sql.azuresynapse.net';
const databaseName = 'datahub_sql';

// Service principal credentials
const clientId = '8e2cb969-c154-4b6d-a407-550f8720b400';
const clientSecret = 'T~N8Q~CtLmxqvKjkleIYknpI2J9jUlTzTx-qzbyV';
const tenantId = '3596192b-fdf5-4e2c-a6fa-acb706c963d8';

(async () => {
    try {
        // Get an access token for Service Principal authentication
        const authorityUrl = `https://login.microsoftonline.com/${tenantId}`;
        const context = new AuthenticationContext(authorityUrl);
        context.acquireTokenWithClientCredentials(
            'https://database.windows.net/',
            clientId,
            clientSecret,
            (err, tokenResponse) => {
                if (err) {
                    console.error('Error acquiring token:', err.message);
                    return;
                }

                const accessToken = tokenResponse.accessToken;

                // Configure the connection to Azure SQL Database
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

                // Create a connection to the database
                const connection = new Connection(config);
                connection.connect();
                // Connect to the database
                connection.on('connect', (err) => {
                    if (err) {
                        console.error('Error connecting to Azure SQL Database:', err.message);
                    } else {
                        console.log('Connected to Azure SQL Database');

                        // Define your SQL query
                        const sqlQuery = 'select distinct Division FROM [da].[locationHierarchy_updated]';

                        // Create a request to execute the SQL query
                        const request = new Request(sqlQuery, (err, rowCount) => {
                            if (err) {
                                console.error('Error executing SQL query:', err.message);
                            } else {
                                console.log(`Query executed successfully. Rows affected: ${rowCount}`);
                            }

                            // Close the database connection
                            connection.close();
                        });

                        // Handle rows returned by the query
                        let result = [];
                        request.on('row', (columns) => {
                            console.log("COLUMNS",columns)
                            const row = {};
                            columns.forEach((column) => {
                                row[column.metadata.colName] = column.value;
                            });
                            result.push(row);
                        });
                        console.log("result", result)
                        // Execute the request
                        connection.execSql(request);
                    }
                });

                // Handle any errors during the connection process
                connection.on('error', (err) => {
                    console.error('Error during connection:', err.message);
                });
            }
        );
    } catch (err) {
        console.error('Error:', err.message);
    }
})();
