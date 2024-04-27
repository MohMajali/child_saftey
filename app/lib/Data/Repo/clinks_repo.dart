import 'dart:developer';

import 'package:ecommerce/Data/Models/appointements_model.dart';
import 'package:ecommerce/Data/Models/clink_model.dart';
import 'package:ecommerce/Data/Models/location_model.dart';
import 'package:ecommerce/Data/Models/service_details.dart';
import 'package:ecommerce/Data/Models/service_model.dart';
import 'package:ecommerce/Data/Services/clinks.dart';

class ClinksRepo {
  final ClinksServices clinksServices;

  ClinksRepo(this.clinksServices);

  Future<ClinkModel> getClinks(int locationId) async {
    try {
      final clinks = await clinksServices.getClinksOnLocation(locationId);

      if (!clinks['error']) {
        return ClinkModel.fromJson(clinks);
      }

      return ClinkModel(error: true, clinks: []);
    } catch (err) {
      log("getClinks ERROR ==>  $err");
      return ClinkModel(error: true, clinks: []);
    }
  }

  Future<ServiceModel> getServicesOnClinkId(int clindId) async {
    try {
      final services = await clinksServices.getServicesOnClinkId(clindId);

      if (!services['error']) {
        return ServiceModel.fromJson(services);
      }

      return ServiceModel(error: true, services: []);
    } catch (err) {
      log("getServicesOnClinkId ERROR ==>  $err");
      return ServiceModel(error: true, services: []);
    }
  }

  Future<ServiceDetailsModel> getServicesOnId(int serviceId) async {
    try {
      final service = await clinksServices.getServicesOnId(serviceId);

      if (!service['error']) {
        return ServiceDetailsModel.fromJson(service);
      }

      return ServiceDetailsModel(
          error: true,
          service: ServiceData(
              id: 0,
              doctorId: 0,
              dates: [],
              description: '',
              image: '',
              name: ''));
    } catch (err) {
      log("getServicesOnId ERROR ==>  $err");
      return ServiceDetailsModel(
          error: true,
          service: ServiceData(
              id: 0,
              doctorId: 0,
              dates: [],
              description: '',
              image: '',
              name: ''));
    }
  }

  Future makeAppointement(
      int serviceId, int clientId, int doctorId, int dateId) async {
    try {
      final appointementRes = await clinksServices.makeAppointement(
          serviceId, clientId, doctorId, dateId);

      return appointementRes;
    } catch (err) {
      log("makeAppointement ERROR ==>  $err");

      return err;
    }
  }

  Future<AppointementsDetailsModel> getClientAppointements(int clientId) async {
    try {
      final appointementsRes =
          await clinksServices.getClientAppointements(clientId);

      if (!appointementsRes['error']) {
        return AppointementsDetailsModel.fromJson(appointementsRes);
      }
      return AppointementsDetailsModel(error: true, clientAppointments: []);
    } catch (err) {
      log("getClientAppointements ERROR ==>  $err");

      return AppointementsDetailsModel(error: true, clientAppointments: []);
    }
  }

  Future<LocationModel> getLocations() async {
    try {
      final locations = await clinksServices.getLocations();

      if (!locations['error']) {
        return LocationModel.fromJson(locations);
      }

      return LocationModel(error: true, locations: []);
    } catch (err) {
      log("getLocations ERROR ==>  $err");

      return LocationModel(error: true, locations: []);
    }
  }

  
}
