const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const User = require("./User");

const Conversation = sequelize.define(
  "chat_conversation",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
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

User.hasMany(Conversation, {
  foreignKey: "patient_id",
  as: "patientChat",
});
Conversation.belongsTo(User, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "patient_id",
  as: "patientChat",
});

User.hasMany(Conversation, {
  foreignKey: "midwife_id",
  as: "midwifeChat",
});
Conversation.belongsTo(User, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "midwife_id",
  as: "midwifeChat",
});

module.exports = Conversation;
