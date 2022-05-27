

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/active_areas_manager.dart';
import 'package:snapdash_admin/models/activeAreasModels/active_areas_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/pages/active_areas_screens/add_location.dart';
import 'package:snapdash_admin/utils/appColors.dart';

class ActiveAreas extends StatefulWidget {
  const ActiveAreas({Key? key}) : super(key: key);

  @override
  State<ActiveAreas> createState() => _ActiveAreasState();
}

class _ActiveAreasState extends State<ActiveAreas> {
  // GoogleMapController? mapController;
  // late BitmapDescriptor pinLocationIcon;
  // Marker? centerMapMarker;
  // LatLng _center = const LatLng(45.521563, -122.677433);
  // List<Marker> markersList = [];
  //
  // Future<void> setCustomMapPin() async {
  //   pinLocationIcon = await BitmapDescriptor.fromAssetImage(
  //       const ImageConfiguration(devicePixelRatio: 2.5,),
  //       'assets/images/rider_pin.png');
  // }
  //
  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  //   fetchLocation();
  // }
  //
  // double longtitude1=0.0;
  //
  // Future<void> fetchLocation() async {
  //   final locationData = await locationService.getLocation();
  //   if (locationData != null) {
  //     _center = LatLng(locationData.latitude!, locationData.longitude!);
  //
  //     await mapController?.moveCamera(CameraUpdate.newLatLng(_center));
  //     print("hbdhegvhcegvceg ----------${_center.latitude}");
  //
  //     longtitude1=_center.longitude;
  //     print(longtitude1);
  //
  //
  //     setState(() {
  //       centerMapMarker = Marker(
  //         icon: pinLocationIcon,
  //         markerId: const MarkerId("center"),
  //         position: _center,
  //       );
  //
  //     });
  //   } else {
  //     setState(() {
  //       _center = const LatLng(-1.286389, 36.817223);
  //       centerMapMarker = Marker(
  //         icon: pinLocationIcon,
  //         markerId: const MarkerId("center"),
  //         position: _center,
  //       );
  //     });
  //   }
  // }
  //


  String MAPBOX_ACCESS_TOKEN =
      "pk.eyJ1Ijoic3VuaWxuYW5pMTIzIiwiYSI6ImNsMXZycWxldTJ4cXEzY3Fyb2lleG45ZHcifQ.cXauWvxAkXFUZndm2a6GfA";

  late MapboxMapController mapController ;

  void _onMapCreated(MapboxMapController controller) {
    mapController=controller;
  }




  bool _fetching = false;



  ActiveAreasModel? activeAreas;

  Future<void> _fetchActiveAreas() async {
    setState(() {
      _fetching = true;
    });
    try {
      final response = await activeAreasManager.activeAreas();

      if (response.status == ResponseStatus.SUCCESS) {
        Fluttertoast.showToast(msg: response.message);
        print("------->Agents ${(response.data as ActiveAreasModel).toJson()}");
        setState(() {
          activeAreas = response.data;
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
var areas;
  var users;
  var orders;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchActiveAreas();
    // setCustomMapPin();
    // fetchLocation();
  }

  @override
  void dispose(){
    mapController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
      activeIndex: 5,
        child: Stack(
          children: [
            Positioned(
              top: 80,
              left: 70,
              right: 70,
              bottom: 70,
              child:activeAreas == null ? CustomCircularProgressIndicator():
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                padding: EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),

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
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.7,
                      width: MediaQuery.of(context).size.width*0.68,
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
                      child: MapboxMap(
                          accessToken: MAPBOX_ACCESS_TOKEN,
                          onMapCreated: _onMapCreated,
                          onStyleLoadedCallback: ()=>addCircle(mapController,activeAreas!.data),
                          initialCameraPosition:CameraPosition(
                              target: LatLng(17.51552054592745, 78.38667188230356),
                              zoom: 14
                          ),


                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            NavigationService().navigatePage(AddLocation());
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
                                child:  Text("Add Loocation",
                                    style: TextStyle(
                                      color: AppColors.whitecolor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    )),
                              )),
                        ),



                        SizedBox(height: 100,),


                        Container(
                          padding: EdgeInsets.all(15),
                          height: 70,
                          width: MediaQuery.of(context).size.width*0.18,
                         // width: 400,
                          decoration: BoxDecoration(
                              color: AppColors.whitecolor,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                    color:AppColors.grey)
                              ]),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on,color: AppColors.appColor,),
                                    SizedBox(width: 20,),
                                    Text("Total Active Areas",style:  TextStyle(color: AppColors.red,fontWeight: FontWeight.w600,fontSize: 20),)
                                  ],
                                ),
                                Text("${activeAreas!.data.length}",style: TextStyle(color: AppColors.red,fontWeight: FontWeight.w600,fontSize: 22),)
                              ],
                            ),
                          ),
                        ),


                        SizedBox(height: 30,),

                        Container(
                          padding: EdgeInsets.all(15),
                          height: 70,
                          width: MediaQuery.of(context).size.width*0.18,
                          // width: 400,
                          decoration: BoxDecoration(
                               color: AppColors.bgpinklight,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.red),
                              boxShadow: [
                                BoxShadow(

                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    color:AppColors.whitecolor)
                              ]),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on,color: AppColors.appColor,),
                                    SizedBox(width: 20,),
                                    Text("Total Added Areas",style:  TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 20),)
                                  ],
                                ),
                                Text("02",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 22),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          padding: EdgeInsets.only(top: 30,left: 30,right: 30,bottom: 20),
                          height: MediaQuery.of(context).size.height*0.25,
                          width: MediaQuery.of(context).size.width*0.18,
                          // width: 400,
                          decoration: BoxDecoration(
                              color: AppColors.whitecolor,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                    color:AppColors.grey)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              areas != null?Text("${areas}",style:TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.w600),):Text("-"),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                 users== null? Text("-"): Text("${users}",style:TextStyle(color: AppColors.black,fontSize: 22,fontWeight: FontWeight.w800),),

                                SizedBox(width: 10,),
                                  Text("Users",style:TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: 40,),
                              Text("Total Orders",style:TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.w800),),
                              SizedBox(height: 20,),
                              orders== null? Text("-"): Text("${orders}",style:TextStyle(color: AppColors.black,fontSize: 22,fontWeight: FontWeight.w800),),
                            ],
                          ),
                        ),

                      ],
                    ),

                    // if (centerMapMarker == null)
                    //   const Center(
                    //     child: CustomCircularProgressIndicator(),
                    //   )
                    // else
                    //   Container(
                    //     height:MediaQuery.of(context).size.height*0.4,
                    //     child: GoogleMap(
                    //       zoomControlsEnabled: false,
                    //       onMapCreated: _onMapCreated,
                    //       initialCameraPosition: const CameraPosition(
                    //         target: LatLng(-1.286389, 36.817223),
                    //         zoom: 15,
                    //       ),
                    //       onCameraMoveStarted: () {
                    //         print("started");
                    //       },
                    //       myLocationEnabled: true,
                    //       onCameraIdle: () {
                    //         print("idle");
                    //
                    //       },
                    //       // onCameraMove: (position) {
                    //       //   setState(() {
                    //       //     _center = position.target;
                    //       //     centerMapMarker = centerMapMarker!.copyWith(
                    //       //       positionParam: position.target,
                    //       //     );
                    //       //   });
                    //       // },
                    //       // markers: {centerMapMarker!, ...markersList},
                    //     ),
                    //   ), 
                  ],
                ),
              ),
            )
          ],
        )

    );
  }
void addCircle(MapboxMapController mapController, List<ActiveAreasList> areaList){
  mapController.onCircleTapped.add((argument) {
    print("circlrm tapped");
    print(argument.data);
    try {
    final  area = ActiveAreasList.fromJson(argument.data as Map<String, dynamic>);
   // final  user = ActiveAreasModel.fromJson(argument.data as Map<String, dynamic>);

    setState(() {
      areas = area.address;
      users=area.users;
      orders= area.totalorders;
      print("areas hebhc ${areas}");
    });

    }catch(err) {}
    print(argument.options.geometry);
  });
      areaList.forEach((ActiveAreasList area) {

        mapController.addCircle(
            CircleOptions(
              geometry: LatLng(double.parse(area.latitude),double.parse(area.longitude)),
              //geometry: LatLng(activeAreas!.data[0].latitude,activeAreas!.data[0].longitude),
              circleColor: "#23d2aa",
              circleRadius: 15,
            ),
          area.toJson()
        );
      });
}
}
