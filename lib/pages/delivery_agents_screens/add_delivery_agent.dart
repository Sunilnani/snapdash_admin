import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class AddDeliveryAgent extends StatefulWidget {
  const AddDeliveryAgent({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAgent> createState() => _AddDeliveryAgentState();
}

class _AddDeliveryAgentState extends State<AddDeliveryAgent> {
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
        activeIndex: 0,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              color: AppColors.bgpink,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 58.0,left: 30,right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            "Delivery Boys",
                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          VerticalDivider(
                            color: AppColors.appColor,
                            thickness: 1.25,
                          ),
                          Text(
                            "Add Delivery Agent",
                            style: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
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
                padding: EdgeInsets.only(left: 50,right: 50,top:40,bottom: 50),

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Profile Picture",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 55,
                                padding: EdgeInsets.only(left: 20,right: 20),
                                width: MediaQuery.of(context).size.width*0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.withOpacity(0.4))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Select File"),
                                    Row(
                                      children: [
                                        VerticalDivider(
                                          color: AppColors.grey,
                                          thickness: 1.25,
                                        ),
                                        SizedBox(width: 10,),
                                        InkWell(
                                          onTap: (){
                                            TakePhoto(ImageSource.gallery,insidePic!);
                                          },
                                            child: Text("Browse",style: TextStyle(color: AppColors.red,fontWeight: FontWeight.w600,fontSize: 14),))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text("Best Resolution 100px*100px")
                            ],
                          ),
                          insidePic == null?
                          CircleAvatar(
                            radius: 45,
                            backgroundColor:Colors.grey.withOpacity(0.3),
                          ): Container(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(
                                  insidePic!,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("First Name",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("Last Name",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("Date of Birth",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("Mobile Number",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("Email Id",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("Street",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("City",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Vehicle Class",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("Make/Made",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("Registration Number",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("Registration Upto",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("Bike Number",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  Text("RC Number",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 80,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.red)
                            ),
                            child: Text("Cancel",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.red),),
                          ),
                          SizedBox(width: 100,),
                          Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                               color: AppColors.red
                            ),
                            child: Text("Submit",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.whitecolor),),
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
