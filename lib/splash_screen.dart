import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/authentication_pages/login_page.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/my_vehicles.dart';
import 'package:snapdash_admin/utils/storage_keys.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _forward() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    try {

      final user = sharedPreferences.getString(StorageKeys.token) ?? "";
      print(user);
      print("===============================");
      Future.delayed(const Duration(seconds: 1), () {
        if(user.isNotEmpty){
          NavigationService().navigatePage(MyVehicles(), name: 'home-page', replaceAll: true);
        }
        else{
          NavigationService().navigatePage(LoginPage(), replaceAll: true);
        }

      });
    } catch (err) {
      await sharedPreferences.clear();
      // NavigationService().navigatePage(IntroductionScreens(), replaceAll: true);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _forward();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Center(
          child: Image.asset("assets/images/logo.png",
            height: 180,width: 150,)
      ),
    );
  }
}
