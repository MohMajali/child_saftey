const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const Appointment = require("./Appointment");

const AppointmentReview = sequelize.define(
  "appointments_reviews",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    review: {
      type: DataTypes.TEXT,
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

Appointment.hasMany(AppointmentReview, {
  foreignKey: "appointment_id",
});
AppointmentReview.belongsTo(Appointment, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "appointment_id",
});

module.exports = AppointmentReview;
