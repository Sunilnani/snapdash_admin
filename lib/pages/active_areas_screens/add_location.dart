import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/active_areas_manager.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final modelNumberController = TextEditingController();
  final coordinatesController = TextEditingController();
  final addressController = TextEditingController();
  final licenceNumberController = TextEditingController();
  final engineNumberController = TextEditingController();
  final chasisNumberController = TextEditingController();
  final insuranceNumberController = TextEditingController();
  final dobController = TextEditingController();
  final pollutionValidController = TextEditingController();
  final vehicleStatusController=TextEditingController();



  bool _loading = false;

  Future<void> addNewLocation() async {

    final address = addressController.text.trim();
    final coordinates=coordinatesController.text.trim();
    final modelNumber=modelNumberController.text.trim();
    final licenceNumber=licenceNumberController.text.trim();
    final engineNumber=engineNumberController.text.trim();
    final chasisNumber=chasisNumberController.text.trim();
    final insuranceNumber=insuranceNumberController.text.trim();
    final vehicleStatus=vehicleStatusController.text.trim();


    // if(name.isEmpty){
    //   Fluttertoast.showToast(msg: "please enter name");
    //   return;
    // }


    final data = {
      "address":address,
      "location":"SRID=4326;POINT (${coordinates})",


    };

    // if(insidePic != null){
    //  data["image"] = await MultipartFile.fromFile(insidePic!.path);
    // }

    setState(() {
      _loading = true;
    });

    final response = await activeAreasManager.addLocation(data);

    if (response.status == ResponseStatus.SUCCESS) {
      // ToastUtils().showToast(response.message);
      Fluttertoast.showToast(msg: response.message);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: response.message);
      // ToastUtils().showToast(response.message);
      print("---------------------00000000000000000${response.status}");
      print("---------------------****${response.message}");
      print("---------------------@@@${response.data}");
    }

    setState(() {
      _loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 4,
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
                          InkWell(
                            onTap: (){
                              NavigationService().pop();
                            },
                            child: Text(
                              "Active Areas",
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
                          InkWell(
                            onTap: (){
                              //TakePhoto();
                            },
                            child: Text(
                              "Add Location",
                              style: TextStyle(
                                  color: AppColors.appColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
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
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Location Name",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        controller: addressController,
                                        cursorColor: AppColors.appColor,
                                        keyboardType: TextInputType.name,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.singleLineFormatter,
                                          LengthLimitingTextInputFormatter(15)
                                        ],
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
                                    Text("Location Coordinates",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        controller: coordinatesController,
                                        cursorColor: AppColors.appColor,
                                        keyboardType: TextInputType.name,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.singleLineFormatter,
                                          LengthLimitingTextInputFormatter(15)
                                        ],
                                        decoration: InputDecoration(
                                          hintText: " enter latitude longitude",
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
                                    Text("Area",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                       // controller: modelNumberController,
                                        cursorColor: AppColors.appColor,
                                        keyboardType: TextInputType.multiline,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(15)
                                        ],
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
                                       // controller: licenceNumberController,
                                        cursorColor: AppColors.appColor,
                                        // keyboardType: TextInputType.phone,
                                        inputFormatters: <TextInputFormatter>[
                                          // FilteringTextInputFormatter.singleLineFormatter,
                                          LengthLimitingTextInputFormatter(10)
                                        ],
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
                                    Text("State",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                       // controller: engineNumberController,
                                        cursorColor: AppColors.appColor,
                                      //  keyboardType: TextInputType.emailAddress,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.singleLineFormatter,
                                          LengthLimitingTextInputFormatter(10)
                                        ],
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
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Country",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        //controller: chasisNumberController,
                                        cursorColor: AppColors.appColor,
                                        // keyboardType: TextInputType.phone,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(20)
                                        ],
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
                                    Text("PinCode",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                        //controller: chasisNumberController,
                                        cursorColor: AppColors.appColor,
                                        // keyboardType: TextInputType.phone,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(20)
                                        ],
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
                            InkWell(
                              onTap: (){
                                //updateVehicle();
                                // addNewVehicle();
                                addNewLocation();
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
