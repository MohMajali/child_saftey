const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const Location = sequelize.define(
  "locations",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      required: true,
    },
    active: {
      type: DataTypes.INTEGER,
      allowNull: false,
      required: true,
      defaultValue: 1,
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: Sequelize.literal("CURRENT_TIMESTAMP"),
    },
  },
  {
    timestamps: false,
  }
);

module.exports = Location;
