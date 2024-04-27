import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  final UserData userData;

  UserModel({
    required this.userData,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userData: UserData.fromJson(json["user_data"]),
      );
}

class UserData {
  final int id;
  final String name;
  final String phone;
  final String password;
  final String email;

  UserData({
    required this.id,
    required this.name,
    required this.phone,
    required this.password,
    required this.email,
  });

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'],
        name: json["name"],
        phone: json["phone"],
        password: json["password"],
        email: json["email"],
      );
}
