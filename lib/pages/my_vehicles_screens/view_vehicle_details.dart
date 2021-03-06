import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/vehicles_manager.dart';
import 'package:snapdash_admin/models/vehicles/vehicle_details_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/appColors.dart';
import 'package:snapdash_admin/utils/urls.dart';

class ViewVehicleDetails extends StatefulWidget {
  final int vehicleId;
  ViewVehicleDetails({required this.vehicleId});

  @override
  State<ViewVehicleDetails> createState() => _ViewVehicleDetailsState();
}

class _ViewVehicleDetailsState extends State<ViewVehicleDetails> {
 bool  _fetching = false;
 VehicleDetails? vehicleDetails;

  Future<void> _fetchVehicleDetails() async {
    setState(() {
      _fetching = true;
    });
    try {
      final response = await vehicleManager.fetchVehicleDetail(widget.vehicleId);

      if (response.status == ResponseStatus.SUCCESS) {
        Fluttertoast.showToast(msg: response.message);
        print("------->past ${(response.data).toJson()}");
        setState(() {
          vehicleDetails = response.data;
        });
        setState(() {
          _fetching=false;
        });
      } else {
        Fluttertoast.showToast(msg: response.message);
      }
    } catch (err) {
      print(err);
      // run now once
      setState(() {
        _fetching = false;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchVehicleDetails();
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
                          Icon(Icons.water_damage_rounded,size: 20,),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap: (){
                              NavigationService().pop();
                            },
                            child: Text(
                              "My Vehicles",
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
                          Text(
                            "View Vehicle Details",
                            style: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 90.0),
                      child: GestureDetector(
                        onTap: (){
                          // _openAddProduct();
                          // NavigationService().navigatePage(AddDeliveryAgent());
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
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_circle_down_sharp,
                                    size: 18,
                                    color: AppColors.whitecolor,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text("DOWNLOAD PDF",
                                      style: TextStyle(
                                        color: AppColors.whitecolor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            )),
                      ),
                    )

                  ],
                ),
              ),
            ),


            Positioned(
              top: 180,
              left: 120,
              right: 120,
              child:vehicleDetails ==null?CustomCircularProgressIndicator(): Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  padding: EdgeInsets.only(bottom: 50,),

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 220,
                            padding: EdgeInsets.only(top: 20,left: 100,right: 100),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: CachedNetworkImageProvider(URLS.parseImage(vehicleDetails!.image ?? "")),
                                    ),
                                    SizedBox(width: 30,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${vehicleDetails!.vehicleName}",style:AppColors.headingstyle,),
                                        SizedBox(height: 10,),
                                        Text("Licence Plate No: ${vehicleDetails!.vehicleId}",style: AppColors.subheadingred,)
                                      ],
                                    )
                                  ],
                                ),
                                // Container(
                                //   alignment: Alignment.center,
                                //   height: 50,
                                //   width: 100,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(4),
                                //       border: Border.all(color: AppColors.red)
                                //   ),
                                //   child: Text("Edit Vehicle",style: TextStyle(color: AppColors.red,fontSize: 14,fontWeight: FontWeight.w500),),
                                // )
                              ],
                            ),
                          ),


                          Container(
                            padding: EdgeInsets.only(top: 60,left: 100,right: 100),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  width: MediaQuery.of(context).size.width*0.3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Brand Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text(vehicleDetails!.vehicleName,style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Model Type",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text("${vehicleDetails!.modelType}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Model No",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text("${vehicleDetails!.modelNumber}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Licence Plate",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text("${vehicleDetails!.licenceNumber}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Engine Details",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text("123G7465hc",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Chasis Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text("${vehicleDetails!.chassisNumber}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Vehicle Status",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text("${vehicleDetails!.vehicleStatus}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),

                                Container(
                                  height: 300,
                                  width: 2,
                                  color: AppColors.greylight,
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width*0.3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Registration Date",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text("${(vehicleDetails!.registrationDate)}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Registration Upto",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text("${vehicleDetails!.registrationUpto}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Insurance Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text("${vehicleDetails!.insuranceNumber}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Pollution Valid",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                          Text("${vehicleDetails!.pollutionValidUpto}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 15,),




                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      )


                    ],
                  )
              ),
            ),

          ],
        )
    );
  }
}
