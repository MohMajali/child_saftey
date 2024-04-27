const express = require("express");
const { insertConversation, getConversations, getConversationChat, sendMessage } = require("../controllers/chat");
const chatRouter = express.Router();

chatRouter.post("/", insertConversation);

chatRouter.get("/", getConversations);

chatRouter.get("/:conversation_id", getConversationChat);

chatRouter.post("/:conversation_id", sendMessage);

module.exports = chatRouter;
