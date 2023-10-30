const config = {
    server: "cmndcntr-db-dev.database.windows.net",
    authentication: {
        type: "azure-active-directory-service-principal-secret",
        options: {
            clientId: "8e2cb969-c154-4b6d-a407-550f8720b400",
            clientSecret: "T~N8Q~CtLmxqvKjkleIYknpI2J9jUlTzTx-qzbyV",
            tenantId: "3596192b-fdf5-4e2c-a6fa-acb706c963d8"
        }
    },
    options: {
        database: "cmndctr",
        encrypt: true // For encrypted connections

    }
};

const sql = require("mssql");

const pool = new sql.ConnectionPool(config);
const connection = pool.connect();

// Test the connection
connection.then(() => {
    console.log("Connected to the database.");
}).catch((err) => {
    console.error("Error connecting to the database:", err);
});

module.exports.sql = sql;
