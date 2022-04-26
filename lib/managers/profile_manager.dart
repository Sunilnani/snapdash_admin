import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/models/agentsModels/agent_details_model.dart';
import 'package:snapdash_admin/models/agentsModels/agent_list_model.dart';
import 'package:snapdash_admin/models/profileModels/profile_details_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicle_details_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicles_model.dart';
import 'package:snapdash_admin/network_calls/base_network.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/notifiers/user_notifier.dart';
import 'package:snapdash_admin/utils/urls.dart';



class ProfileManager {
  factory ProfileManager() {
    return _singleton;
  }

  ProfileManager._internal();

  static final ProfileManager _singleton = ProfileManager._internal();




  Future<ResponseData> profileData() async {
    Response response;
    try {
      response = await dioClient.ref!.get<dynamic>(URLS.profileData);
      print("------response profile  manager ${response.data}");

      if (response.statusCode == 200) {

        final profile = profileModelFromJson(jsonEncode(response.data));

        Provider.of<UserNotifier>(
          NavigationService.navigatorKey.currentContext!,listen:false
        ).setUser(profile);


        print("check2 ${response.data}");
        return ResponseData("success", ResponseStatus.SUCCESS,
            data: profile);
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







  Future<ResponseData> updateProfile(Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    Response response;
    try {
      response = await dioClient.ref!
          .patch<dynamic>(URLS.updateProfile, data: formData);
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

ProfileManager profileManager = ProfileManager();
