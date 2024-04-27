const io = require("../socket");
const Conversation = require("../models/Chat_Conversation");
const Chat = require("../models/Chat");
const User = require("../models/User");

exports.insertConversation = async (req, res, next) => {
  const { patient_id, midwife_id } = req.body;

  try {
    const result = await Conversation.findOrCreate({
      where: { patient_id, midwife_id },
      defaults: { patient_id, midwife_id },
    });

    if (!result[0]._options.isNewRecord) {
      return res.status(200).json({
        error: true,
        id: result[0].dataValues.id,
        message: "Conversation exist",
      });
    }

    return res.status(201).json({
      error: false,
      message: "New Conversation created succefully",
      conversation_id: result[0].dataValues.id,
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.getConversations = (req, res, next) => {
  Conversation.findAndCountAll({
    include: [
      { model: User, required: true, as: "patientChat" },
      { model: User, required: true, as: "midwifeChat" },
    ],
    order: [["id", "DESC"]],
  })
    .then((result) => {
      const conversations = result.rows.map((conversation) => ({
        id: conversation.id,
        customer: {
          id: conversation.patientChat.id,
          full_name: `${conversation.patientChat.name}`,
        },
        provider: {
          id: conversation.midwifeChat.id,
          full_name: `${conversation.midwifeChat.name}`,
        },
      }));

      return res.status(200).json({
        error: false,
        conversations: {
          count: result.count,
          rows: conversations,
        },
      });
    })
    .catch((err) => {
      if (!err.statusCode) {
        err.statusCode = 500;
      }
      next(err);
    });
};

exports.sendMessage = async (req, res, next) => {
  const { conversation_id } = req.params;
  const { reciver_id, sender_id, message } = req.body;

  try {
    const result = await Chat.create({
      conversation_id,
      reciver_id,
      message,
      sender_id,
    });

    if (result._options.isNewRecord) {
      io.getIo().emit("message", { action: "send" });
      return res.status(200).json({
        error: false,
        message: "Message Sent",
      });
    }
    return throwError(400, "Something went wrong");
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.getConversationChat = async (req, res, next) => {
  const { conversation_id } = req.params;

  try {
    const messages = await Chat.findAll({
      where: { conversation_id },
      include: [
        { model: User, required: true, as: "senderMsg" },
        { model: User, required: true, as: "resiverMsg" },
      ],
      order: [["id", "ASC"]],
    });

    const allMessages = messages.map((message) => ({
      id: message.id,
      message: message.message,
      sender: {
        id: message.senderMsg.id,
        nick_name: message.senderMsg.name,
      },
      reciver: {
        id: message.resiverMsg.id,
        nick_name: message.resiverMsg.name,
      },
    }));

    return res.status(200).json({
      error: false,
      messages: allMessages,
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};
