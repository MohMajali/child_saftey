const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const Category = require("./Categories");
const User = require("./user");

const Recipes = sequelize.define(
  "recipes",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    title: {
      type: DataTypes.STRING,
      allowNull: false,
      required: true,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: false,
      required: true,
    },
    main_image: {
      type: DataTypes.TEXT,
      allowNull: false,
      required: true,
    },
    total_rate: {
      type: DataTypes.DOUBLE,
      allowNull: false,
      required: true,
      defaultValue: 5,
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

Category.hasMany(Recipes, {
  foreignKey: "category_id",
});
Recipes.belongsTo(Category, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "category_id",
});

User.hasMany(Recipes, {
  foreignKey: "user_id",
});
Recipes.belongsTo(User, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "user_id",
});

module.exports = Recipes;
