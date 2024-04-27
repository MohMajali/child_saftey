const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const Service = require("./Service");

const ServiceDate = sequelize.define(
  "services_dates",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    from_time: {
      type: DataTypes.TIME,
      allowNull: false,
      required: true,
    },
    to_time: {
      type: DataTypes.TIME,
      allowNull: false,
      required: true,
    },
    date: {
      type: DataTypes.DATE,
      allowNull: false,
      required: true,
    },
    active: {
      type: DataTypes.INTEGER,
      allowNull: false,
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

Service.hasMany(ServiceDate, {
  foreignKey: "service_id",
});
ServiceDate.belongsTo(Service, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "service_id",
});

module.exports = ServiceDate;
