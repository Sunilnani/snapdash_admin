import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/user_managers.dart';
import 'package:snapdash_admin/models/users_models/user_details_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/pages/users_screens/cancelled_orders.dart';
import 'package:snapdash_admin/pages/users_screens/placed_orders.dart';
import 'package:snapdash_admin/utils/appColors.dart';
import 'package:snapdash_admin/utils/custom_date.dart';
import 'package:snapdash_admin/utils/urls.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class ViewUser extends StatefulWidget {
  ViewUser({required this.userId});
  final int? userId;

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {



  UserDetailsModel? userDetails;
  bool _fetching=false;
  var address;

  Future<void> _fetchUserDetails() async {
    setState(() {
      _fetching = true;
    });
    print("..........responsed");
    print("-------->order id is  here ${widget.userId}");
    final response = await userManager.fetchUserDetail(widget.userId);
   // print((response.data as UserDetailsModel).toJson());
    print(response.data);
    setState(() {
      _fetching = false;
    });

    print("-------->order id is  here ${widget.userId}");
    if (response.status == ResponseStatus.SUCCESS) {
      Fluttertoast.showToast(msg: response.message);
      setState(() {
        userDetails = response.data;
      });
      print("003");

      if(userDetails!.address != null){

        setState(() {
          address = userDetails!.address.split(",");
          //deliveryAddress=orderDetails!.deliveryAddress.split(",");
        });
      }
      print("004");

      // print(orderDetails?.OrderDetails?.productImages);
    } else {
      Fluttertoast.showToast(msg: response.message);
    }
    print("005");

  }

  static final List<WorldPopulation> populationData=[
    WorldPopulation(year: 0, population: 10, barcolor: Colors.red),
    WorldPopulation(year: 1, population: 20, barcolor: Colors.pink),
    WorldPopulation(year: 2, population: 30, barcolor: Colors.yellow),
    WorldPopulation(year: 3, population: 40, barcolor: Colors.green),
    WorldPopulation(year: 3, population: 50, barcolor: Colors.green),
  ];

  @override
  void initState() {
    // TODO: implement initState
    print("001");
    _fetchUserDetails();

    print("002");

  }
  @override
  Widget build(BuildContext context) {

    List<charts.Series<WorldPopulation, int>> series=[

      charts.Series(
          data: populationData,
          id: "world population",
          domainFn: (WorldPopulation pops,_)=>pops.year,
          measureFn:  (WorldPopulation pops,_)=>pops.population,
          colorFn:  (WorldPopulation pops,_)=>charts.ColorUtil.fromDartColor(pops.barcolor)
      )
    ];
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
                          InkWell(
                            onTap: (){
                              NavigationService().pop();
                            },
                            child: Text(
                              "Users",
                              style: TextStyle(
                                  color:Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          VerticalDivider(
                            color: AppColors.black,
                            thickness: 1.25,
                          ),
                          // Text(
                          //   "Users",
                          //   style: TextStyle(
                          //       color: AppColors.black,
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.w400),
                          // ),
                          // VerticalDivider(
                          //   color: AppColors.black,
                          //   thickness: 1.25,
                          // ),
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
              child: userDetails == null ? CustomCircularProgressIndicator():Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  padding: EdgeInsets.only(bottom: 30),

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



                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 220,
                          padding: EdgeInsets.only(left: 100,right: 100,),
                          decoration: BoxDecoration(
                              color: AppColors.whitecolor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                    color: Colors.black.withOpacity(0.4))
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (userDetails!.image==null) SizedBox() else Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                        image:  DecorationImage(
                                          fit: BoxFit.fill,
                                          image: CachedNetworkImageProvider(URLS.parseImage(userDetails!.image ?? "",
                                          ),
                                          ),

                                        ),

                                      )),
                                  // CircleAvatar(
                                  //   radius: 55,
                                  //   backgroundColor: Colors.yellow,
                                  //   child: CachedNetworkImageProvider(URLS.parseImage(vehicles!.data[index].vehicleImage ?? "",
                                  // ),
                                  SizedBox(width: 100,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(userDetails!.userName??"no name",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                                      SizedBox(height: 10,),
                                      Text("ID: ${userDetails!.userId}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.red),),
                                    ],
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  NavigationService().navigatePage(CancelledOrders(userId: userDetails!.userId,));
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
                                        child: Text("${userDetails!.ordersCancelled}",style: TextStyle(color: AppColors.red,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                  NavigationService().navigatePage(PlacedOrders(userId: userDetails!.userId,));
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
                                        child: Text("${userDetails!.ordersPlaced}",style: TextStyle(color: AppColors.whitecolor,fontSize: 14,fontWeight: FontWeight.w500),),
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
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(top: 40,left: 100,right: 100),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                //width: MediaQuery.of(context).size.width*0.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("User Details",style: AppColors.titleRed,),
                                    SizedBox(height: 25,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("User Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        Text(userDetails!.userName??"No Name",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    SizedBox(height: 20,),

                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text("Email ID",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    //     Text("sunil@123",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    //   ],
                                    // ),
                                    // SizedBox(height: 20,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Date of Birth",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        Text(CustomDate().formatServerDate(userDetails!.created??DateTime.now()),style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    SizedBox(height: 20,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Mobbile Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        Text("${userDetails!.phoneNumber}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Area",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        Text("${address[0]}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    SizedBox(height: 20,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Street",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        //Text("${address[1]}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    SizedBox(height: 20,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("City",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                       // Text("${address[2]}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      ],
                                    ),


                                  ],
                                ),
                              ),
                              SizedBox(width: 150,),

                              Expanded(
                               // w//idth: MediaQuery.of(context).size.width*0.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("View Statistics",style: AppColors.titleRed,),
                                    SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        Text("Total Orders Placed",style: AppColors.minblackSize,),
                                        SizedBox(width: 40,),
                                        DropDownWidget(Width: 150,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 25,),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      height: 250,
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
                                      child: charts.LineChart(series),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ),
            ),

          ],
        )
    );
  }
}
class WorldPopulation{
  final int  year;
  final int population;
  final Color barcolor;
  WorldPopulation({required this.year,required this.population,required this.barcolor});

}