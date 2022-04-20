// To parse this JSON data, do
//
//     final agentDetailsModel = agentDetailsModelFromJson(jsonString);

import 'dart:convert';

AgentDetailsModel agentDetailsModelFromJson(String str) => AgentDetailsModel.fromJson(json.decode(str));

String agentDetailsModelToJson(AgentDetailsModel data) => json.encode(data.toJson());

class AgentDetailsModel {
  AgentDetailsModel({
    required this.deliveryAgentId,
    required this.phoneNumber,
    required this.agentName,
    this.agentImage,
    this.agentAddress,
    required this.isDelete,
    required this.bankDetails,
    required this.vehicleDetails,
    required this.created,
    required this.updated,
  });

  int? deliveryAgentId;
  int? phoneNumber;
  String? agentName;
  dynamic? agentImage;
  dynamic? agentAddress;
  bool? isDelete;
  BankDetails bankDetails;
  VehicleDetails vehicleDetails;
  dynamic? created;
  DateTime updated;

  factory AgentDetailsModel.fromJson(Map<String, dynamic> json) => AgentDetailsModel(
    deliveryAgentId: json["delivery_agent_id"],
    phoneNumber: json["phone_number"],
    agentName: json["agent_name"],
    agentImage: json["agent_image"],
    agentAddress: json["agent_address"],
    isDelete: json["is_delete"],
    bankDetails: BankDetails.fromJson(json["bank_details"]),
    vehicleDetails: VehicleDetails.fromJson(json["vehicle_details"]),
    created: json["created"],
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "delivery_agent_id": deliveryAgentId,
    "phone_number": phoneNumber,
    "agent_name": agentName,
    "agent_image": agentImage,
    "agent_address": agentAddress,
    "is_delete": isDelete,
    "bank_details": bankDetails.toJson(),
    "vehicle_details": vehicleDetails.toJson(),
    "created": created,
    "updated": updated.toIso8601String(),
  };
}

class BankDetails {
  BankDetails({
    this.bankName,
    this.accountHolderName,
    this.accountNumber,
    this.ifscNumber,
    this.branchName,
    this.mobileNumberInBank,
    this.bankAddress,
  });

  String? bankName;
  dynamic? accountHolderName;
  dynamic? accountNumber;
  dynamic? ifscNumber;
  dynamic? branchName;
  dynamic? mobileNumberInBank;
  dynamic? bankAddress;

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
    bankName: json["bank_name"],
    accountHolderName: json["account_holder_name"],
    accountNumber: json["account_number"],
    ifscNumber: json["ifsc_number"],
    branchName: json["branch_name"],
    mobileNumberInBank: json["mobile_number_in_bank"],
    bankAddress: json["bank_address"],
  );

  Map<String, dynamic> toJson() => {
    "bank_name": bankName,
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "ifsc_number": ifscNumber,
    "branch_name": branchName,
    "mobile_number_in_bank": mobileNumberInBank,
    "bank_address": bankAddress,
  };
}

class VehicleDetails {
  VehicleDetails({
    this.vehicleId,
    this.vehicleName,
    this.modelType,
    this.modelNumber,
    this.licenceNumber,
    this.engineNumber,
    this.chassisNumber,
    this.insuranceNumber,
    this.registrationDate,
    this.registrationUpto,
    this.pollutionValidUpto,
    this.image,
    this.isDelete,
  });

  dynamic? vehicleId;
  dynamic? vehicleName;
  dynamic? modelType;
  dynamic? modelNumber;
  dynamic? licenceNumber;
  dynamic? engineNumber;
  dynamic? chassisNumber;
  dynamic? insuranceNumber;
  dynamic? registrationDate;
  dynamic? registrationUpto;
  dynamic? pollutionValidUpto;
  dynamic? image;
  dynamic? isDelete;

  factory VehicleDetails.fromJson(Map<String, dynamic> json) => VehicleDetails(
    vehicleId: json["vehicle_id"],
    vehicleName: json["vehicle_name"],
    modelType: json["model_type"],
    modelNumber: json["model_number"],
    licenceNumber: json["licence_number"],
    engineNumber: json["engine_number"],
    chassisNumber: json["chassis_number"],
    insuranceNumber: json["insurance_number"],
    registrationDate: json["registration_date"],
    registrationUpto: json["registration_upto"],
    pollutionValidUpto: json["pollution_valid_upto"],
    image: json["image"],
    isDelete: json["is_delete"],
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
    "registration_date": registrationDate,
    "registration_upto": registrationUpto,
    "pollution_valid_upto": pollutionValidUpto,
    "image": image,
    "is_delete": isDelete,
  };
}
