const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const UserType = require("./User_Type");

const User = sequelize.define(
  "users",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    national_id: {
      type: DataTypes.STRING,
      allowNull: false,
      required: true,
    },
    family_book_id: {
      type: DataTypes.STRING,
      allowNull: false,
      required: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      required: true,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: true,
      required: false,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
      required: true,
    },
    phone: {
      type: DataTypes.STRING,
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

UserType.hasMany(User, {
  foreignKey: "type_id",
});
User.belongsTo(UserType, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "type_id",
});

module.exports = User;
