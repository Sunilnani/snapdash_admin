import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:snapdash_admin/models/agentsModels/agent_list_model.dart';
import 'package:snapdash_admin/models/users_models/user_details_model.dart';
import 'package:snapdash_admin/models/users_models/user_list_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicle_details_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicles_model.dart';
import 'package:snapdash_admin/network_calls/base_network.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/urls.dart';



class UsersManager {
  factory UsersManager() {
    return _singleton;
  }

  UsersManager._internal();

  static final UsersManager _singleton = UsersManager._internal();








  Future<ResponseData> usersList() async {
    Response response;
    try {
      response = await dioClient.ref!.get<dynamic>(URLS.userList);
      print("------response user List manager ${response.data}");

      if (response.statusCode == 200) {

        final usersList = usersListModelFromJson(jsonEncode(response.data));
        return ResponseData("success", ResponseStatus.SUCCESS,
            data: usersList);
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


  Future<ResponseData> fetchUserDetail(int? userId) async {
    Response response;
    print("hgdvghc hgsvhc s---------${userId}");
    print(URLS.vehicleDetails(userId.toString()));
    try {

      response =
      await dioClient.ref!.get<dynamic>(URLS.userDetails(userId.toString()));

      if (response.statusCode == 200) {

        print("Check 1 --> ${response.data}");
        final model = usersDetailsModelFromJson(json.encode(response.data));
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





}

UsersManager userManager = UsersManager();
