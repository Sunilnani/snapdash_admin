// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  UserDetailsModel({
    required this.userId,
     this.userName,
     this.phoneNumber,
     this.dob,
    this.gender,
     this.accountRole,
    required this.isDelete,
     this.image,
     this.address,
     this.ordersPlaced,
     this.ordersCancelled,
    this.created,
     this.updated,
  });

  int userId;
  String? userName;
  int? phoneNumber;
  DateTime? dob;
  dynamic? gender;
  int? accountRole;
  bool isDelete = false;
  String? image;
  String? address;
  int? ordersPlaced;
  int? ordersCancelled;
  dynamic? created;
  DateTime? updated;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    print('json["gender"]  ${json["gender"]}');

  return UserDetailsModel(
  userId: json["user_id"],
  userName: json["user_name"],
  phoneNumber: json["phone_number"],
  dob: json["dob"]!=null ? DateTime.parse(json["dob"]): null,
  gender: json["gender"] ?? "",
  accountRole: json["account_role"],
  isDelete: json["is_delete"] ?? false,
  image: json["image"],
  address: json["address"],
  ordersPlaced: json["orders_placed"],
  ordersCancelled: json["orders_cancelled"],
  created: json["created"]?? null,
  updated: DateTime.parse(json["updated"]),
  );
}

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "phone_number": phoneNumber,
    "dob": dob != null ?"${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}":"",
    "gender": gender,
    "account_role": accountRole,
    "is_delete": isDelete,
    "image": image,
    "address": address,
    "orders_placed": ordersPlaced,
    "orders_cancelled": ordersCancelled,
    "created": created,
    "updated": updated?.toIso8601String(),
  };
}



// // To parse this JSON data, do
// //
// //     final usersDetailsModel = usersDetailsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// UsersDetailsModel usersDetailsModelFromJson(String str) => UsersDetailsModel.fromJson(json.decode(str));
//
// String usersDetailsModelToJson(UsersDetailsModel data) => json.encode(data.toJson());
//
// class UsersDetailsModel {
//   UsersDetailsModel({
//     required this.userId,
//     this.userName,
//     required this.phoneNumber,
//     required this.dob,
//     this.gender,
//     required this.accountRole,
//     required this.isDelete,
//     required this.image,
//     required this.address,
//     required this.ordersPlaced,
//     required this.ordersCancelled,
//     this.created,
//     required this.updated,
//   });
//
//   int userId;
//   dynamic userName;
//   int phoneNumber;
//   String dob;
//   dynamic gender;
//   int accountRole;
//   bool isDelete;
//   String image;
//   String address;
//   int ordersPlaced;
//   int ordersCancelled;
//   dynamic created;
//   DateTime updated;
//
//   factory UsersDetailsModel.fromJson(Map<String, dynamic> json) => UsersDetailsModel(
//     userId: json["user_id"],
//     userName: json["user_name"],
//     phoneNumber: json["phone_number"],
//     dob: json["dob"],
//     gender: json["gender"],
//     accountRole: json["account_role"],
//     isDelete: json["is_delete"],
//     image: json["image"],
//     address: json["address"],
//     ordersPlaced: json["orders_placed"],
//     ordersCancelled: json["orders_cancelled"],
//     created: json["created"],
//     updated: DateTime.parse(json["updated"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "user_id": userId,
//     "user_name": userName,
//     "phone_number": phoneNumber,
//     "dob": dob,
//     "gender": gender,
//     "account_role": accountRole,
//     "is_delete": isDelete,
//     "image": image,
//     "address":address,
//     "orders_placed": ordersPlaced,
//     "orders_cancelled": ordersCancelled,
//     "created": created,
//     "updated": updated.toIso8601String(),
//   };
// }
