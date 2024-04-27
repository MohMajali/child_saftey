import 'dart:convert';

class ClinkModel {
  final bool error;
  final List<Clink> clinks;

  ClinkModel({
    required this.error,
    required this.clinks,
  });

  factory ClinkModel.fromRawJson(String str) =>
      ClinkModel.fromJson(json.decode(str));

  factory ClinkModel.fromJson(Map<String, dynamic> json) => ClinkModel(
        error: json["error"],
        clinks: List<Clink>.from(json["clinks"].map((x) => Clink.fromJson(x))),
      );
}

class Clink {
  final int id;
  final String name;
  final String phone;
  final String description;
  final String image;
  final int active;
  final DateTime createdAt;
  final int locationId;

  Clink({
    required this.id,
    required this.name,
    required this.phone,
    required this.description,
    required this.image,
    required this.active,
    required this.createdAt,
    required this.locationId,
  });

  factory Clink.fromRawJson(String str) => Clink.fromJson(json.decode(str));

  factory Clink.fromJson(Map<String, dynamic> json) => Clink(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        description: json["description"],
        image: json["image"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        locationId: json["location_id"],
      );
}
