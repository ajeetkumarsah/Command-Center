const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('tbl_users', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    last_login: {
      type: DataTypes.DATE,
      allowNull: true
    },
    is_superuser: {
      type: DataTypes.BOOLEAN,
      allowNull: false
    },
    first_name: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    last_name: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    email: {
      type: DataTypes.STRING(254),
      allowNull: false,
      unique: "UQ__tbl_user__AB6E61640B34DE60"
    }
  }, {
    sequelize,
    tableName: 'tbl_users',
    schema: 'dbo',
    timestamps: true,
    indexes: [
      {
        name: "PK__tbl_user__3213E83FA86E2ABC",
        unique: true,
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "UQ__tbl_user__AB6E61640B34DE60",
        unique: true,
        fields: [
          { name: "email" },
        ]
      },
    ]
  });
};
