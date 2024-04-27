const express = require("express");
const sequelize = require("./util/database");
const bodyParser = require("body-parser");
const multer = require("multer");
const cors = require("cors");
const path = require("path");

const app = express();
app.use(bodyParser.json());
app.use(cors());

const fileStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "images");
  },
  filename: (req, file, cb) => {
    cb(null, new Date().getMilliseconds().toString() + "-" + file.originalname);
  },
});

const fileFilter = (req, file, cb) => {
  if (
    file.mimetype === "image/png" ||
    file.mimetype === "image/jpg" ||
    file.mimetype === "image/jpeg"
  ) {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

app.use(
  multer({ storage: fileStorage, fileFilter: fileFilter }).single("image")
);
app.use("/images", express.static(path.join(__dirname, "images")));

// const User = require("./models/User");
// const Location = require("./models/Location");
// const Day = require("./models/Day");
// const ServiceDate = require("./models/Service_Date");
// const AppointmentReview = require("./models/Appointment_Review");
const Chat = require("./models/Chat");

const usersRouter = require("./routes/auth");
const clinksRouter = require("./routes/clinks");
const servicessRouter = require("./routes/services");
const chatRouter = require("./routes/chats");

app.use("/users", usersRouter);
app.use("/clinks", clinksRouter);
app.use("/services", servicessRouter);
app.use("/chats", chatRouter);

app.use((err, req, res, next) => {
  const { statusCode, message } = err;
  if (statusCode == 500) {
    err.statusCode = 500;
    return res.status(statusCode).json({
      error: true,
      message: "Server Error",
      err: message,
    });
  }
  return res.status(statusCode).json({
    error: true,
    message: message,
  });
});

sequelize
  // .sync({ force: true })
  .sync()
  .then((result) => {
    const server = app.listen(8080);
    const io = require("./socket").init(server, {
      cors: {
        origin: "*",
        methods: ["GET", "POST", "PUT", "DELETE"],
      },
    });
    io.on("connection", (socket) => {
      console.log("Client connected");
    });
  })
  .catch((err) => {
    console.log("ERROR", err);
  });
