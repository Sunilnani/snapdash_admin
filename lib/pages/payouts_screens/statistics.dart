import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/pages/payouts_screens/payouts.dart';
import 'package:snapdash_admin/pages/payouts_screens/payouts_history.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {


  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 4,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  color: AppColors.bgpink,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100.0,left: 70,right: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Icon(Icons.water_damage_rounded,size: 20,),
                              SizedBox(width: 10,),
                              InkWell(
                                onTap:(){
                                  // TakePhoto(ImageSource.gallery,insidePic!);
                                },
                                child: Text(
                                  "Payouts",
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
                                "Statistics",
                                style: TextStyle(
                                    color: AppColors.appColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            NavigationService().navigatePage(PayOuts());
                          },
                          child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: AppColors.appColor,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                        spreadRadius: 0,
                                        color:AppColors.appColor)
                                  ]),
                              child: Center(
                                child:  Text("View Agent List",
                                    style: TextStyle(
                                      color: AppColors.whitecolor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    )),
                              )),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),


            Positioned(
              top: 180,
              left: 100,
              right: 100,
              bottom: 30,
              child: Container(
                height: MediaQuery.of(context).size.height*0.5,
                padding: EdgeInsets.only(top: 60,left: 100,right: 100),
                width: double.infinity,

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Overall Payroll Statistics",style: AppColors.titleRed,),
                          SizedBox(height: 30,),
                          Container(
                            height: MediaQuery.of(context).size.height*0.3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(0.4))
                                ]
                            ),
                          ),
                          SizedBox(height: 50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("View Statistics By",style:TextStyle(color: AppColors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                              SizedBox(width: 40,),
                              DropDownWidget(Width: 100),
                            ],
                          )
                        ],
                      ),
                    ),



                    Container(
                      height: MediaQuery.of(context).size.height*0.4,
                      width: 2,
                      color: AppColors.greylight,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Mostly Delivered Products",style: AppColors.titleRed,),
                          SizedBox(height: 30,),
                          Container(
                            height: MediaQuery.of(context).size.height*0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                      color: Colors.black.withOpacity(0.4))
                                ]
                            ),
                          ),
                          SizedBox(height: 30,),
                          Text("Overall Progress",style: AppColors.titleRed,),
                          SizedBox(height: 30,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                height: 120,
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                          color: Colors.black.withOpacity(0.4))
                                    ]
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.people_rounded,size: 20,color: Colors.blue,),
                                        Text("Total Users",style:AppColors.subheadingred,)
                                      ],
                                    ),
                                    SizedBox(height: 25,),
                                    Text("987668",style: AppColors.minblackSize,)
                                  ],
                                ),

                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                height: 120,
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                          color: Colors.black.withOpacity(0.4))
                                    ]
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.wallet_giftcard_outlined,size: 20,color: Colors.blue,),
                                        Text("Total Orders",style:AppColors.subheadingred,)
                                      ],
                                    ),
                                    SizedBox(height: 25,),
                                    Text("987668",style: AppColors.minblackSize,)
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

          ],
        )
    );
    
    

  }
}
