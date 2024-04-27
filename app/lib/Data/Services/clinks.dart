import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce/constants.dart';
import 'package:http/http.dart' as http;

class ClinksServices {
  Future getClinksOnLocation(int locationId) async {
    try {
      var response = await http.get(Uri.parse('$URL/clinks/$locationId'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          });

      var clinksResponse = json.decode(response.body);
      return clinksResponse;
    } catch (err) {
      log('getClinks FUNCTION ===> $err');
      return err;
    }
  }

  Future getServicesOnClinkId(int clinkId) async {
    try {
      var response = await http.get(Uri.parse('$URL/services/$clinkId'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          });

      var servicesResponse = json.decode(response.body);
      return servicesResponse;
    } catch (err) {
      log('getServicesOnClinkId FUNCTION ===> $err');
      return err;
    }
  }

  Future getServicesOnId(int serviceId) async {
    try {
      var response = await http
          .get(Uri.parse('$URL/services/service/$serviceId'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      });

      var serviceResponse = json.decode(response.body);
      return serviceResponse;
    } catch (err) {
      log('getServicesOnId FUNCTION ===> $err');
      return err;
    }
  }

  Future makeAppointement(
      int serviceId, int clientId, int doctorId, int dateId) async {
    try {
      final body = jsonEncode({
        'service_id': serviceId,
        'client_id': clientId,
        'doctor_id': doctorId,
        'date_id': dateId
      });
      var response = await http.post(Uri.parse('$URL/services/appointment'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: body);

      var serviceAppointementResponse = json.decode(response.body);
      return serviceAppointementResponse;
    } catch (err) {
      log('makeAppointement FUNCTION ===> $err');
      return err;
    }
  }

  Future getLocations() async {
    try {
      var response = await http.get(Uri.parse('$URL/clinks/locations'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          });

      var locationsResponse = json.decode(response.body);
      return locationsResponse;
    } catch (err) {
      log('getLocations FUNCTION ===> $err');
      return err;
    }
  }

  Future getClientAppointements(int clientId) async {
    try {
      var response = await http
          .get(Uri.parse('$URL/services/appointment/$clientId'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      });

      var appointementsResponse = json.decode(response.body);
      return appointementsResponse;
    } catch (err) {
      log('getClientAppointements FUNCTION ===> $err');
      return err;
    }
  }

}
