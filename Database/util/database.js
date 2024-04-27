const mysql = require("mysql2");

const Sequelize = require("sequelize");
const sequelize = new Sequelize("child_safety", "root", "", {
  dialect: "mysql",
  host: "localhost",
});

module.exports = sequelize;
