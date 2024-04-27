const Service = require("../models/Service");
const ServiceDates = require("../models/Service_Date");
const Appointment = require("../models/Appointment");
const User = require("../models/User");
const AppointmentReview = require("../models/Appointment_Review");

exports.getServices = async (req, res, next) => {
  const { clink_id } = req.params;

  try {
    const services = await Service.findAll({
      attributes: ["id", "name", "description", "image"],
      where: { clink_id, active: 1 },
      include: [
        { model: User, required: true, attributes: ["id", "name", "email"] },
      ],
    });

    return res.status(200).json({
      error: false,
      services,
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.getService = async (req, res, next) => {
  const { id } = req.params;

  try {
    let service = await Service.findOne({
      attributes: ["id", "name", "description", "image", "doctor_id"],
      where: { id },
    });

    const servicesDates = await ServiceDates.findAll({
      attributes: ["id", "from_time", "to_time", "date"],
      where: {
        service_id: id,
        active: 1,
      },
    });

    service = {
      ...service.dataValues,
      dates: servicesDates,
    };

    return res.status(200).json({
      error: false,
      service,
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.makeAppointment = async (req, res, next) => {
  const { service_id, client_id, doctor_id, date_id } = req.body;

  try {
    const newAppointment = await Appointment.create({
      service_id,
      client_id,
      doctor_id,
      date_id,
    });

    const updateDateId = await ServiceDates.update(
      {
        active: 0,
      },
      {
        where: { id: date_id },
      }
    );

    return res.status(201).json({
      error: false,
      message: "Appointment Added",
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.getAppointments = async (req, res, next) => {
  const { client_id } = req.params;

  try {
    const clientAppointments = await Appointment.findAll({
      include: [
        {
          model: Service,
          required: true,
          attributes: ["id", "name", "image"],
        },
        {
          model: ServiceDates,
          required: true,
          attributes: ["id", "from_time", "to_time", "date"],
        },
        {
          model: User,
          required: true,
          as: "doctorAppointment",
          attributes: ["id", "name"],
        },
        {
          model: AppointmentReview,
          required: true,
          attributes: ["id", "review"],
        },
      ],
      where: { client_id },
    });

    return res.status(200).json({
      error: false,
      client_appointments: clientAppointments,
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};
