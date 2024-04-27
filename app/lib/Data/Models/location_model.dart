import 'package:meta/meta.dart';
import 'dart:convert';

class LocationModel {
  final bool error;
  final List<Location> locations;

  LocationModel({
    required this.error,
    required this.locations,
  });

  factory LocationModel.fromRawJson(String str) =>
      LocationModel.fromJson(json.decode(str));

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        error: json["error"],
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
      );
}

class Location {
  final int id;
  final String name;

  Location({
    required this.id,
    required this.name,
  });

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
      );
}
