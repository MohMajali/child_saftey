import 'package:ecommerce/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class UserServices {
  Future login(String family_book_id, String password) async {
    try {
      final body =
          jsonEncode({'family_book_id': family_book_id, 'password': password});
      var response = await http.post(Uri.parse('$URL/users/login'),
          headers: {'Content-Type': 'application/json'}, body: body);

      var userResponse = json.decode(response.body);
      return userResponse;
    } catch (err) {
      log('LOGIN FUNCTION ===> $err');
    }
  }

  Future getUser(int id) async {
    try {
      var response = await http.get(Uri.parse('$URL/users/$id'),
          headers: {'Content-Type': 'application/json'});

      var userResponse = json.decode(response.body);
      return userResponse;
    } catch (err) {
      log('Get User FUNCTION ===> $err');
    }
  }

  Future signUp(String nationalId, String familyBookId, String name,
      String email, String password, String phone) async {
    try {
      final body = jsonEncode({
        'national_id': nationalId,
        'family_book_id': familyBookId,
        'name': name,
        'email': email,
        'password': password,
        'phone': phone
      });
      var response = await http.post(Uri.parse('$URL/users/signup'),
          body: body, headers: {'Content-Type': 'application/json'});

      var userResponse = json.decode(response.body);
      return userResponse;
    } catch (err) {
      log('SIGNUP FUNCTION ===> $err');
    }
  }

  Future updateAccount(String name, String email, String password, String phone,
      int userId) async {
    try {
      final body = jsonEncode(
          {'name': name, 'email': email, 'password': password, 'phone': phone});
      var response = await http.put(Uri.parse('$URL/users/update/$userId'),
          body: body, headers: {'Content-Type': 'application/json'});

      var userResponse = json.decode(response.body);
      return userResponse;
    } catch (err) {
      log('updateAccount FUNCTION ===> $err');
    }
  }
}
