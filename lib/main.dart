import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/notifiers/user_notifier.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/my_vehicles.dart';
import 'package:snapdash_admin/pages/orders_screens/order_details.dart';
import 'package:snapdash_admin/pages/users_screens/view_user.dart';
import 'package:snapdash_admin/splash_screen.dart';

import 'pages/authentication_pages/login_page.dart';

// void main() {
//   runApp(const MyApp());
// }
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => CartNotifier()),
        ChangeNotifierProvider(create: (_) => UserNotifier()),
      ],
      child: MyApp(),
    ),
  );
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
      home: const SplashScreen()

    );
  }
}

