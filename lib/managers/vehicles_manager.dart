import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:snapdash_admin/models/vehicles/vehicle_details_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicles_model.dart';
import 'package:snapdash_admin/network_calls/base_network.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/urls.dart';



class VehiclesManager {
  factory VehiclesManager() {
    return _singleton;
  }

  VehiclesManager._internal();

  static final VehiclesManager _singleton = VehiclesManager._internal();

  

  

 


  Future<ResponseData> vehicles() async {
    Response response;
    try {
      response = await dioClient.ref!.get<dynamic>(URLS.vehiclesList);
      print("------response from past orders manager ${response.data}");

      if (response.statusCode == 200) {

        final ordersList = vechiclesListFromJson(jsonEncode(response.data));
        return ResponseData("success", ResponseStatus.SUCCESS,
            data: ordersList);
      } else {
        var message = "Unknown error";
        if (response.data?.containsKey("message") == true) {
          message = response.data['message'];
        }
        return ResponseData(message, ResponseStatus.FAILED);
      }
    } on Exception catch (err) {
      var msg = ParseError.parse(err);
      return ResponseData<dynamic>(msg, ResponseStatus.FAILED);
    }
  }


  Future<ResponseData> fetchOrderDetail(int vehicleId) async {
    Response response;
    print("hgdvghc hgsvhc s---------${vehicleId}");
    print(URLS.vehicleDetails(vehicleId.toString()));
    try {

      response =
      await dioClient.ref!.get<dynamic>(URLS.vehicleDetails(vehicleId.toString()));

      if (response.statusCode == 200) {

        print("Check 1 --> ${response.data}");
        final model = vehicleDetailsFromJson(json.encode(response.data));
        return ResponseData("", ResponseStatus.SUCCESS, data: model);
      } else {
        var message = "Unknown error";
        if (response.data.containsKey("message") == true) {
          message = response.data['message'];
        }
        return ResponseData(message, ResponseStatus.FAILED);
      }
    } on Exception catch (err) {
      print("error is ${err}");
      // var msg = ParseError.parse(err);
      return ResponseData<dynamic>('Please check your internet', ResponseStatus.FAILED);
    }
  }


  Future<ResponseData> addVehicle(Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    Response response;
    try {
      response = await dioClient.ref!
          .post<dynamic>(URLS.addVehicle, data: formData);
      print("------------->${response.statusMessage}");

      if (response.statusCode == 200) {
        return ResponseData(
          response.data["message"],
          ResponseStatus.SUCCESS,
        );
      } else {
        var message = "Unknown error";
        if (response.data?.containsKey("message") == true) {
          message = response.data['message'];
        }
        return ResponseData(message, ResponseStatus.FAILED);
      }
    } on Exception catch (err) {
      var msg = ParseError.parse(err);
      return ResponseData<dynamic>(msg, ResponseStatus.FAILED);
    }
  }











}

VehiclesManager vehicleManager = VehiclesManager();