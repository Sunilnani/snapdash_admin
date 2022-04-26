import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/managers/profile_manager.dart';
import 'package:snapdash_admin/models/profileModels/profile_details_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/appColors.dart';
import 'package:snapdash_admin/utils/urls.dart';
class MyProfile extends StatefulWidget {
   MyProfile({Key? key, this.profileData}) : super(key: key);
  ProfileModel? profileData;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  bool _fetching = false;

  //PastOrders? pastOrders;

  ProfileModel? profile;

  Future<void> _fetchProfile() async {
    setState(() {
      _fetching = true;
    });
    try {
      final response = await profileManager.profileData();

      if (response.status == ResponseStatus.SUCCESS) {
        Fluttertoast.showToast(msg: response.message);
       // print("------->Agents ${(response.data as AgentsListModel).toJson()}");
        setState(() {
          profile = response.data;
          _checkSelectionIfEdit();
          isEdit = true;
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


  bool _loading =false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();



  Future<void> updateProfile() async {

     String? name = nameController.text.trim();
     String? email=emailController.text.trim();
     String? address=addressController.text.trim();

    final data = {

      "user_id":profile!.userId,
      "name":name ?? "",
      "email":email ?? "",
      "address":address ?? "",

      // "image": MultipartFile.fromBytes(
      //   await insidePic!.readAsBytes(),
      //   filename: insidePic?.name,
      // ),

      // "image": MultipartFile.fromBytes(insidePic!.readAsBytesSync())

    };


    if(insidePic != null){
      data["image"] = await  MultipartFile.fromBytes(
        await insidePic!.readAsBytes(),
        filename: insidePic?.name,
      );
    }

    setState(() {
      _loading = true;
    });

    final response = await profileManager.updateProfile(data);

    if (response.status == ResponseStatus.SUCCESS) {
      Fluttertoast.showToast(msg: response.message);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: response.message);
      print("---------------------##########${response.status}");

    }

    setState(() {
      _loading = false;
    });
  }

  bool isEdit = false;

  void _checkSelectionIfEdit(){

    if(profile != null){
     setState(() {
       nameController.text = profile!.userName;
       emailController.text=profile!.email;
       addressController.text= profile!.address;
     });

    }
  }


  void _checkIfEdit(){
    if(profile != null){
      setState(() {
        _checkSelectionIfEdit();
        isEdit = true;
      });
    }
  }



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



@override
  void initState() {
    // TODO: implement initState
    _fetchProfile();
  //_checkIfEdit();
  }

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
              child: profile == null ? CustomCircularProgressIndicator():Container(
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
                              insidePic == null && profile!.image == null?
                              InkWell(
                                onTap:(){
                                  getImage();
                                },
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor:Colors.grey.withOpacity(0.3),
                                ),
                              ):
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: CachedNetworkImageProvider(
                                      URLS.parseImage(profile!.image)
                                    ),
                                  )
                              ,
                              // Container(
                              //       height: 60,
                              //       width: 60,
                              //       decoration: BoxDecoration(
                              //         shape: BoxShape.circle,
                              //         image: DecorationImage(
                              //           fit: BoxFit.fill,
                              //           image: CachedNetworkImageProvider(
                              //             URLS.parseImage(
                              //               profile!.image,
                              //             ),
                              //           ),
                              //         ),
                              //       )
                              //   ),

                              SizedBox(height: 30,),
                              Text("${profile!.userName}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22,color: AppColors.black),),
                              SizedBox(height: 15,),
                              Text("ID : ${profile!.userId}",style: TextStyle(fontWeight: FontWeight.w600,fontSize:16,color:Colors.deepPurpleAccent.withOpacity(0.7)),),

                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name",style: TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.w600),),
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
                                        "+91 ${profile!.phoneNumber}",
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
                                            readOnly: true,
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
                                                //hintText: "Enter your number",
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
                                   controller: emailController,
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
                                   controller: addressController,
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
                          InkWell(
                            onTap: (){
                              if(isEdit){
                                updateProfile();
                              }
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
