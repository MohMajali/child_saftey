const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const Conversation = require("./Chat_Conversation");
const User = require("./User");

const ChatMessage = sequelize.define(
  "chat_messages",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    message: {
      type: DataTypes.TEXT,
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

Conversation.hasMany(ChatMessage, {
  foreignKey: "conversation_id",
});
ChatMessage.belongsTo(Conversation, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "conversation_id",
});

User.hasMany(ChatMessage, {
  foreignKey: "sender_id",
  as: "senderMsg",
});
ChatMessage.belongsTo(User, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "sender_id",
  as: "senderMsg",
});

User.hasMany(ChatMessage, {
  foreignKey: "reciver_id",
  as: "resiverMsg",
});
ChatMessage.belongsTo(User, {
  constraints: true,
  onDelete: "CASCADE",
  foreignKey: "reciver_id",
  as: "resiverMsg",
});

module.exports = ChatMessage;
