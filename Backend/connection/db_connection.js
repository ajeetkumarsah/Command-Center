const env = process.env.NODE_ENV || 'development2';
const config = require('../config/config.json')["development2"];
const Sequelize = require("sequelize");

const sequelize = new Sequelize(config.database, config.username, config.password, {
    host: config.host,
    dialect: config.dialect,
    dialectOptions: {
        options: {
            requestTimeout: 3000000,
            validateBulkLoadParameters: true,
            trustServerCertificate: true,
            useUTC: false,
        }
    },
    pool: {
        max: 50,
        min: 5,
        idle: 10
    },
    logging: false,
});

sequelize.authenticate().then(function (err) {
    if (err) console.log(`Unable to connect to the ${config.dialect} database:`, err);
    console.log(`${config.database} DB connection has been established successfully.`);
});

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

require('../models-init/models-init')(Sequelize,sequelize,db);

module.exports = db;
// module.exports.sequelize = sequelize;
