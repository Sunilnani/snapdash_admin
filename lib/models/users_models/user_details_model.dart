// To parse this JSON data, do
//
//     final usersDetailsModel = usersDetailsModelFromJson(jsonString);

import 'dart:convert';

UsersDetailsModel usersDetailsModelFromJson(String str) => UsersDetailsModel.fromJson(json.decode(str));

String usersDetailsModelToJson(UsersDetailsModel data) => json.encode(data.toJson());

class UsersDetailsModel {
  UsersDetailsModel({
    required this.userId,
    this.userName,
    required this.phoneNumber,
    this.dob,
    this.gender,
    required this.accountRole,
    required this.isDelete,
    this.image,
    required this.ordersPlaced,
    required this.ordersCancelled,
    this.created,
    required this.updated,
  });

  int userId;
  dynamic userName;
  int phoneNumber;
  dynamic dob;
  dynamic gender;
  int accountRole;
  bool isDelete;
  dynamic image;
  int ordersPlaced;
  int ordersCancelled;
  dynamic created;
  DateTime updated;

  factory UsersDetailsModel.fromJson(Map<String, dynamic> json) => UsersDetailsModel(
    userId: json["user_id"],
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
    dob: json["dob"],
    gender: json["gender"],
    accountRole: json["account_role"],
    isDelete: json["is_delete"],
    image: json["image"],
    ordersPlaced: json["orders_placed"],
    ordersCancelled: json["orders_cancelled"],
    created: json["created"],
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "phone_number": phoneNumber,
    "dob": dob,
    "gender": gender,
    "account_role": accountRole,
    "is_delete": isDelete,
    "image": image,
    "orders_placed": ordersPlaced,
    "orders_cancelled": ordersCancelled,
    "created": created,
    "updated": updated.toIso8601String(),
  };
}
