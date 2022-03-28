import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/users_screens/cancelled_orders.dart';
import 'package:snapdash_admin/pages/users_screens/placed_orders.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class ViewUser extends StatefulWidget {
  const ViewUser({Key? key}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 3,
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
                            "Users",
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
                            "Users",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          VerticalDivider(
                            color: AppColors.black,
                            thickness: 1.25,
                          ),
                          Text(
                            "View User",
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
                child: Column(
                  children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                     Row(
                       children: [
                         CircleAvatar(
                           radius: 55,
                           backgroundColor: Colors.yellow,
                         ),
                         SizedBox(width: 100,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Sunny",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                             SizedBox(height: 10,),
                             Text("ID: 123445",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.red),),
                           ],
                         )
                       ],
                     ),
                       InkWell(
                         onTap: (){
                           NavigationService().navigatePage(CancelledOrders());
                         },
                         child: Row(
                           children: [
                         Container(
                         decoration: BoxDecoration(
                         color: Colors.white,
                           shape: BoxShape.circle,
                           boxShadow: [
                             BoxShadow(
                                 blurRadius: 2,
                                 color:AppColors.grey,
                                 offset: Offset(0,1),
                                 spreadRadius: 2),

                           ],
                         ),
                          child: CircleAvatar(
                            radius: 20.0,
                           backgroundColor: Colors.white,
                            child: Text("25",style: TextStyle(color: AppColors.red,fontSize: 14,fontWeight: FontWeight.w500),),
                     ),
                      ),
                             SizedBox(width: 10,),
                             Text("Cancelled Orders",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.red),),
                             SizedBox(width: 10,),
                             Icon(Icons.arrow_forward_ios,color: AppColors.red,size: 20,)
                           ],
                         ),
                       ),
                       InkWell(
                         onTap: (){
                           NavigationService().navigatePage(PlacedOrders());
                         },
                         child: Row(
                           children: [
                             Container(
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 shape: BoxShape.circle,
                                 boxShadow: [
                                   BoxShadow(
                                       blurRadius: 2,
                                       color:AppColors.grey,
                                       offset: Offset(0,1),
                                       spreadRadius: 2),

                                 ],
                               ),
                               child: CircleAvatar(
                                 radius: 20.0,
                                 backgroundColor: AppColors.red,
                                 child: Text("25",style: TextStyle(color: AppColors.whitecolor,fontSize: 14,fontWeight: FontWeight.w500),),
                               ),
                             ),
                             SizedBox(width: 10,),
                             Text("View Placed Orders",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.red),),
                             SizedBox(width: 10,),
                             Icon(Icons.arrow_forward_ios,color: AppColors.red,size: 20,)
                           ],
                         ),
                       )
                     ],
                   )
                  ],
                ),
              ),
            ),

          ],
        )
    );
  }
}
