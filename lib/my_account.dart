import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return  BaseHomePage(
        //activeIndex: 0,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              color: AppColors.bgpink,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 58.0,left: 50,right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Icon(Icons.water_damage_rounded,size: 18,),
                          SizedBox(width: 10,),
                          Text(
                            "Account",
                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          VerticalDivider(
                            color: AppColors.black,
                            thickness: 1.25,
                          ),
                          Text(
                            "Add Profile",
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
              left: 150,
              right: 150,
              child: Container(
                height: MediaQuery.of(context).size.height*0.7,
                padding: EdgeInsets.only(left: 70,right: 60,top:40,bottom: 30),

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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 80,
                                backgroundColor: AppColors.bgpink,
                              ),
                              SizedBox(height: 30,),
                              Text("Sunny VJ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22,color: AppColors.black),),
                              SizedBox(height: 15,),
                              Text("ID : 1234445",style: TextStyle(fontWeight: FontWeight.w600,fontSize:16,color:Colors.deepPurpleAccent.withOpacity(0.7)),),

                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First Name",style: TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                              SizedBox(height: 10,),

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
                              SizedBox(height: 25,),
                              Text("Last Name",style: TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                              SizedBox(height: 10,),

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
                              SizedBox(height: 25,),


                              Text("Mobile Number",style: TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                              SizedBox(height: 10,),
                              Container(
                                //margin: EdgeInsets.only(top: 40),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                height: 60,
                                width: MediaQuery.of(context).size.width*0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1, color: Colors.grey)),
                                child: Center(
                                  child: Row(
                                    children: [
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
                                      Container(
                                        height: 60,
                                        color: AppColors.black,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: TextField(
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                           // controller: numberController,
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
                              SizedBox(height: 25,),
                              Text("Email ID",style: TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                              SizedBox(height: 10,),

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
                              SizedBox(height: 25,),
                              Text("Address",style: TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                              SizedBox(height: 10,),

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

                      SizedBox(
                        height: 80,
                      ),
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
                          SizedBox(width: 80,),
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
