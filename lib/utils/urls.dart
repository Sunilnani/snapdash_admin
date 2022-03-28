class URLS {
  static String baseUrl ="http://51.75.202.245:8003";
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
  static String orderDetails(String orderId) =>
      "/api/v1/order_details/?order_id=$orderId";

  static String updateImage="/api/v1/update_order/";

  static String weeklyStatistics ="/api/v1/my_earnings/";
  static String dailyEarnings="/api/v1/my_earnings/?today=3";



  static String myAccountProfile="/api/v1/profile/";
  static String editProfile="/api/v1/profile/";



  static String parseImage(String? url) {
    if(url == null) return "";
    return baseUrl + url;
  }

}