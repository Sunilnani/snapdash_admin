// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    required this.orderId,
    required this.userId,
    required this.userName,
    required this.userNumber,
    required this.categoryId,
    required this.categoryName,
    required this.paymentMode,
    required this.itemName,
    required this.itemWeight,
    required this.pickupAddress,
    required this.pickupLongitude,
    required this.pickupLatitude,
    required this.deliveryAddress,
    required this.deliveryLongitude,
    required this.deliveryLatitude,
    required this.receiverId,
    required this.receiverName,
    required this.receiverNumber,
    required this.status,
    required this.distance,
    required this.price,
    required this.deliveryAgentDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  int orderId;
  int userId;
  String userName;
  int userNumber;
  int categoryId;
  String categoryName;
  String paymentMode;
  String itemName;
  int itemWeight;
  String pickupAddress;
  String pickupLongitude;
  String pickupLatitude;
  String deliveryAddress;
  String deliveryLongitude;
  String deliveryLatitude;
  int receiverId;
  dynamic receiverName;
  int receiverNumber;
  int status;
  String distance;
  double price;
  DeliveryAgentDetails deliveryAgentDetails;
  DateTime createdAt;
  DateTime updatedAt;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    orderId: json["order_id"],
    userId: json["user_id"],
    userName: json["user_name"],
    userNumber: json["user_number"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    paymentMode: json["payment_mode"],
    itemName: json["item_name"],
    itemWeight: json["item_weight"],
    pickupAddress: json["pickup_address"],
    pickupLongitude: json["pickup_longitude"],
    pickupLatitude: json["pickup_latitude"],
    deliveryAddress: json["delivery_address"],
    deliveryLongitude: json["delivery_longitude"],
    deliveryLatitude: json["delivery_latitude"],
    receiverId: json["receiver_id"],
    receiverName: json["receiver_name"],
    receiverNumber: json["receiver_number"],
    status: json["status"],
    distance: json["distance"],
    price: json["price"].toDouble(),
    deliveryAgentDetails: DeliveryAgentDetails.fromJson(json["delivery_agent_details"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "user_id": userId,
    "user_name": userName,
    "user_number": userNumber,
    "category_id": categoryId,
    "category_name": categoryName,
    "payment_mode": paymentMode,
    "item_name": itemName,
    "item_weight": itemWeight,
    "pickup_address": pickupAddress,
    "pickup_longitude": pickupLongitude,
    "pickup_latitude": pickupLatitude,
    "delivery_address": deliveryAddress,
    "delivery_longitude": deliveryLongitude,
    "delivery_latitude": deliveryLatitude,
    "receiver_id": receiverId,
    "receiver_name": receiverName,
    "receiver_number": receiverNumber,
    "status": status,
    "distance": distance,
    "price": price,
    "delivery_agent_details": deliveryAgentDetails.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class DeliveryAgentDetails {
  DeliveryAgentDetails({
    this.deliveryAgentId,
    this.deliveryAgentName,
    this.deliveryAgentNumber,
  });

  dynamic deliveryAgentId;
  dynamic deliveryAgentName;
  dynamic deliveryAgentNumber;

  factory DeliveryAgentDetails.fromJson(Map<String, dynamic> json) => DeliveryAgentDetails(
    deliveryAgentId: json["delivery_agent_id"],
    deliveryAgentName: json["delivery_agent_name"],
    deliveryAgentNumber: json["delivery_agent_number"],
  );

  Map<String, dynamic> toJson() => {
    "delivery_agent_id": deliveryAgentId,
    "delivery_agent_name": deliveryAgentName,
    "delivery_agent_number": deliveryAgentNumber,
  };
}
