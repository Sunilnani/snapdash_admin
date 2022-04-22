// To parse this JSON data, do
//
//     final unAssignedVehicles = unAssignedVehiclesFromJson(jsonString);

import 'dart:convert';

UnAssignedVehicles unAssignedVehiclesFromJson(String str) => UnAssignedVehicles.fromJson(json.decode(str));

String unAssignedVehiclesToJson(UnAssignedVehicles data) => json.encode(data.toJson());

class UnAssignedVehicles {
  UnAssignedVehicles({
    required this.data,
    required this.page,
    required this.limit,
    required this.count,
  });

  List<UnAssignedVehiclesList> data;
  int page;
  int limit;
  int count;

  factory UnAssignedVehicles.fromJson(Map<String, dynamic> json) => UnAssignedVehicles(
    data: List<UnAssignedVehiclesList>.from(json["data"].map((x) => UnAssignedVehiclesList.fromJson(x))),
    page: json["page"],
    limit: json["limit"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "page": page,
    "limit": limit,
    "count": count,
  };
}

class UnAssignedVehiclesList {
  UnAssignedVehiclesList({
    required this.vehicleId,
    required this.vehicleName,
    required this.modelType,
    required this.modelNumber,
    required this.licenceNumber,
    required this.engineNumber,
    required this.chassisNumber,
    required this.insuranceNumber,
    required this.registrationDate,
    required this.registrationUpto,
    required this.pollutionValidUpto,
    required this.vehicleImage,
    required this.vehicleStatus,
    this.created,
    required this.updated,
  });

  int vehicleId;
  String vehicleName;
  String modelType;
  String modelNumber;
  String licenceNumber;
  String engineNumber;
  String chassisNumber;
  String insuranceNumber;
  DateTime registrationDate;
  DateTime registrationUpto;
  DateTime pollutionValidUpto;
  String vehicleImage;
  int vehicleStatus;
  dynamic created;
  DateTime updated;

  factory UnAssignedVehiclesList.fromJson(Map<String, dynamic> json) => UnAssignedVehiclesList(
    vehicleId: json["vehicle_id"],
    vehicleName: json["vehicle_name"],
    modelType: json["model_type"],
    modelNumber: json["model_number"],
    licenceNumber: json["licence_number"],
    engineNumber: json["engine_number"],
    chassisNumber: json["chassis_number"],
    insuranceNumber: json["insurance_number"],
    registrationDate: DateTime.parse(json["registration_date"]),
    registrationUpto: DateTime.parse(json["registration_upto"]),
    pollutionValidUpto: DateTime.parse(json["pollution_valid_upto"]),
    vehicleImage: json["vehicle_image"],
    vehicleStatus: json["vehicle_status"],
    created: json["created"],
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "vehicle_id": vehicleId,
    "vehicle_name": vehicleName,
    "model_type": modelType,
    "model_number": modelNumber,
    "licence_number": licenceNumber,
    "engine_number": engineNumber,
    "chassis_number": chassisNumber,
    "insurance_number": insuranceNumber,
    "registration_date": registrationDate.toIso8601String(),
    "registration_upto": registrationUpto.toIso8601String(),
    "pollution_valid_upto": pollutionValidUpto.toIso8601String(),
    "vehicle_image": vehicleImage,
    "vehicle_status": vehicleStatus,
    "created": created,
    "updated": updated.toIso8601String(),
  };
}
