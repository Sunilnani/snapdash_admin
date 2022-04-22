class URLS {
  static String baseUrl =   "http://51.89.21.83:5001";
  static String login = "/api/v1/login/";
  static String verifyOTP = "/api/v1/verify_otp/";

  static String tokenRefresh = "/api/v1/token_refresh/";
  static String locationUpdate="/api/v1/update_location/";
  static String notificationUpdate="/api/v1/update_notification_key/";
  //static String pastOrders="/api/v1/orders/";

  static String acceptOrder = "/api/v1/accept_order/";
//  static String ongoingOrder="/api/v1/orders/?current_orders=5";
  static String ongoingOrder="/api/v1/orders/?order_status=6,7";
  static String pastOrders="/api/v1/orders/?past_orders=8";


  // static String updateImage="/api/v1/update_order/";
  //
  // static String weeklyStatistics ="/api/v1/my_earnings/";
  // static String dailyEarnings="/api/v1/my_earnings/?today=3";
  // static String myAccountProfile="/api/v1/profile/";
  // static String editProfile="/api/v1/profile/";




  static String vehiclesList="/api/v1/vehicles/";
  static String vehicleDetails(String vehicleId)=>"/api/v1/vehicle_details/?vehicle_id=$vehicleId";
  static String addVehicle="/api/v1/vehicles/";
  static String updateVehicle="/api/v1/vehicles/";
  static String deleteVehicle="/api/v1/vehicles/";
  static String unAssignedVehicles="/api/v1/vehicles/?vehicle_status=1";



  static String agentsList="/api/v1/agents/";
  static String agentDetails(String agentId)=>"/api/v1/agent_details/?agent_id=$agentId";
  static String addAgent="/api/v1/agents/";
  static String updateAgent="/api/v1/agents/";
  static String deleteAgent="/api/v1/agents/";


  static String userList="/api/v1/users/";
  static String userDetails(String userId) =>
      "/api/v1/user_details/?user_id=$userId";
  static String userCancelledOrder(String userId)=>"/api/v1/user_orders_list/?user_id=$userId&cancelled_orders=5";
  static String userPlacedOrder(String usersId)=>"/api/v1/user_orders_list/?user_id=$usersId&placed_orders=6,7,8";

  //static String userCancelled="/api/v1/user_orders_list/?user_id=2&cancelled_orders=5";



  static String ordersList="/api/v1/orders/";
  static String orderDetails(String orderId) =>
      "/api/v1/order_details/?order_id=$orderId";


  static String parseImage(String? url) {
    if(url == null) return "";
    return baseUrl + url;
  }

}