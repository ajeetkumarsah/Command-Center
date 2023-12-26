const msRestNodeAuth = require("ms-rest-nodeauth");
const sql = require("mssql");

// Define the Azure SQL Database connection configuration
const sqlConfig = {
    // server: "<your-server-name>.database.windows.net",
    // server: "tcp:rbasynapseworkspace.sql.azuresynapse.net",
    server: "rbasynapseworkspace.sql.azuresynapse.net",
    database: "datahub_sql",
    authentication: {
        type: "azure-active-directory-service-principal-secret",
        options: {
            clientId: "8e2cb969-c154-4b6d-a407-550f8720b400",
            clientSecret: "T~N8Q~CtLmxqvKjkleIYknpI2J9jUlTzTx-qzbyV",
            tenantId: "3596192b-fdf5-4e2c-a6fa-acb706c963d8",
        },
    },
};

// Function to connect to the SQL database
async function connectToSqlDatabase() {
    try {
        // Authenticate using the service principal
        const servicePrincipalCreds = await msRestNodeAuth.loginWithServicePrincipalSecret(
            sqlConfig.authentication.options.clientId,
            sqlConfig.authentication.options.clientSecret,
            sqlConfig.authentication.options.tenantId
        );

        // Create a connection pool
        const pool = await new sql.ConnectionPool(sqlConfig).connect();

        // Query the database (example)
        const result = await pool.request().query("SELECT TOP 1 * FROM idmcp.dummy_prod_master");

        // Process the query result
        console.log("Query Result:", result);

        // Close the connection pool when done
        await pool.close();
    } catch (err) {
        console.error("Error connecting to SQL database:", err);
    }
}

// Call the function to connect to the SQL database
connectToSqlDatabase();
