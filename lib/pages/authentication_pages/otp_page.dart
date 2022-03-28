import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/button_widget.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/auth_manager.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/pages/delivery_agents_screens/delivery_agents.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/my_vehicles.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class OTPScreen extends StatefulWidget {
  OTPScreen({required this.number});

  final String number;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _loading = false;

  late Timer? _timer;
  int _start = 30;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        _timer = timer;
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }


  final passwordController = TextEditingController();
  final numberController = TextEditingController();




  Future<void> performLogin() async {

    setState(() {
      _loading = true;
    });

    final response = await authManager.performLogin(widget.number);

    setState(() {
      _loading = false;
    });

    if (response.status == ResponseStatus.SUCCESS) {
      Fluttertoast.showToast(msg: "OTP sent");
      setState(() {
        _start = 30;
      });
      startTimer();
    } else {
      Fluttertoast.showToast(msg: response.message);
    }
  }



  Future<void> verifyotp() async {
    //String name = numberController.text.trim();
    String pass = passwordController.text.trim();
    if (pass.isEmpty) {
      Fluttertoast.showToast( msg:"enter details");
      return;
    }

    setState(() {
      _loading = true;
    });

    final response = await authManager.verifyOTP(widget.number, pass);

    print("responses are ${response.data}");

    setState(() {
      _loading = false;
      print("responses are ${response.data}");
    });
    print("responses are ${response.data}");


    if (response.status == ResponseStatus.SUCCESS) {

      Fluttertoast.showToast(msg:response.message);

      NavigationService().navigatePage(MyVehicles(),replaceAll: true);
      // NavigationService().navigatePage(HomePage());
    } else {
      Fluttertoast.showToast(msg:response.message);
    }
  }


  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                      height: 150,width: 150,)
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ENTER OTP",
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
                                   controller: passwordController,
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
                    SizedBox(
                      height: 10,
                    ),
                    _start == 0? InkWell(
                      onTap: () {
                        // performLogin();
                      },
                      child: Text(
                          "Resend otp" ),
                    ): Text(
                        "Resend otp in ${_start.toString()} sec"),

                  ],
                ),


                SizedBox(height: 150),
                _loading?CustomCircularProgressIndicator():

                InkWell(
                    onTap: () {
                      verifyotp();
                      // performLogin();
                      //NavigationService().navigatePage(DeliveryAgents());
                    },
                    child: ButtonWidget(
                      name: "Login",
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
