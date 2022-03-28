import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/network_calls/base_network.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/pages/authentication_pages/login_page.dart';
import 'package:snapdash_admin/utils/storage_keys.dart';
import 'package:snapdash_admin/utils/urls.dart';



class AuthManager {
  factory AuthManager() {
    return _singleton;
  }

  AuthManager._internal();

  static final AuthManager _singleton = AuthManager._internal();


  // Future<ResponseData> performLogin(String phone,) async {
  //   print("enter the end point");
  //   final formData = FormData.fromMap({"phone_number": phone, });
  //
  //
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   Response response;
  //   try {
  //     response = await dioClient.tokenRef!
  //         .post<dynamic>(URLS.login, data: formData);
  //     print("----------->${response.statusMessage}");
  //
  //
  //     if (response.statusCode == 200) {
  //       sharedPreferences.setString(
  //           StorageKeys.token, response.data["access_token"]);
  //       sharedPreferences.setString(
  //           StorageKeys.refreshToken, response.data["refresh"]);
  //       return ResponseData(response.data['message'], ResponseStatus.SUCCESS);
  //     } else {
  //       var message = "Unknown error";
  //       if (response.data?.containsKey("message") == true) {
  //         message = response.data['message'];
  //       }
  //       return ResponseData(message, ResponseStatus.FAILED);
  //     }
  //   } on Exception catch (err) {
  //     print("Error $err");
  //     return ResponseData<dynamic>(
  //         'Please check your internet', ResponseStatus.FAILED);
  //   }
  // }


  Future<ResponseData> performLogin(String? phone) async {
    final formData = FormData.fromMap({
      "phone_number": phone,
    });

    Response response;
    try {
      response = await dioClient.tokenRef!
          .post<dynamic>(URLS.login, data: formData);
      print("-------------============${response.data}");

      if(response.statusCode == 200) {
        return ResponseData(response.data['message'], ResponseStatus.SUCCESS);
      } else {
        String? message = "Unknown error";
        if(response.data?.containsKey("message") == true){
          message = response.data['message'];
        }
        return ResponseData(message!, ResponseStatus.FAILED);
      }
    } on Exception catch (err) {
      return ResponseData<dynamic>( "Something Server Problem", ResponseStatus.FAILED);
    }
  }



  Future<ResponseData> verifyOTP(String? phone, String otp) async {
    final formData = FormData.fromMap({
      "phone_number": phone,
      "otp": otp,
    });
    final sharedPreferences = await SharedPreferences.getInstance();

    Response response;
    try {
      response = await dioClient.tokenRef!
          .post<dynamic>(URLS.verifyOTP, data: formData);

      if(response.statusCode == 200) {
        sharedPreferences.setString(StorageKeys.token, response.data["data"]["token"]);
        sharedPreferences.setString(StorageKeys.refreshToken, response.data["data"]["refresh"]);
        //sharedPreferences.setInt(StorageKeys.userId, response.data["user_id"]);
        //sharedPreferences.setInt(StorageKeys.userNumber, response.data["data"]["phone_number"]);
       // profileManager.fetchProfile();
       // FirebaseNotifications.updateFCM();
        return ResponseData("", ResponseStatus.SUCCESS);
      } else {
        String? message = "Unknown error";
        if(response.data?.containsKey("message") == true){
          message = response.data["data"]['message'];
        }
        return ResponseData(message!, ResponseStatus.FAILED);
      }
    } on Exception catch (err) {
      return ResponseData<dynamic>( "Something Server Problem", ResponseStatus.FAILED);
    }
  }

  Future<ResponseData> refreshToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String refresh = sharedPreferences.getString(StorageKeys.refreshToken) ?? "";
    final formData = FormData.fromMap({
      "refresh": refresh,
    });

    print({
      "refresh": refresh,
    });

    Response response;
    try {
      response = await dioClient.tokenRef!
          .post<dynamic>(URLS.tokenRefresh, data: formData);
      print("------->refresh1 ${response.data}");

      if(response.statusCode == 200) {
        print("------->refresh2 ${response.data}");
        sharedPreferences.setString(StorageKeys.token, response.data["access"]);
        return ResponseData("", ResponseStatus.SUCCESS);
      } else {
        String? message = "Unknown error";
        if(response.data?.containsKey("message") == true){
          message = response.data['message'];
        }
        return ResponseData(message!, ResponseStatus.FAILED);
      }
    } on Exception catch (err) {
      return ResponseData<dynamic>( err.toString(), ResponseStatus.FAILED);
    }
  }





  Future<void> logout() async {
    await (await SharedPreferences.getInstance()).clear();
    NavigationService().navigatePage(LoginPage());
  }
}

AuthManager authManager = AuthManager();