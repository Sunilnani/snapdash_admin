import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/agents_manager.dart';
import 'package:snapdash_admin/managers/vehicles_manager.dart';
import 'package:snapdash_admin/models/agentsModels/agent_list_model.dart';
import 'package:snapdash_admin/models/vehicles/vehicles_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/pages/delivery_agents_screens/add_delivery_agent/add_agent_bank_details.dart';
import 'package:snapdash_admin/pages/delivery_agents_screens/delivery_agents.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/my_vehicles.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/utils/appColors.dart';
import 'package:snapdash_admin/utils/custom_date.dart';
class AddDeliveryAgent extends StatefulWidget {

   AddDeliveryAgent({this.agentData});
   MyAgentsList? agentData;

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





  Map<String, dynamic> pageOneData = <String, dynamic>{};
  Map<String, dynamic> pageTwoData = <String, dynamic>{};
  Map<String, dynamic> pageThreeData = <String, dynamic>{};
  final _pageController = PageController(initialPage: 0,keepPage: true);

  _submitData() async {
    final Map<String, dynamic> data = {
      ...pageOneData,
      ...pageTwoData,
      ...pageThreeData
    };
    print(data);
    // if(name.isEmpty){
    //   Fluttertoast.showToast(msg: "please enter name");
    //   return;
    // }


    // if(insidePic != null){
    //  data["image"] = await MultipartFile.fromFile(insidePic!.path);
    // }

    setState(() {
      _loading = true;
    });

    final response = await agentManager.addAgent(data);

    if (response.status == ResponseStatus.SUCCESS) {
      // ToastUtils().showToast(response.message);
      Fluttertoast.showToast(msg: response.message);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: response.message);
      // ToastUtils().showToast(response.message);
      print("---------------------00000000000000000${response.status}");
      print("---------------------****${response.message}");
    }

    setState(() {
      _loading = false;
    });
  }

  _editData() async {
    final Map<String, dynamic> data = {
      ...pageOneData,
      ...pageTwoData,
      ...pageThreeData,
      "agent_id":widget.agentData!.deliveryAgentId
    };
    print(data);
    // if(name.isEmpty){
    //   Fluttertoast.showToast(msg: "please enter name");
    //   return;
    // }


    // if(insidePic != null){
    //  data["image"] = await MultipartFile.fromFile(insidePic!.path);
    // }

    setState(() {
      _loading = true;
    });

    final response = await agentManager.updateAgent(data);

    if (response.status == ResponseStatus.SUCCESS) {
      // ToastUtils().showToast(response.message);
      Fluttertoast.showToast(msg: response.message);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: response.message);
      // ToastUtils().showToast(response.message);
      print("---------------------00000000000000000${response.status}");
      print("---------------------****${response.message}");
    }

    setState(() {
      _loading = false;
    });
  }

  bool _loading= false;
  bool isEdit = false;

  void _checkIfEdit(){
    if(widget.agentData != null){
      setState(() {
        isEdit = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    _checkIfEdit();
  }


  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 1,
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            AddAgentDetails(onNext: (Map<String, dynamic> data) {
              pageOneData = data;
              _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInOutSine);
            },
              agentList:widget.agentData
            ),
            AddAgentBankDetails(onNext: (Map<String, dynamic> data) {
              pageTwoData = data;
              _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInOutSine);
            },
              agentBankData: widget.agentData,

            ),
            AssignVehicle(onNext: (Map<String, dynamic> data) {
              pageThreeData = data;
              isEdit?_editData():_submitData();
            },
              agentdetails: widget.agentData,
            ),
          ],
        ),
    );
  }

}



class AddAgentDetails extends StatefulWidget {
   AddAgentDetails({Key? key, required this.onNext,  this.agentList}) ;
 final Function(Map<String, dynamic>) onNext;
 MyAgentsList? agentList;

  @override
  State<AddAgentDetails> createState() => _AddAgentDetailsState();
}

class _AddAgentDetailsState extends State<AddAgentDetails> {
  XFile? insidePic;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        insidePic = pickedFile;
      } else {
        print('No image selected');
      }
    });
  }


  final emailIdController = TextEditingController();
  final nameController = TextEditingController();
  final mobileNumberController= TextEditingController();
  final cityController = TextEditingController();
  final stateController= TextEditingController();
  final streetController = TextEditingController();
  final areaController= TextEditingController();

  _goNext() async {
    String area= areaController.text.trim();
    String street =streetController.text.trim();
    String city=cityController.text.trim();
    String state=stateController.text.trim();
    String emailID=emailIdController.text.trim();
    String name= nameController.text.trim();
    String mobileNumber= mobileNumberController.text.trim();

    if(name.isEmpty){
      Fluttertoast.showToast(msg: "please enter name");
      return;
    }
    if(mobileNumber.isEmpty){
      Fluttertoast.showToast(msg: "please enter mobile number");
      return;
    }
    if(emailID.isEmpty){
      Fluttertoast.showToast(msg: "please enter email");
      return;
    }
    if(area.isEmpty){
      Fluttertoast.showToast(msg: "please enter area");
      return;
    }
    if(street.isEmpty){
    Fluttertoast.showToast(msg: "please enter street");
    return;
    }
    if(city.isEmpty){
    Fluttertoast.showToast(msg: "please enter city");
    return;
    }
    if(state.isEmpty){
      Fluttertoast.showToast(msg: "please enter state");
      return;
    }
    if(_date==null){
      Fluttertoast.showToast(msg: "please enter date");
      return;
    }
    if(insidePic!.path.isEmpty){
      Fluttertoast.showToast(msg: "please select image");
      return;
    }


    Map<String, dynamic> map = {
      "name":name,
        "mobile_number":mobileNumber,
        "agent_address":"${area},${street},${city},${state}",
        "image": MultipartFile.fromBytes(
           await insidePic!.readAsBytes(),
          filename: insidePic?.name,
        ),
      "email":emailID,
      "dob":CustomDate().formatServerDate(_date!),
    };
    widget.onNext(map);
  }

  bool isEdit = false;

  void _checkSelectionIfEdit(){

    var address= widget.agentList!.agentAddress;

    if(widget.agentList != null){
      nameController.text = "${widget.agentList!.name}";
      emailIdController.text="${widget.agentList!.email}";
      mobileNumberController.text= "${widget.agentList!.phoneNumber}";
      if (address != null){
        setState(() {
          final split= address.toString().split(",");
          cityController.text=split[2];
          stateController.text=split[3];
          streetController.text=split[0];
          areaController.text=split[1];
        });
      }
    }
  }


  void _checkIfEdit(){
    if(widget.agentList != null){
      setState(() {
        _checkSelectionIfEdit();
        isEdit = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfEdit();

  }



  DateTime? _date;
  String? _formatDate;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      InkWell(
                        onTap:(){
                          NavigationService().pop();
                        },
                        child: Text(
                          "Delivery Agents",
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
                        "Add Delivery Agent - step 1",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      VerticalDivider(
                        color: AppColors.black,
                        thickness: 1.25,
                      ),
                      Text(
                        "Personal Details",
                        style: TextStyle(
                            color: AppColors.appColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
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
              padding: EdgeInsets.only(left: 70,right: 90,top:90,bottom: 50),

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
                        Text("Personal Details",style: TextStyle(color: AppColors.black,fontSize: 22,fontWeight: FontWeight.w600),),
                        Image.asset("assets/images/personalDetails.jpeg",
                          width: 270,),
                        Container(),

                      ],
                    ),
                    SizedBox(height: 120,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

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
                                           getImage();
                                            //TakePhoto(ImageSource.gallery,insidePic.name);
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
                            child: Image.network(insidePic!.path),
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
                    SizedBox(height: 60,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Agent Name",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                    controller: nameController,
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
                                    controller: mobileNumberController,
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
                                    controller: emailIdController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                     keyboardType: TextInputType.emailAddress,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.singleLineFormatter,
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
                                Text("Date of Birth:",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                SizedBox(width: 100,),

                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width*0.25,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1.0, color: Colors.grey[500]!)),
                                  child: InkWell(
                                    onTap: () {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1884),
                                          lastDate: DateTime(2023))
                                          .then((date) {
                                        setState(() {
                                          _date = date;
                                          _formatDate = new DateFormat.yMd()
                                              .format(_date!);
                                        });
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: AppColors.appColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            _date == null
                                                ? "Date of Birth "
                                                : _formatDate!,
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
                                        ),


                                      ],
                                    ),
                                  ),
                                )
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
                                    controller: streetController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
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
                                    controller: areaController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    // keyboardType: TextInputType.phone,
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
                                    controller: cityController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    keyboardType: TextInputType.name,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.singleLineFormatter,
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
                                    controller: stateController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    keyboardType: TextInputType.name,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.singleLineFormatter,
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
                            _goNext();
                          //  NavigationService().navigatePage(AddAgentBankDetails());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.red
                            ),
                            child: Text("Next",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.whitecolor),),
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
    );
  }
}




class AddAgentBankDetails extends StatefulWidget {
   AddAgentBankDetails({Key? key, required this.onNext, this.agentBankData}) : super(key: key);
  final Function(Map<String, dynamic>) onNext;
  MyAgentsList? agentBankData;

  @override
  State<AddAgentBankDetails> createState() => _AddAgentBankDetailsState();
}

class _AddAgentBankDetailsState extends State<AddAgentBankDetails> {
  File? insidePic;
  final picker = ImagePicker();
  void TakePhoto(ImageSource source, File imageFile) async {
    print("Image Picker");
    final pickerFile = await ImagePicker().pickImage(source: source);
    setState(() {
      insidePic = File(pickerFile!.path);
    });
  }
  final _textEditingController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountHolderNameController = TextEditingController();
  final accountNumberController= TextEditingController();
  final ifscNumberController = TextEditingController();
  final branchNameController = TextEditingController();
  final mobileNumberController= TextEditingController();
  final cityController = TextEditingController();
  final stateController= TextEditingController();
  final streetController = TextEditingController();
  final areaController= TextEditingController();
  final pinCodeController= TextEditingController();

  _goNext() async {
    String accountHolderName=accountHolderNameController.text.trim();
    String accountNumber=accountNumberController.text.trim();
    String ifscNumber= ifscNumberController.text.trim();
    String branchName= branchNameController.text.trim();
    String mobileNumber=mobileNumberController.text.trim();
    String area= areaController.text.trim();
    String street =streetController.text.trim();
    String city=cityController.text.trim();
    String state=stateController.text.trim();
    String pincode=pinCodeController.text.trim();
    Map<String, dynamic> map = {
      "bank_name":bankNameController.text.trim(),
      "account_holder_name":accountHolderName,
      "account_number":accountNumber,
      "ifsc_number":ifscNumber,
      "branch_name":branchName,
      "mobile_number_in_bank":mobileNumber,
      "bank_address":"${area},${city},${state},${pincode}",
      // "image": MultipartFile.fromBytes(
      //    await insidePic!.readAsBytes(),
      //   filename: insidePic?.name,
      // ),
    };
    widget.onNext(map);
  }


  bool isEdit = false;

  void _checkSelectionIfEdit(){

    var address= widget.agentBankData!.bankDetails.bankAddress;

    if(widget.agentBankData != null){
      bankNameController.text = "${widget.agentBankData!.bankDetails.bankName}";
      accountHolderNameController.text="${widget.agentBankData!.bankDetails.accountHolderName}";
      accountNumberController.text = "${widget.agentBankData!.bankDetails.accountNumber}";
      ifscNumberController.text="${widget.agentBankData!.bankDetails.ifscNumber}";
      branchNameController.text= "${widget.agentBankData!.bankDetails.branchName}";
      mobileNumberController.text="${widget.agentBankData!.bankDetails.mobileNumberInBank}";
      areaController.text="${widget.agentBankData!.bankDetails.bankAddress}";
      if (address != null){
        setState(() {
          final split= address.toString().split(",");
          stateController.text=split[2];
          pinCodeController.text=split[3];
          areaController.text=split[0];
          cityController.text=split[1];
        });
      }


    }
  }


  void _checkIfEdit(){
    if(widget.agentBankData != null){
      setState(() {
        _checkSelectionIfEdit();
        isEdit = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfEdit();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                        onTap:(){
                          NavigationService().navigatePage(DeliveryAgents());
                        },
                        child: Text(
                          "Delivery Agents",
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
                        "Add Delivery Agent - step 1",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      VerticalDivider(
                        color: AppColors.black,
                        thickness: 1.25,
                      ),
                      Text(
                        "Bank Account Details",
                        style: TextStyle(
                            color: AppColors.appColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
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
              padding: EdgeInsets.only(left: 70,right: 90,top:90,bottom: 50),

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
                    if(widget.agentBankData != null)
                    Text(widget.agentBankData!.bankDetails.bankAddress),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bank Account Details",style: TextStyle(color: AppColors.black,fontSize: 22,fontWeight: FontWeight.w600),),
                        Image.asset("assets/images/bankDetails.jpeg",
                          width: 270,),
                        Container(),

                      ],
                    ),
                    SizedBox(height: 120,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Bank Name",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                    controller: bankNameController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    keyboardType: TextInputType.name,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.singleLineFormatter,
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
                                Text("Account Holder Name",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                    controller: accountHolderNameController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    keyboardType: TextInputType.name,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.singleLineFormatter,
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
                                Text("Account Number",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                    controller: accountNumberController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    keyboardType: TextInputType.phone,
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
                                Text("IFSC Code",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                    controller: ifscNumberController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    // keyboardType: TextInputType.phone,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.singleLineFormatter,
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
                                    controller: mobileNumberController,
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

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Bank Branch",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                    controller: branchNameController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    keyboardType: TextInputType.name,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.singleLineFormatter,
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
                                    controller: areaController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                   // keyboardType: TextInputType.phone,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.singleLineFormatter,
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
                                    controller: cityController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    keyboardType: TextInputType.name,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.singleLineFormatter,
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
                                    controller: stateController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    keyboardType: TextInputType.name,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.singleLineFormatter,
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
                                Text("Pincode",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
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
                                    controller: pinCodeController,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // controller: numberController,
                                    cursorColor: AppColors.appColor,
                                    keyboardType: TextInputType.phone,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter.digitsOnly,
                                       LengthLimitingTextInputFormatter(6)
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




                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 80,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            NavigationService().pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.red)
                            ),
                            child: Text("Back",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.red),),
                          ),
                        ),
                        SizedBox(width: 100,),
                        InkWell(
                          onTap: (){
                            _goNext();
                            // NavigationService().navigatePage(AssignVehicle());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.red
                            ),
                            child: Text("Next",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.whitecolor),),
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
    );
  }

}



class AssignVehicle extends StatefulWidget {
   AssignVehicle({Key? key, required this.onNext, this.agentdetails}) : super(key: key);
  final Function(Map<String, dynamic>) onNext;
  MyAgentsList? agentdetails;

  @override
  State<AssignVehicle> createState() => _AssignVehicleState();
}

class _AssignVehicleState extends State<AssignVehicle> {
  File? insidePic;
  final picker = ImagePicker();
  void TakePhoto(ImageSource source, File imageFile) async {
    print("Image Picker");
    final pickerFile = await ImagePicker().pickImage(source: source);
    setState(() {
      insidePic = File(pickerFile!.path);
    });
  }

  bool _fetching = false;

  //PastOrders? pastOrders;

  VechiclesList? vehicles;
  MyVehiclesList? myVehiclelist;

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
          myVehiclelist=vehicles!.data[0];
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



  final modelTypeController = TextEditingController();
  final modelNumberController = TextEditingController();
  final engineNumberController= TextEditingController();
  final chasisNumberController = TextEditingController();
  final licencePlateController = TextEditingController();



  _goNext() async {


    Map<String, dynamic> map = {
      "vehicle_id":myVehiclelist?.vehicleId,

    };
    widget.onNext(map);
  }
  _goEdit() async {


    Map<String, dynamic> map = {
      "vehicle_id":myVehiclelist?.vehicleId,
      "agent_id":widget.agentdetails!.deliveryAgentId
    };
    widget.onNext(map);
  }

  String dropdownvalue = 'Item 1';

  bool isEdit = false;

  void _checkSelectionIfEdit(){

    if(myVehiclelist != null){

    modelNumberController.text=myVehiclelist!.modelNumber;
    modelTypeController.text=myVehiclelist!.modelType;
    engineNumberController.text=myVehiclelist!.engineNumber;
    chasisNumberController.text=myVehiclelist!.chassisNumber;
    licencePlateController.text=myVehiclelist!.licenceNumber;


    }
  }

bool isChange=false;
  void _checkIfEdit(){

    if(widget.agentdetails != null){
      setState(() {
        _checkSelectionIfEdit();
        isChange = true;
      });
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchVehicles();
    _checkIfEdit();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      InkWell(
                        onTap:(){
                          NavigationService().navigatePage(DeliveryAgents());
                        },
                        child: Text(
                          "Delivery Agents",
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
                        "Add Delivery Agent - step 3",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      VerticalDivider(
                        color: AppColors.black,
                        thickness: 1.25,
                      ),
                      Text(
                        "Assign Vehicle",
                        style: TextStyle(
                            color: AppColors.appColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
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
              padding: EdgeInsets.only(left: 70,right: 90,top:90,bottom: 50),

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
                        Text("Assign Vehicle",style: TextStyle(color: AppColors.black,fontSize: 22,fontWeight: FontWeight.w600),),
                        Image.asset("assets/images/assignVehicle.png",
                          width: 270,),
                        Container(),

                      ],
                    ),
                    // ListView.builder(
                    //   itemCount: vehicles!.data.length,
                    //     itemBuilder: (context, index){
                    //     return InkWell(
                    //       onTap: (){
                    //         setState(() {
                    //           myVehiclelist=vehicles!.data[index];
                    //         });
                    //       },
                    //         child: Text(myVehiclelist!.chassisNumber));
                    //     }
                    // ),
                    SizedBox(height: 120,),
                    if(vehicles?.data != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Brand/Vehicle Name",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                SizedBox(width: 100,),
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 50,
                                  width: 450,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppColors.whitecolor,
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xFFD1D5DB),
                                      )),
                                  child: DropdownButton<MyVehiclesList>(
                                    isExpanded: true,
                                    underline:
                                    DropdownButtonHideUnderline(child: Container()),
                                    value: myVehiclelist,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 15,
                                      color:Colors.red,
                                    ),
                                    items: vehicles?.data.map<DropdownMenuItem<MyVehiclesList>>((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          "${value.vehicleName}",
                                          style: TextStyle(
                                              color: AppColors.red,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      print("${value?.vehicleId}");
                                      setState(() {
                                        dropdownvalue = value?.vehicleName as String;
                                        myVehiclelist=value;
                                        // if(value!.vehicleId==myVehiclelist!.vehicleId){
                                        //
                                        // }
                                      });
                                    },
                                  ),
                                )
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
                                    controller: modelTypeController,
                                    readOnly: true,
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
                                        hintText: "${myVehiclelist!.modelType}",
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
                                    controller: modelNumberController,
                                    readOnly: true,
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
                                        hintText: "${myVehiclelist!.modelNumber}",
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
                                    controller: engineNumberController,
                                    readOnly: true,
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
                                      hintText: "${myVehiclelist!.engineNumber}",
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
                                    controller: chasisNumberController,
                                    readOnly: true,
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
                                        hintText: "${myVehiclelist!.chassisNumber}",
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


                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
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
                                    controller: licencePlateController,
                                    readOnly: true,
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
                                        hintText: "${myVehiclelist!.licenceNumber}",
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


                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text("Provide Helmet",style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            //     SizedBox(width: 100,),
                            //
                            //     DropDownWidget(Width: 460,),
                            //   ],
                            // ),





                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 80,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            NavigationService().pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.red)
                            ),
                            child: Text("Back",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.red),),
                          ),
                        ),
                        SizedBox(width: 100,),
                        InkWell(
                          onTap: (){
                            // if(isEdit){
                            //   //_goEdit();
                            //   _goNext();
                            // }else {
                            //  // _goNext();
                            //   _goEdit();
                            // }
                            // if(isChange){
                            //   _goEdit();
                            // }else{
                              _goNext();
                            // }
                            //_goNext();

                           // NavigationService().navigatePage(MyVehicles());
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
    );
  }
}
