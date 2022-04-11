import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/vehicles_manager.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/appColors.dart';
import 'package:snapdash_admin/utils/custom_date.dart';
class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {

  File? insidePic;
  final picker = ImagePicker();
  void TakePhoto() async {
    print("Image Picker");
    final pickerFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      insidePic = File(pickerFile!.path);
    });
  }
  bool _loading = false;
  DateTime? _date;
  String? _formatteDate;
  String? registrationFormatUptoDate;
  DateTime? registrationUptoDate;
  String? pollutionValidFormat;
  DateTime? pollutionValidDate;


  final modelNumberController = TextEditingController();
  final modelTypeController = TextEditingController();
  final nameController = TextEditingController();
  final licenceNumberController = TextEditingController();
  final engineNumberController = TextEditingController();
  final chasisNumberController = TextEditingController();
  final insuranceNumberController = TextEditingController();
  final dobController = TextEditingController();
  final pollutionValidController = TextEditingController();

  Future<void> addNewVehicle() async {

    final name = nameController.text.trim();
    final modelType=modelTypeController.text.trim();
    final modelNumber=modelNumberController.text.trim();
    final licenceNumber=licenceNumberController.text.trim();
    final engineNumber=engineNumberController.text.trim();
    final chasisNumber=chasisNumberController.text.trim();
    final insuranceNumber=insuranceNumberController.text.trim();
    final pollutionValid=pollutionValidController.text.trim();


     if(name.isEmpty){
       Fluttertoast.showToast(msg: "please enter name");
       return;
     }
    if(modelType.isEmpty){
      Fluttertoast.showToast(msg: "please enter modeltype");
      return;
    }
    if(licenceNumber.isEmpty){
      Fluttertoast.showToast(msg: "please enter licence number");
      return;
    }
    if(engineNumber.isEmpty){
      Fluttertoast.showToast(msg: "please engine number");
      return;
    }
    if(chasisNumber.isEmpty){
      Fluttertoast.showToast(msg: "please chasis number");
      return;
    }
    if(name.isEmpty){
      Fluttertoast.showToast(msg: "please enter name");
      return;
    }
    if(insidePic!.path.isEmpty){
      Fluttertoast.showToast(msg: "please enter name");
      return;
    }

    final data = {
      "name":name,
      "model_type":modelType,
      "model_number":modelNumber,
      "licence_number":licenceNumber,
      "engine_number":engineNumber,
      "chassis_number":chasisNumber,
      "insurance_number":insuranceNumber,
      "registration_date":CustomDate().formatServerDate(_date!),
      "pollution_valid_upto":CustomDate().formatServerDate(registrationUptoDate!),

      "pollution_valid_upto":CustomDate().formatServerDate(pollutionValidDate!),

      // "image": await MultipartFile.fromFile(
      //   insidePic!.path,
      // ),
     "image": MultipartFile.fromBytes(insidePic!.readAsBytesSync())

    };

    // if(insidePic != null){
    //  data["image"] = await MultipartFile.fromFile(insidePic!.path);
    // }

    setState(() {
      _loading = true;
    });

    final response = await vehicleManager.addVehicle(data);

    if (response.status == ResponseStatus.SUCCESS) {
      // ToastUtils().showToast(response.message);
      Fluttertoast.showToast(msg: response.message);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: response.message);
      // ToastUtils().showToast(response.message);
    }

    setState(() {
      _loading = false;
    });
  }


  // File? _image;
  // // final picker = ImagePicker();
  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   //File image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected');
  //     }
  //   });
  // }

@override
  void initState() {
    // TODO: implement initState
    super.initState();

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
                          InkWell(
                            onTap: (){
                              NavigationService().pop();
                            },
                            child: Text(
                              "My Vehicles",
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
                              TakePhoto();
                            },
                            child: Text(
                              "Add Vehicle",
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
                                      InkWell(
                                        onTap:(){
                                          //getImage();
                                          //Fluttertoast.showToast(msg: "Hello");
                                          //TakePhoto(ImageSource.gallery,insidePic!);
                                        },
                                          child: Text("Select File")),
                                      Row(
                                        children: [
                                          VerticalDivider(
                                            color: AppColors.grey,
                                            thickness: 1.25,
                                          ),
                                          SizedBox(width: 10,),
                                          InkWell(
                                              onTap: (){
                                                setState(() {
                                                  TakePhoto();
                                                });
                                                //TakePhoto(ImageSource.gallery,insidePic!);
                                                Fluttertoast.showToast(msg: "Hello");
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
                                  // child: Image.file(
                                  //   insidePic!,
                                  //  // _image!,
                                  //   fit: BoxFit.cover,
                                  // )
                                // child: Image.asset(insidePic!.path),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Brand Name",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                         controller: nameController,
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
                                    Text("Model Type",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                         controller: modelTypeController,
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
                                    Text("Model Number",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                         controller: modelNumberController,
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
                                        controller: licenceNumberController,
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
                                         controller: engineNumberController,
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
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
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
                                         controller: chasisNumberController,
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
                                    Text("Registration Date",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 100,),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width*0.25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(4),
                                          color: AppColors.whitecolor,
                                          border: Border.all(color: AppColors.grey)
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1884),
                                                    lastDate: DateTime(2023))
                                                    .then((date) {
                                                  setState(() {
                                                    _date = date;
                                                    _formatteDate = new DateFormat.yMd()
                                                        .format(_date!);
                                                  });
                                                });
                                              },
                                              icon: Icon(
                                                Icons.calendar_today,
                                                color: AppColors.appColor,
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              _date == null
                                                  ? "Date of Birth "
                                                  : _formatteDate!,
                                              style: _date == null
                                                  ? TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[500],
                                              )
                                                  : TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    // Container(
                                    //   padding: EdgeInsets.only(left: 14, right: 14),
                                    //   height: 50,
                                    //   width: MediaQuery.of(context).size.width*0.25,
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.rectangle,
                                    //       borderRadius: BorderRadius.circular(4),
                                    //       color: AppColors.whitecolor,
                                    //       border: Border.all(color: AppColors.grey)
                                    //   ),
                                    //   child:TextField(
                                    //     style: TextStyle(
                                    //       fontSize: 18,
                                    //       fontWeight: FontWeight.w600,
                                    //     ),
                                    //     // controller: numberController,
                                    //     cursorColor: AppColors.appColor,
                                    //     // keyboardType: TextInputType.phone,
                                    //     //  inputFormatters: <TextInputFormatter>[
                                    //     //    FilteringTextInputFormatter.digitsOnly,
                                    //     //    LengthLimitingTextInputFormatter(20)
                                    //     //  ],
                                    //     decoration: InputDecoration(
                                    //       //hintText: "Search here",
                                    //         hintStyle: TextStyle(
                                    //             fontSize: 14,
                                    //             fontWeight: FontWeight.w500,
                                    //             color: Colors.grey[500]),
                                    //         border: InputBorder.none),
                                    //   ),
                                    //
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Registration Upto",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 100,),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width*0.25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(4),
                                          color: AppColors.whitecolor,
                                          border: Border.all(color: AppColors.grey)
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1884),
                                                    lastDate: DateTime(2023))
                                                    .then((date) {
                                                  setState(() {
                                                    registrationUptoDate = date;
                                                    registrationFormatUptoDate = new DateFormat.yMd()
                                                        .format(registrationUptoDate!);
                                                  });
                                                });
                                              },
                                              icon: Icon(
                                                Icons.calendar_today,
                                                color: AppColors.appColor,
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              registrationUptoDate == null
                                                  ? "Date of Birth "
                                                  : registrationFormatUptoDate!,
                                              style: registrationUptoDate == null
                                                  ? TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[500],
                                              )
                                                  : TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Vehicle Insurance Number",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                         controller: insuranceNumberController,
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
                                    Text("Pollution Valid",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 100,),

                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width*0.25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(4),
                                          color: AppColors.whitecolor,
                                          border: Border.all(color: AppColors.grey)
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1884),
                                                    lastDate: DateTime(2023))
                                                    .then((date) {
                                                  setState(() {
                                                    pollutionValidDate = date;
                                                    pollutionValidFormat = new DateFormat.yMd()
                                                        .format(pollutionValidDate!);
                                                  });
                                                });
                                              },
                                              icon: Icon(
                                                Icons.calendar_today,
                                                color: AppColors.appColor,
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              pollutionValidDate == null
                                                  ? "Date of Birth "
                                                  : pollutionValidFormat!,
                                              style: pollutionValidDate == null
                                                  ? TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[500],
                                              )
                                                  : TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
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
                                addNewVehicle();
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
