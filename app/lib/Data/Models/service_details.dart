import 'package:meta/meta.dart';
import 'dart:convert';

class ServiceDetailsModel {
  final bool error;
  final ServiceData service;

  ServiceDetailsModel({
    required this.error,
    required this.service,
  });

  factory ServiceDetailsModel.fromRawJson(String str) =>
      ServiceDetailsModel.fromJson(json.decode(str));

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      ServiceDetailsModel(
        error: json["error"],
        service: ServiceData.fromJson(json["service"]),
      );
}

class ServiceData {
  final int id;
  final int doctorId;
  final String name;
  final String description;
  final String image;
  final List<Date> dates;

  ServiceData({
    required this.id,
    required this.doctorId,
    required this.name,
    required this.description,
    required this.image,
    required this.dates,
  });

  factory ServiceData.fromRawJson(String str) =>
      ServiceData.fromJson(json.decode(str));

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        doctorId: json['doctor_id'],
        dates: List<Date>.from(json["dates"].map((x) => Date.fromJson(x))),
      );
}

class Date {
  final int id;
  final String fromTime;
  final String toTime;
  final DateTime date;

  Date({
    required this.id,
    required this.fromTime,
    required this.toTime,
    required this.date,
  });

  factory Date.fromRawJson(String str) => Date.fromJson(json.decode(str));

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        id: json["id"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        date: DateTime.parse(json["date"]),
      );
}
