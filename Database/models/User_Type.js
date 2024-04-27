const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const UserTypes = sequelize.define(
  "user_types",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    type: {
      type: DataTypes.STRING,
      required: true,
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

/*

INSERT INTO `user_types` (`id`, `type`, `created_at`) 
VALUES (NULL, 'ADMIN', current_timestamp()), 
(NULL, 'CLIENT', current_timestamp()), 
(NULL, 'DOCTORS', current_timestamp(),
(NULL, 'RECEPTIONIST', current_timestamp());

*/

module.exports = UserTypes;
