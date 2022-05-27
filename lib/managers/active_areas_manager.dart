import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/models/activeAreasModels/active_areas_model.dart';
import 'package:snapdash_admin/models/agentsModels/agent_details_model.dart';
import 'package:snapdash_admin/models/agentsModels/agent_list_model.dart';
import 'package:snapdash_admin/models/profileModels/profile_details_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicle_details_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicles_model.dart';
import 'package:snapdash_admin/network_calls/base_network.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/notifiers/user_notifier.dart';
import 'package:snapdash_admin/utils/urls.dart';



class ActiveAreasManager {
  factory ActiveAreasManager() {
    return _singleton;
  }

  ActiveAreasManager._internal();

  static final ActiveAreasManager _singleton = ActiveAreasManager._internal();




  Future<ResponseData> activeAreas() async {
    Response response;
    try {
      response = await dioClient.ref!.get<dynamic>(URLS.activeAreas);
      print("------response active areas  manager ${response.data}");

      if (response.statusCode == 200) {

        final activeAreas = activeAreasModelFromJson(jsonEncode(response.data));

        // Provider.of<UserNotifier>(
        //     NavigationService.navigatorKey.currentContext!,listen:false
        // ).setUser(profile);


        print("check2 ${response.data}");
        return ResponseData("success", ResponseStatus.SUCCESS,
            data: activeAreas);
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







  Future<ResponseData> addLocation(Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    Response response;
    try {
      response = await dioClient.ref!
          .post<dynamic>(URLS.addLocation, data: formData);
      print("------------->added profile are${response.statusMessage}");

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

ActiveAreasManager activeAreasManager = ActiveAreasManager();
