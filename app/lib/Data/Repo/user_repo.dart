import 'dart:developer';

import 'package:ecommerce/Data/Models/user_model.dart';
import 'package:ecommerce/Data/Services/Auth.dart';

class UserRepo {
  final UserServices userServices;

  UserRepo(this.userServices);

  Future login(String family_book_id, String password) async {
    try {
      final user = await userServices.login(family_book_id, password);

      if (!user['error']) {
        return user;
      }
    } catch (err) {
      log("Login REPO ERROR ==>  $err");
      throw UserModel(
          userData:
              UserData(id: 0, email: '', name: '', password: '', phone: ''));
    }
  }

  Future signUp(String nationalId, String familyBookId, String name,
      String email, String password, String phone) async {
    try {
      final user = await userServices.signUp(
          nationalId, familyBookId, name, email, password, phone);

      if (!user['error']) {
        return "Account Created Successfully";
      }

      throw "Account Already Exist";
    } catch (err) {
      log("SIGNUP REPO ERROR ==>  $err");
      throw "Account Already Exist";
    }
  }

  Future updateAccount(String name, String email, String password, String phone,
      int userId) async {
    try {
      final user = await userServices.updateAccount(
          name, email, password, phone, userId);

      if (!user['error']) {
        return "Account Updated";
      }

      throw "Something Went Wrong";
    } catch (err) {
      log("updateAccount REPO ERROR ==>  $err");
      throw "Something Went Wrong";
    }
  }

  Future<UserModel> getUserData(int id) async {
    try {
      final userData = await userServices.getUser(id);

      if (!userData['error']) {
        return UserModel.fromJson(userData);
      }

      return UserModel(
          userData:
              UserData(id: 0, name: '', email: '', password: '', phone: ''));
    } catch (err) {
      log("GET USER REPO ERROR ==>  $err");
      throw UserModel(
          userData:
              UserData(id: 0, email: '', name: '', password: '', phone: ''));
    }
  }
}
