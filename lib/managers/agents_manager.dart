import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:snapdash_admin/models/agentsModels/agent_details_model.dart';
import 'package:snapdash_admin/models/agentsModels/agent_list_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicle_details_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicles_model.dart';
import 'package:snapdash_admin/network_calls/base_network.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/urls.dart';



class AgentsManager {
  factory AgentsManager() {
    return _singleton;
  }

  AgentsManager._internal();

  static final AgentsManager _singleton = AgentsManager._internal();








  Future<ResponseData> agentsList({String query = ""}) async {
    Response response;
    try {

      final data = <String, dynamic>{};
      if(query.isNotEmpty) {
        data['search_text'] = query;
      }


      response = await dioClient.ref!.get<dynamic>(URLS.agentsList,queryParameters: data);
      print("------response agent List manager ${response.data}");

      if (response.statusCode == 200) {

        final agentsList = agentsListModelFromJson(jsonEncode(response.data));
        return ResponseData("success", ResponseStatus.SUCCESS,
            data: agentsList);
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


  Future<ResponseData> fetchAgentDetail(int? agentId) async {
    Response response;
    print("hgdvghc hgsvhc s---------${agentId}");
    print(URLS.vehicleDetails(agentId.toString()));
    try {

      response =
      await dioClient.ref!.get<dynamic>(URLS.agentDetails(agentId.toString()));

      if (response.statusCode == 200) {

        print("Check 1 --> ${response.data}");
        final model = agentDetailsModelFromJson(json.encode(response.data));
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


  Future<ResponseData> addAgent(Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    Response response;
    try {
      response = await dioClient.ref!
          .post<dynamic>(URLS.addAgent, data: formData);
      //print("------------->added agents are${response.statusMessage}");

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




  Future<ResponseData> updateAgent(Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    Response response;
    try {
      response = await dioClient.ref!
          .patch<dynamic>(URLS.updateAgent, data: formData);
      print("------------->updated agents are${response.statusMessage}");

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

  Future<ResponseData> deleteAgent(Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    Response response;
    try {
      response = await dioClient.ref!
          .delete<dynamic>(URLS.deleteAgent, data: formData);
      print("------------->added vehicles are${response.statusMessage}");

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

AgentsManager agentManager = AgentsManager();
