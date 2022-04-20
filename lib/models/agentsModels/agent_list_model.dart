// To parse this JSON data, do
//
//     final agentsListModel = agentsListModelFromJson(jsonString);

import 'dart:convert';

AgentsListModel agentsListModelFromJson(String str) => AgentsListModel.fromJson(json.decode(str));

String agentsListModelToJson(AgentsListModel data) => json.encode(data.toJson());

class AgentsListModel {
  AgentsListModel({
    required this.data,
    required this.page,
    required this.limit,
    required this.count,
  });

  List<MyAgentsList> data;
  int page;
  int limit;
  int count;

  factory AgentsListModel.fromJson(Map<String, dynamic> json) => AgentsListModel(
    data: List<MyAgentsList>.from(json["data"].map((x) => MyAgentsList.fromJson(x))),
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

class MyAgentsList {
  MyAgentsList({
    required this.deliveryAgentId,
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.image,
    this.agentAddress,
    required this.isDelete,
    required this.vehicleDetails,
    required this.bankDetails,
    required this.totalOrders,
    this.created,
    required this.updated,
  });

  int? deliveryAgentId;
  int? phoneNumber;
  String? name;
  String? email;
  String? image;
  dynamic? agentAddress;
  bool isDelete;
  BankDetails bankDetails;
  VehicleDetails vehicleDetails;
  int? totalOrders;
  dynamic? created;
  DateTime updated;

  factory MyAgentsList.fromJson(Map<String, dynamic> json) => MyAgentsList(
    deliveryAgentId: json["delivery_agent_id"],
    phoneNumber: json["phone_number"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"]==null? null:json["email"],
    image: json["image"] == null ? null : json["image"],
    agentAddress: json["agent_address"],
    isDelete: json["is_delete"],
    bankDetails: BankDetails.fromJson(json["bank_details"]),
    vehicleDetails: VehicleDetails.fromJson(json["vehicle_details"]),
    created: json["created"],
    totalOrders: json["total_orders"],
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "delivery_agent_id": deliveryAgentId,
    "phone_number": phoneNumber,
    "name": name == null ? null : name,
    "email":email== null ?  null :email,
    "image": image == null ? null : image,
    "agent_address": agentAddress,
    "is_delete": isDelete,
    "bank_details": bankDetails.toJson(),
    "vehicle_details": vehicleDetails.toJson(),
    "total_orders":totalOrders,
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
  String? accountHolderName;
  dynamic? accountNumber;
  dynamic? ifscNumber;
  String? branchName;
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
  String? vehicleName;
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
