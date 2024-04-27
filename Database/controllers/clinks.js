const Clink = require("../models/Clinck");
const Location = require("../models/Location");

exports.getLocations = async (req, res, next) => {
  try {
    const locations = await Location.findAll({
      attributes: ["id", "name"],
      where: { active: 1 },
    });

    res.status(200).json({
      error: false,
      locations,
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.getClinks = async (req, res, next) => {
  const { location_id } = req.params;

  let clinks;
  try {
    if (location_id == 0) {
      clinks = await Clink.findAll({
        where: { active: 1 },
      });

      return res.status(200).json({
        error: false,
        clinks,
      });
    }

    clinks = await Clink.findAll({
      where: { location_id, active: 1 },
    });

    return res.status(200).json({
      error: false,
      clinks,
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};
