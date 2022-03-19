import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapdash_admin/utils/appColors.dart';






class ButtonWidget extends StatelessWidget {
  ButtonWidget({ required this.buttonWidth , required this.name});
  double buttonWidth;
  String name;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: buttonWidth,
        height: 56,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 39),
        decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize:22,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ));
  }
}
