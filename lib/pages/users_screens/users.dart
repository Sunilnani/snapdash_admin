import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/pages/users_screens/view_user.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
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
                padding: const EdgeInsets.only(bottom: 58.0,left: 70,right: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Icon(Icons.water_damage_rounded,size: 18,),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap:(){
                              // TakePhoto(ImageSource.gallery,insidePic!);
                            },
                            child: Text(
                              "Users",
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
                            "Users List",
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
                          child: Text("Search",style: TextStyle(color: AppColors.red,fontWeight: FontWeight.w600),),

                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),


            Positioned(
              top:160,
              left: 70,
              right: 70,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DropDownWidget(Width: 200,),
                        ],
                      ),
                      SizedBox(width: 70,),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User Status",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DropDownWidget(Width: 200,),
                        ],
                      ),
                      SizedBox(width: 70,),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select by Date",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                              onTap: () => _selectDate(context),
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width:200,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColors.whitecolor,
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xFFD1D5DB),
                                    )),
                                child: selectedDate==null?Text("select date to filter"):Text("${selectedDate.toLocal()}".split(' ')[0]),
                              )
                          ),

                        ],
                      ),
                    ],
                  ),

                  InkWell(
                    onTap: (){
                      // _openAddProduct();
                      NavigationService().navigatePage(ViewUser());
                    },
                    child: Container(
                        height: 45,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.appColor,
                          borderRadius: BorderRadius.circular(6),
                          // boxShadow: [
                          //   BoxShadow(
                          //       offset: Offset(0, 1),
                          //       blurRadius: 2,
                          //       spreadRadius: 0,
                          //       color:AppColors.appColor)
                          // ]
                        ),
                        child: Text("Clear all",
                            style: TextStyle(
                              color: AppColors.whitecolor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ))),
                  )

                ],
              ),
            ),


            Positioned(
              top: 270,
              left: 70,
              right: 70,
              child: Container(
                height: MediaQuery.of(context).size.height*0.7,

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
                child: Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: AppColors.lightblue,
                        height: 60,
                        //alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('S.NO',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                            Text('Image',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                            Text('User Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                            Text('Gender',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                            Text('Email Id',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                            Text('Mobile Number',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                            Text('Placed Orders',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                            Text('status',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                            Text('View',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      ListView.builder(
                          padding: EdgeInsets.only(
                            top: 20,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: 3,

                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap:(){
                                    //NavigationService().navigatePage(DeliveryAgentDetails());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("01"),
                                      CircleAvatar(
                                        backgroundColor: Colors.yellow,
                                        radius: 20,
                                      ),
                                      Text("Name"),
                                      Text("male"),
                                      Text("sunil@123"),
                                      Text("9898989"),
                                      Text("23"),
                                      Text("status 0"),
                                      Icon(Icons.remove_red_eye_outlined,size: 18,color: Colors.black,),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,)
                              ],
                            );
                          })


                    ],
                  ),
                ),
              ),
            ),

          ],
        )
    );
  }
}
