const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const Service = require("./Service");
const User = require("./User");
const ServiceDate = require("./Service_Date");

const Appointment = sequelize.define(
  "appointments",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    status: {
      type: DataTypes.STRING,
      allowNull: false,
      required: true,
      defaultValue: "PENDING",
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

Service.hasMany(Appointment, {
  foreignKey: "service_id",
});
Appointment.belongsTo(Service, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "service_id",
});

//===================================================

User.hasMany(Appointment, {
  foreignKey: "client_id",
  as: "clientAppointment",
});
Appointment.belongsTo(User, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "client_id",
  as: "clientAppointment",
});

User.hasMany(Appointment, {
  foreignKey: "doctor_id",
  as: "doctorAppointment",
});
Appointment.belongsTo(User, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "doctor_id",
  as: "doctorAppointment",
});

//===================================================

ServiceDate.hasMany(Appointment, {
  foreignKey: "date_id",
});
Appointment.belongsTo(ServiceDate, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "date_id",
});

module.exports = Appointment;
