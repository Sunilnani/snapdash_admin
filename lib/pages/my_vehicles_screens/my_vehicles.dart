import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/vehicles_manager.dart';
import 'package:snapdash_admin/models/vehicles/vehicles_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/add_vehicles.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/view_vehicle_details.dart';
import 'package:snapdash_admin/utils/appColors.dart';
import 'package:snapdash_admin/utils/urls.dart';
class MyVehicles extends StatefulWidget {
  const MyVehicles({Key? key}) : super(key: key);

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {
  bool _fetching = false;

  //PastOrders? pastOrders;

  VechiclesList? vehicles;

  Future<void> _fetchVehicles() async {
    setState(() {
      _fetching = true;
    });
    try {
      final response = await vehicleManager.vehicles();

      if (response.status == ResponseStatus.SUCCESS) {
        Fluttertoast.showToast(msg: response.message);
        print("------->past ${(response.data as VechiclesList).toJson()}");
        setState(() {
          vehicles = response.data;
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

  bool _loading = false;

  Future<void> deleteVehicle(dynamic vehicleId ,int index) async {



    final data = {

      "vehicle_id":vehicleId,

    };

    setState(() {
      _loading = true;
    });

    final response = await vehicleManager.deleteVehicle(data);

    if (response.status == ResponseStatus.SUCCESS) {
      Fluttertoast.showToast(msg: response.message);
      setState(() {

        vehicles!.data.removeAt(index);
      });
      _fetchVehicles();

      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: response.message);
      print("---------------------##########${response.status}");

    }

    setState(() {
      _loading = false;
    });
  }



  Future<void> _openAddVehicle({MyVehiclesList? vehicle})async{
    await NavigationService().navigatePage(AddVehicle(vehicle:vehicle));
    await _fetchVehicles();

  }

var vehicleId;

  @override
  void initState() {
    // TODO: implement initState
    _fetchVehicles();
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
                padding: const EdgeInsets.only(bottom: 58.0,left: 70,right: 70),
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
                              "My vehicles",
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
                            "View Vehicles List",
                            style: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 14, right: 14),
                          height: 50,
                          width: MediaQuery.of(context).size.width*0.34,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.whitecolor,
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
                                hintText: "Search here",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[500]),
                                border: InputBorder.none),
                          ),

                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width*0.05,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.whitecolor,
                          ),
                          child: Text("Search",style: TextStyle(color: AppColors.red),),

                        ),

                        SizedBox(
                          width: 100,
                        ),
                        GestureDetector(
                          onTap: ()async{
                            // _openAddProduct();
                          await NavigationService().navigatePage(AddVehicle());
                          _fetchVehicles();

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
                                      Icons.add,
                                      size: 15,
                                      color: AppColors.whitecolor,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text("ADD Vehicle",
                                        style: TextStyle(
                                          color: AppColors.whitecolor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ],
                                ),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),


            Positioned(
              top: 180,
              left: 70,
              right: 70,
              child: Container(
                height: MediaQuery.of(context).size.height*0.7,
                clipBehavior: Clip.antiAliasWithSaveLayer,
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
                child:vehicles==null?CustomCircularProgressIndicator():Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.whitecolor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 10,
                            spreadRadius: 0,
                            color: Colors.black.withOpacity(0.3))
                      ]),

                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,

                    child: DataTable(
                      // columnSpacing: 38.0,
                      showCheckboxColumn: false,
                      dataRowHeight: 70,
                      headingRowColor: MaterialStateColor.resolveWith((states) {return AppColors.lightblue;},),
                      columns: [
                        DataColumn(label:Text('S.NO',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                        DataColumn(label: Text('Image',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                        DataColumn(label: Text('Brand Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                        DataColumn(label: Text('Model Type',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                        DataColumn(label: Text('Model Number',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                        DataColumn(label: Text('Licence Palte',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                        DataColumn(label: Text('Vehicle status',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                        DataColumn(label: Text('View',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                        DataColumn(label: Text('Actions',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      ],
                      rows: List.generate(vehicles!.data.length, (index) {
                        final sNO = index.toString();
                        final images=Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(URLS.parseImage(vehicles!.data[index].vehicleImage ?? "",
                                ),
                              ),

                            ),

                        ));
                        final image =CircleAvatar(
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(URLS.parseImage(vehicles!.data[index].vehicleImage ?? "")),
                        );
                        final brandName = vehicles!.data[index].vehicleName;
                        final modelType = vehicles!.data[index].modelType;
                        final modelNumber = vehicles!.data[index].modelNumber;
                        final licencePlate = vehicles!.data[index].licenceNumber;
                        final vehicleStatus = vehicles!.data[index].vehicleStatus;
                        final view = Icon(Icons.remove_red_eye_outlined);
                        final actions = Row(
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap:(){
                                                     _openAddVehicle(vehicle: vehicles!.data[index]);
                                                    },
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(4),
                                                          // border: Border.all(color: AppColors.red)
                                                          color: AppColors.red
                                                      ),
                                                      child:Icon(Icons.person_add_alt,color:AppColors.whitecolor,size: 18,),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20,),
                                                  InkWell(
                                                    onTap:(){
                                                     _show(index);

                                                    },
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(4),
                                                          border: Border.all(color: AppColors.grey)

                                                      ),
                                                      child: Icon(Icons.delete_forever,size: 18,),
                                                    ),
                                                  )
                                                ],
                                              );


                        return DataRow(
                            onSelectChanged: (bool){
                              // editvehicle:(){
                              //   _openAddVehicle(vehicle: vehicles!.data[index]);
                              // };
                              NavigationService().navigatePage(ViewVehicleDetails(vehicleId: vehicles!.data[index].vehicleId,));
                            },
                            cells: [
                              DataCell(
                                  Text(
                                    "${sNO}"
                                  )
                              ),

                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(4),
                                          color: AppColors.appColor),
                                      child: images

                                  ),
                                ),
                              ),

                              DataCell(
                                  Container( child: Text(brandName))),
                              DataCell(
                                  Container( child: Text(modelType))),

                              DataCell(Container( child: Text(modelNumber))),
                              DataCell(Container( child: Text(licencePlate))),
                              DataCell(Container( child:"${vehicleStatus}"=="0"?
                              Image.asset(
                                "assets/icons/Radio Button.png",
                                height: 50,
                                width: 50,
                              ):

                                  Image.asset(
                                     "assets/icons/notify_off.png",
                                     height: 50,
                                      width: 50,
                                     )

                              )
                        ),
                              DataCell(Container( child: view)),
                              DataCell(Center(child: Container( child: actions))),

                            ]);
                      }),
                    ),
                  ),


                ),
              ),
            ),
          ],
        )
    );
  }
  Future<void> _show(int index)async{
    return showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(10.0))),
          content: Builder(
            builder: (context) {

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 80,
                  width: 300,
                  child: Text('Remove the selected vehicles from list',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),

                ),
              );
            },
          ),
          actions: <Widget>[
            Center(
              child: Row(
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      NavigationService().pop();
                    },
                  ),
                  SizedBox(width: 50,),
                  TextButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      deleteVehicle(vehicles!.data[index].vehicleId, index);
                    },
                  ),

                ],
              )
            )
          ],
        )
    );
  }



}
