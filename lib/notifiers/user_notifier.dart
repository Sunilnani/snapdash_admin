import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapdash_admin/models/profileModels/profile_details_model.dart';
import 'package:snapdash_admin/utils/storage_keys.dart';


class UserNotifier with ChangeNotifier {

  UserNotifier() {
    initUser();
  }

  ProfileModel? user;

  Future<void> initUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userData = sharedPreferences.getString(StorageKeys.user) ?? "";
    try {
      user = ProfileModel.fromJson(jsonDecode(userData));
    } catch(err) {}
    notifyListeners();
  }

  saveUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(StorageKeys.user, jsonEncode(user?.toJson()));
  }

  void setUser(ProfileModel? user) {
    this.user = user;
    if(user != null) {
      saveUser();
    }
    notifyListeners();
  }

  void clearUser() {
    user = null;
    notifyListeners();
  }
}