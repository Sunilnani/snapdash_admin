// To parse this JSON data, do
//
//     final activeAreasModel = activeAreasModelFromJson(jsonString);

import 'dart:convert';

ActiveAreasModel activeAreasModelFromJson(String str) => ActiveAreasModel.fromJson(json.decode(str));

String activeAreasModelToJson(ActiveAreasModel data) => json.encode(data.toJson());

class ActiveAreasModel {
  ActiveAreasModel({
    required this.data,
    required this.page,
    required this.limit,
    required this.totalCount,

  });

  List<ActiveAreasList> data;
  int? page;
  int? limit;
  int totalCount;


  factory ActiveAreasModel.fromJson(Map<String, dynamic> json) => ActiveAreasModel(
    data: List<ActiveAreasList>.from(json["data"].map((x) => ActiveAreasList.fromJson(x))),
    page: json["page"],
    limit: json["limit"],
    totalCount: json["total_count"],

  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "page": page,
    "limit": limit,
    "total_count": totalCount,
  };
}

class ActiveAreasList {
  ActiveAreasList({
    required this.areaId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.users,
    required this.totalorders,
    required this.created,
    required this.updated,
  });

  int areaId;
  String address;
  dynamic latitude;
  dynamic longitude;
  int? users;
  int? totalorders;
  DateTime created;
  DateTime updated;

  factory ActiveAreasList.fromJson(Map<String, dynamic> json) => ActiveAreasList(
    areaId: json["area_id"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    users: json["total_users"],
    totalorders: json["total_orders"],
    created: DateTime.parse(json["created"]),
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "area_id": areaId,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "total_users":users,
    "total_orders":totalorders,
    "created": created.toIso8601String(),
    "updated": updated.toIso8601String(),
  };
}
