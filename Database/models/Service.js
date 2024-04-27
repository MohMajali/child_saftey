const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const Clink = require("./Clinck");
const User = require("./User");

const Service = sequelize.define(
  "services",
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
    description: {
      type: DataTypes.TEXT,
      allowNull: false,
      required: true,
    },
    image: {
      type: DataTypes.STRING,
      allowNull: false,
      required: true,
    },
    active: {
      type: DataTypes.SMALLINT,
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

Clink.hasMany(Service, {
  foreignKey: "clink_id",
});
Service.belongsTo(Clink, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "clink_id",
});

User.hasMany(Service, {
  foreignKey: "doctor_id",
});
Service.belongsTo(User, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "doctor_id",
});

module.exports = Service;
