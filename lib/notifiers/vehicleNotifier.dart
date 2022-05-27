import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapdash_admin/models/profileModels/profile_details_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicles_model.dart';
import 'package:snapdash_admin/utils/storage_keys.dart';


class VehicleNotifier with ChangeNotifier {

  VehicleNotifier() {
    initUser();
  }

  VechiclesList? vehicles;

  Future<void> initUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userData = sharedPreferences.getString(StorageKeys.vehicle) ?? "";
    try {
      vehicles = VechiclesList.fromJson(jsonDecode(userData));
    } catch(err) {}
    notifyListeners();
  }

  saveUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(StorageKeys.vehicle, jsonEncode(vehicles?.toJson()));
  }

  void setUser(VechiclesList? vehicles) {
    this.vehicles =vehicles ;
    if(vehicles != null) {
      saveUser();
    }
    notifyListeners();
  }

  void clearUser() {
    vehicles = null;
    notifyListeners();
  }
}