
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/common/button_widget.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/auth_manager.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/pages/authentication_pages/otp_page.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  //final passwordController = TextEditingController();
  final numberController = TextEditingController();



  Future<void> performLogin() async {
    String phone = numberController.text.trim();
    if (phone.isEmpty) {
      Fluttertoast.showToast( msg:"enter details");
      return;
    }

    setState(() {
      _loading = true;
    });

    final response = await authManager.performLogin(phone);

    setState(() {
      _loading = false;
    });

    if (response.status == ResponseStatus.SUCCESS) {
      print("===============${response.data}");
      Fluttertoast.showToast(msg:response.message);

      NavigationService().navigatePage(OTPScreen(number: "${phone}"));
    } else {
      Fluttertoast.showToast(msg:response.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 0, bottom: 0, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset("assets/images/logo.png",
                    height: 120,width: 150,)
                ),
                SizedBox(
                  height: 30,
                ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     "Mobile Number",
                     style: TextStyle(
                       fontSize: 24,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Text(
                     "OTP will be sent on this number",
                     style: TextStyle(
                       fontSize: 12,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   Container(
                     margin: EdgeInsets.only(top: 40),
                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                     height: 60,
                     width: MediaQuery.of(context).size.width*0.4,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(width: 1, color: Colors.grey)),
                     child: Center(
                       child: Row(
                         children: [
                           Icon(
                             Icons.call,
                             color: Colors.grey[500],
                           ),
                           SizedBox(
                             width: 15,
                           ),
                           Text(
                             "+91",
                             style: TextStyle(
                               fontSize: 18,
                               color: Colors.grey[500],
                               fontWeight: FontWeight.w700,
                             ),
                           ),
                           SizedBox(
                             width: 15,
                           ),
                           Expanded(
                             child: Container(
                               child: TextField(
                                 style: TextStyle(
                                   fontSize: 18,
                                   fontWeight: FontWeight.w600,
                                 ),
                                  controller: numberController,
                                 cursorColor: AppColors.appColor,
                                 keyboardType: TextInputType.phone,
                                 inputFormatters: <TextInputFormatter>[
                                   FilteringTextInputFormatter.digitsOnly,
                                   LengthLimitingTextInputFormatter(10)
                                 ],
                                 decoration: InputDecoration(
                                     hintText: "Enter your number",
                                     // suffixIcon: Padding(
                                     //   padding: const EdgeInsets.all(10.0),
                                     //   child: Image(
                                     //     image:
                                     //         AssetImage("assets/images/check.png",),
                                     //     height: 6,
                                     //     width: 6,
                                     //     color: Colors.grey[400],
                                     //   ),
                                     // ),
                                     hintStyle: TextStyle(
                                         fontSize: 16,
                                         fontWeight: FontWeight.w600,
                                         color: Colors.grey[500]),
                                     border: InputBorder.none),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),

                 ],
               ),


                SizedBox(height: 150),
                _loading?CustomCircularProgressIndicator():

                InkWell(
                    onTap: () {
                      //verifyotp();
                      performLogin();
                      //NavigationService().navigatePage(OTPScreen(number: number));
                    },
                    child: ButtonWidget(
                      name: "NEXT",
                      buttonWidth:MediaQuery.of(context).size.width*0.25,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
