// To parse this JSON data, do
//
//     final vehicleDetails = vehicleDetailsFromJson(jsonString);

import 'dart:convert';

VehicleDetails vehicleDetailsFromJson(String str) => VehicleDetails.fromJson(json.decode(str));

String vehicleDetailsToJson(VehicleDetails data) => json.encode(data.toJson());

class VehicleDetails {
  VehicleDetails({
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
    required this.image,
    required this.vehicleStatus,
    required this.isDelete,
    this.created,
    required this.updated,
  });

  int? vehicleId;
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
  String image;
  int? vehicleStatus;
  bool isDelete;
  dynamic created;
  DateTime updated;

  factory VehicleDetails.fromJson(Map<String, dynamic> json) => VehicleDetails(
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
    image: json["image"],
    vehicleStatus: json["vehicle_status"],
    isDelete: json["is_delete"],
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
    "image": image,
    "vehicle_status": vehicleStatus,
    "is_delete": isDelete,
    "created": created,
    "updated": updated.toIso8601String(),
  };
}
