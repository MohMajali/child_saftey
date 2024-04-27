const express = require("express");
const { getClinks, getLocations } = require("../controllers/clinks");
const clinksRouter = express.Router();

clinksRouter.get("/locations", getLocations);
clinksRouter.get("/:location_id", getClinks);

module.exports = clinksRouter;
