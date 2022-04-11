import 'package:flutter/material.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/my_vehicles.dart';
import 'package:snapdash_admin/pages/orders_screens/order_details.dart';
import 'package:snapdash_admin/pages/users_screens/view_user.dart';

import 'pages/authentication_pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [
        NavigationService.routeObserver,
      ],
      navigatorKey: NavigationService.navigatorKey,
      home: const LoginPage(),

    );
  }
}

