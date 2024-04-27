const express = require("express");
const {
  getServices,
  getService,
  makeAppointment,
  getAppointments,
} = require("../controllers/services");
const servicessRouter = express.Router();

servicessRouter.get("/:clink_id", getServices);
servicessRouter.get("/service/:id", getService);

servicessRouter.post("/appointment", makeAppointment);
servicessRouter.get("/appointment/:client_id", getAppointments);

module.exports = servicessRouter;
