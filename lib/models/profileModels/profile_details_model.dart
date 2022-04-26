// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.userId,
    required this.userName,
    required this.phoneNumber,
    required this.accountRole,
    required this.email,
    required this.address,
    required this.image,
    this.created,
    required this.updated,
  });

  int userId;
  String userName;
  int phoneNumber;
  int accountRole;
  String email;
  String address;
  String image;
  dynamic? created;
  DateTime updated;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    userId: json["user_id"],
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
    accountRole: json["account_role"],
    email: json["email"],
    address: json["address"],
    image: json["image"],
    created: json["created"]== null? "": json["created"],
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "phone_number": phoneNumber,
    "account_role": accountRole,
    "email": email,
    "address": address,
    "image": image,
    "created": created,
    "updated": updated.toIso8601String(),
  };
}
