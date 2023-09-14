
module.exports =async (Sequelize,sequelize,db) => {

    db.Users = require('../models/tbl_users')(sequelize, Sequelize);
    db.Users.sync();
}
