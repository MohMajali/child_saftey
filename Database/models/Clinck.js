const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const Location = require("./Location");

const Clink = sequelize.define(
  "clinks",
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
    phone: {
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

Location.hasMany(Clink, {
  foreignKey: "location_id",
});
Clink.belongsTo(Location, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "location_id",
});

module.exports = Clink;
