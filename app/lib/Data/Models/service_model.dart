import 'package:meta/meta.dart';
import 'dart:convert';

class ServiceModel {
  final bool error;
  final List<Service> services;

  ServiceModel({
    required this.error,
    required this.services,
  });

  factory ServiceModel.fromRawJson(String str) =>
      ServiceModel.fromJson(json.decode(str));

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        error: json["error"],
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
      );
}

class Service {
  final int id;
  final String name;
  final String description;
  final String image;
  final User user;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.user,
  });

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        user: User.fromJson(json["user"]),
      );
}

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );
}
