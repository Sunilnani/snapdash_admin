import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/delivery_agents_screens/add_delivery_agent/add_delivery_agent.dart';
import 'package:snapdash_admin/pages/delivery_agents_screens/delivery_agent_details.dart';
import 'package:snapdash_admin/pages/delivery_agents_screens/update_deliveryAgent.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class DeliveryAgents extends StatefulWidget {
  const DeliveryAgents({Key? key}) : super(key: key);

  @override
  State<DeliveryAgents> createState() => _DeliveryAgentsState();
}

class _DeliveryAgentsState extends State<DeliveryAgents> {

  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
      activeIndex: 1,
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
                          "View Agents List",
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
                        onTap: (){
                         // _openAddProduct();
                           NavigationService().navigatePage(AddDeliveryAgent());
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
                                  Text("ADD Delivery Agent",
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





                child: DataTable(
                  // columnSpacing: 38.0,
                  showCheckboxColumn: false,
                  dataRowHeight: 70,
                  headingRowColor: MaterialStateColor.resolveWith((states) {return AppColors.lightblue;},),
                  columns: [
                    DataColumn(label:Text('EmpID',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Image',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Email ID',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Mobile Number',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Total Orders',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Working status',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('View',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Actions',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                  ],
                  rows: List.generate(3, (index) {
                    final empID = "123";
                    final image = "image";
                    final name = "hitler";
                    final emailID = "Sunil345@gmail.com";
                    final mobileNumber = "9999999999";
                    final TotalOrders = "110";
                    final WorkingStatus = "Active";
                    final view = Icon(Icons.remove_red_eye_outlined);
                    final actions = Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap:(){
                            // NavigationService().navigatePage(UpdateDeliveryAgent());
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
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.grey)

                          ),
                          child: Icon(Icons.delete_forever,size: 18,),
                        )
                      ],
                    );


                    return DataRow(
                      onSelectChanged: (bool){
                        NavigationService().navigatePage(DeliveryAgentDetails());
                      },
                        cells: [
                          DataCell(
                            Text(empID),
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
                                  // child: ImageWidget(
                                  //     imageUrl: URLS.buildImageUrl(
                                  //         "${image}"))
                                child: Text(image),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(name),
                          ),
                          DataCell(
                              Container( child: Text(emailID))),
                          DataCell(Container( child: Text(mobileNumber))),
                          DataCell(Container( child: Text(TotalOrders))),
                          DataCell(Container( child: Text(WorkingStatus))),
                          DataCell(view),
                          DataCell(actions),

                        ]);
                  }),
                ),

              ),
            ),
          ),
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Container(
          //       color: AppColors.lightblue,
          //       height: 60,
          //       //alignment: Alignment.center,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Text('EmpId',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
          //              Text('Image',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
          //                Text('Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
          //               Text('Email Id',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
          //              Text('Mobile Number',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
          //               Text('Orders Delivered',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
          //               Text('status',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
          //           Text('View',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
          //               Text('Actions',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
          //         ],
          //       ),
          //     ),
          //     SizedBox(height: 10,),
          //     ListView.builder(
          //     padding: EdgeInsets.only(
          //              top: 20,
          //       ),
          //          shrinkWrap: true,
          //      physics: NeverScrollableScrollPhysics(),
          //       scrollDirection: Axis.vertical,
          //       itemCount: 3,
          //
          //         itemBuilder: (context, index) {
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           InkWell(
          //             onTap:(){
          //               NavigationService().navigatePage(DeliveryAgentDetails());
          //             },
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text("01"),
          //                 CircleAvatar(
          //                   backgroundColor: Colors.yellow,
          //                   radius: 20,
          //                 ),
          //                 Text("Name"),
          //                 Text("sunil@"),
          //                 Text("9898989"),
          //                 Text("235"),
          //                 Text("status 0"),
          //                 Icon(Icons.remove_red_eye_outlined,size: 18,color: Colors.black,),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     InkWell(
          //                       onTap:(){
          //                         NavigationService().navigatePage(UpdateDeliveryAgent());
          //                       },
          //                       child: Container(
          //                         alignment: Alignment.center,
          //                         height: 30,
          //                         width: 30,
          //                         decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(4),
          //                             // border: Border.all(color: AppColors.red)
          //                             color: AppColors.red
          //                         ),
          //                         child:Icon(Icons.person_add_alt,color:AppColors.whitecolor,size: 18,),
          //                       ),
          //                     ),
          //                     SizedBox(width: 20,),
          //                     Container(
          //                       alignment: Alignment.center,
          //                       height: 30,
          //                       width: 30,
          //                       decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(4),
          //                           border: Border.all(color: AppColors.grey)
          //
          //                       ),
          //                       child: Icon(Icons.delete_forever,size: 18,),
          //                     )
          //                   ],
          //                 )
          //               ],
          //             ),
          //           ),
          //           SizedBox(height: 20,)
          //         ],
          //       );
          //         })
          //
          //
          //   ],
          // ),

        ],
      )
    );
  }
}

