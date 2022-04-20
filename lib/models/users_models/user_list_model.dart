// To parse this JSON data, do
//
//     final usersListModel = usersListModelFromJson(jsonString);

import 'dart:convert';

UsersListModel usersListModelFromJson(String str) => UsersListModel.fromJson(json.decode(str));

String usersListModelToJson(UsersListModel data) => json.encode(data.toJson());

class UsersListModel {
  UsersListModel({
    required this.userData,
    required this.page,
    required this.limit,
    required this.totalCount,
  });

  List<UserDatum> userData;
  int page;
  int limit;
  int totalCount;

  factory UsersListModel.fromJson(Map<String, dynamic> json) => UsersListModel(
    userData: List<UserDatum>.from(json["user_data"].map((x) => UserDatum.fromJson(x))),
    page: json["page"],
    limit: json["limit"],
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "user_data": List<dynamic>.from(userData.map((x) => x.toJson())),
    "page": page,
    "limit": limit,
    "total_count": totalCount,
  };
}

class UserDatum {
  UserDatum({
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

  int? userId;
  String? userName;
  int? phoneNumber;
  dynamic? dob;
  dynamic? gender;
  int? accountRole;
  bool isDelete;
  dynamic? image;
  int? ordersPlaced;
  int? ordersCancelled;
  dynamic? created;
  DateTime updated;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
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
