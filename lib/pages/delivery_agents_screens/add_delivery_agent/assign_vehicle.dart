import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/delivery_agents_screens/delivery_agents.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/my_vehicles.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class AssignVehicle extends StatefulWidget {
  const AssignVehicle({Key? key}) : super(key: key);

  @override
  State<AssignVehicle> createState() => _AssignVehicleState();
}

class _AssignVehicleState extends State<AssignVehicle> {
  File? insidePic;
  final picker = ImagePicker();
  void TakePhoto(ImageSource source, File imageFile) async {
    print("Image Picker");
    final pickerFile = await ImagePicker().pickImage(source: source);
    setState(() {
      insidePic = File(pickerFile!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 1,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              color: AppColors.bgpink,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 58.0,left: 70,right: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          InkWell(
                            onTap:(){
                              NavigationService().navigatePage(DeliveryAgents());
                            },
                            child: Text(
                              "Delivery Agents",
                              style: TextStyle(
                                  color:Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          VerticalDivider(
                            color: AppColors.black,
                            thickness: 1.25,
                          ),
                          Text(
                            "Add Delivery Agent - step 3",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          VerticalDivider(
                            color: AppColors.black,
                            thickness: 1.25,
                          ),
                          Text(
                            "Assign Vehicle",
                            style: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),


            Positioned(
              top: 180,
              left: 100,
              right: 100,
              child: Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  padding: EdgeInsets.only(left: 70,right: 90,top:90,bottom: 50),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            spreadRadius: 0,
                            color: Colors.black.withOpacity(0.4))
                      ]
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Assign Vehicle",style: TextStyle(color: AppColors.black,fontSize: 22,fontWeight: FontWeight.w600),),
                            Image.asset("assets/images/assignVehicle.png",
                              width: 270,),
                            Container(),

                          ],
                        ),
                        SizedBox(height: 120,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Brand/Vehicle Name",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 100,),

                                    DropDownWidget(Width: 460,),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Model Type",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 100,),

                                    DropDownWidget(Width: 460,),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Text("Model Number",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 100,),

                                    DropDownWidget(Width: 460,),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Engine Number",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 100,),

                                    Container(
                                      padding: EdgeInsets.only(left: 14, right: 14),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width*0.25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(4),
                                          color: AppColors.whitecolor,
                                          border: Border.all(color: AppColors.grey)
                                      ),
                                      child:TextField(
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        // controller: numberController,
                                        cursorColor: AppColors.appColor,
                                        // keyboardType: TextInputType.phone,
                                        //  inputFormatters: <TextInputFormatter>[
                                        //    FilteringTextInputFormatter.digitsOnly,
                                        //    LengthLimitingTextInputFormatter(20)
                                        //  ],
                                        decoration: InputDecoration(
                                          //hintText: "Search here",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[500]),
                                            border: InputBorder.none),
                                      ),

                                    ),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Chasis Number",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 100,),

                                    Container(
                                      padding: EdgeInsets.only(left: 14, right: 14),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width*0.25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(4),
                                          color: AppColors.whitecolor,
                                          border: Border.all(color: AppColors.grey)
                                      ),
                                      child:TextField(
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        // controller: numberController,
                                        cursorColor: AppColors.appColor,
                                        // keyboardType: TextInputType.phone,
                                        //  inputFormatters: <TextInputFormatter>[
                                        //    FilteringTextInputFormatter.digitsOnly,
                                        //    LengthLimitingTextInputFormatter(20)
                                        //  ],
                                        decoration: InputDecoration(
                                          //hintText: "Search here",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[500]),
                                            border: InputBorder.none),
                                      ),

                                    ),
                                  ],
                                ),
                                SizedBox(height: 30,),


                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Licence Plate",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 100,),

                                    Container(
                                      padding: EdgeInsets.only(left: 14, right: 14),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width*0.25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(4),
                                          color: AppColors.whitecolor,
                                          border: Border.all(color: AppColors.grey)
                                      ),
                                      child:TextField(
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        // controller: numberController,
                                        cursorColor: AppColors.appColor,
                                        // keyboardType: TextInputType.phone,
                                        //  inputFormatters: <TextInputFormatter>[
                                        //    FilteringTextInputFormatter.digitsOnly,
                                        //    LengthLimitingTextInputFormatter(20)
                                        //  ],
                                        decoration: InputDecoration(
                                          //hintText: "Search here",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[500]),
                                            border: InputBorder.none),
                                      ),

                                    ),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Provide Helmet",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 100,),

                                    DropDownWidget(Width: 460,),
                                  ],
                                ),





                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 80,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                NavigationService().pop();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 55,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.red)
                                ),
                                child: Text("Back",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.red),),
                              ),
                            ),
                            SizedBox(width: 100,),
                            InkWell(
                              onTap: (){
                                NavigationService().navigatePage(MyVehicles());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 55,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.red
                                ),
                                child: Text("Submit",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.whitecolor),),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ),
            ),

          ],
        )
    );
  }
}
