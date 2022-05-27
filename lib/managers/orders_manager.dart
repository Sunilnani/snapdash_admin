import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:snapdash_admin/models/agentsModels/agent_list_model.dart';
import 'package:snapdash_admin/models/orders_model/order_details_model.dart';
import 'package:snapdash_admin/models/orders_model/orders_list_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicle_details_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicles_model.dart';
import 'package:snapdash_admin/network_calls/base_network.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/urls.dart';



class OrdersManager {
  factory OrdersManager() {
    return _singleton;
  }

  OrdersManager._internal();

  static final OrdersManager _singleton = OrdersManager._internal();








  Future<ResponseData> ordersList({String query = "", String name=""}) async {
    Response response;
    try {
      final data = <String, dynamic>{};
      if(query.isNotEmpty ) {
        data['search_text'] = query;
      }
      if(name.isNotEmpty){

        data["category_name"]=name;
      }

      response = await dioClient.ref!.get<dynamic>(URLS.ordersList,queryParameters: data);
      // print("------response agent List manager ${response.data}");

      if (response.statusCode == 200) {

        final ordersList = ordersListModelFromJson(jsonEncode(response.data));
        return ResponseData("success", ResponseStatus.SUCCESS,
            data: ordersList);
      } else {
        var message = "Unknown error";
        if (response.data?.containsKey("message") == true) {
          message = response.data['message'];
        }
        return ResponseData(message, ResponseStatus.FAILED);
      }
    } on Exception catch (err) {
      var msg = ParseError.parse(err);
      return ResponseData<dynamic>(msg, ResponseStatus.FAILED);
    }
  }



  Future<ResponseData> fetchOrderDetail(int? orderId) async {
    Response response;
    print("hgdvghc hgsvhc s---------${orderId}");
    print(URLS.orderDetails(orderId.toString()));
    try {

      response =
      await dioClient.ref!.get<dynamic>(URLS.orderDetails(orderId.toString()));

      if (response.statusCode == 200) {

        print("Check 1 --> ${response.data}");
        final model = orderDetailsModelFromJson(json.encode(response.data));
        return ResponseData("", ResponseStatus.SUCCESS, data: model);
      } else {
        var message = "Unknown error";
        if (response.data.containsKey("message") == true) {
          message = response.data['message'];
        }
        return ResponseData(message, ResponseStatus.FAILED);
      }
    } on Exception catch (err) {
      print("error is ${err}");
      // var msg = ParseError.parse(err);
      return ResponseData<dynamic>('Please check your internet', ResponseStatus.FAILED);
    }
  }














}

OrdersManager ordersManager = OrdersManager();
