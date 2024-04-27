const express = require("express");
const {
  login,
  signup,
  updateAccount,
  getUser,
} = require("../controllers/auth");
const usersRouter = express.Router();

usersRouter.get("/:id", getUser);
usersRouter.post("/login", login);
usersRouter.post("/signup", signup);
usersRouter.put("/update/:id", updateAccount);

module.exports = usersRouter;
