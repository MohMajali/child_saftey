import 'package:ecommerce/Data/Models/service_details.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class AppointementsDetailsModel {
  final bool error;
  final List<ClientAppointment> clientAppointments;

  AppointementsDetailsModel({
    required this.error,
    required this.clientAppointments,
  });

  factory AppointementsDetailsModel.fromRawJson(String str) =>
      AppointementsDetailsModel.fromJson(json.decode(str));

  factory AppointementsDetailsModel.fromJson(Map<String, dynamic> json) =>
      AppointementsDetailsModel(
        error: json["error"],
        clientAppointments: List<ClientAppointment>.from(
            json["client_appointments"]
                .map((x) => ClientAppointment.fromJson(x))),
      );
}

class ClientAppointment {
  final int id;
  final String status;
  final DateTime createdAt;
  final int serviceId;
  final int clientId;
  final int doctorId;
  final int dateId;
  final ServiceData2 service;
  final ServicesDate servicesDate;
  final DoctorAppointment doctorAppointment;
  final List<AppointmentsReview> appointmentsReviews;

  ClientAppointment({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.serviceId,
    required this.clientId,
    required this.doctorId,
    required this.dateId,
    required this.service,
    required this.servicesDate,
    required this.doctorAppointment,
    required this.appointmentsReviews,
  });

  factory ClientAppointment.fromRawJson(String str) =>
      ClientAppointment.fromJson(json.decode(str));

  factory ClientAppointment.fromJson(Map<String, dynamic> json) =>
      ClientAppointment(
          id: json["id"],
          status: json["status"],
          createdAt: DateTime.parse(json["created_at"]),
          serviceId: json["service_id"],
          clientId: json["client_id"],
          doctorId: json["doctor_id"],
          dateId: json["date_id"],
          service: ServiceData2.fromJson(json["service"]),
          servicesDate: ServicesDate.fromJson(json["services_date"]),
          doctorAppointment:
              DoctorAppointment.fromJson(json["doctorAppointment"]),
          appointmentsReviews: List<AppointmentsReview>.from(
              json["appointments_reviews"]
                  .map((x) => AppointmentsReview.fromJson(x))));
}

class AppointmentsReview {
  final int id;
  final String review;

  AppointmentsReview({
    required this.id,
    required this.review,
  });

  factory AppointmentsReview.fromRawJson(String str) =>
      AppointmentsReview.fromJson(json.decode(str));

  factory AppointmentsReview.fromJson(Map<String, dynamic> json) =>
      AppointmentsReview(
        id: json["id"],
        review: json["review"],
      );
}

class ServiceData2 {
  final int id;
  final String name;
  final String image;

  ServiceData2({required this.id, required this.name, required this.image});

  factory ServiceData2.fromRawJson(String str) =>
      ServiceData2.fromJson(json.decode(str));

  factory ServiceData2.fromJson(Map<String, dynamic> json) =>
      ServiceData2(id: json['id'], name: json['name'], image: json['image']);
}

class DoctorAppointment {
  final int id;
  final String name;

  DoctorAppointment({
    required this.id,
    required this.name,
  });

  factory DoctorAppointment.fromRawJson(String str) =>
      DoctorAppointment.fromJson(json.decode(str));

  factory DoctorAppointment.fromJson(Map<String, dynamic> json) =>
      DoctorAppointment(id: json["id"], name: json["name"]);
}

class ServicesDate {
  final int id;
  final String fromTime;
  final String toTime;
  final DateTime date;

  ServicesDate({
    required this.id,
    required this.fromTime,
    required this.toTime,
    required this.date,
  });

  factory ServicesDate.fromRawJson(String str) =>
      ServicesDate.fromJson(json.decode(str));

  factory ServicesDate.fromJson(Map<String, dynamic> json) => ServicesDate(
        id: json["id"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        date: DateTime.parse(json["date"]),
      );
}
