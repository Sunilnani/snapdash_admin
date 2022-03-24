import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/delivery_agents_screens/add_delivery_agent.dart';
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
                          onTap:(){
                           // TakePhoto(ImageSource.gallery,insidePic!);
                          },
                          child: Text(
                            "Delivery Boys",
                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        VerticalDivider(
                          color: AppColors.appColor,
                          thickness: 1.25,
                        ),
                        Text(
                          "Delivery Boys",
                          style: TextStyle(
                              color: AppColors.appColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
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
                        width: MediaQuery.of(context).size.width*0.1,
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
                            height: 38,
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
            left: 100,
            right: 100,
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
                  dataRowHeight: 70,
                  headingRowColor: MaterialStateColor.resolveWith((states) {return Colors.greenAccent;},),
                  columns: [
                    DataColumn(label: Text('IMAGE')),
                    DataColumn(label: Text('COLORS')),
                    DataColumn(label: Text('SHAPE')),
                    DataColumn(label: Text('MATERIAL')),
                    DataColumn(label: Text('CATEGORY')),
                    DataColumn(label: Text('SUB CATEGORY')),
                    DataColumn(label: Text('PRODUCT NAME')),
                    DataColumn(label: Text('VARIENT')),
                  ],
                  rows: List.generate(1, (index) {
                    final image = "image";
                    final colors = "red";
                    final shape = "circular";
                    final material = "strong";
                    final category = "iron";
                    final sub_category = "mettallic";
                    final product_name = "blade";
                    final varient = "bike";


                    return DataRow(

                        cells: [
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
                            CircleAvatar(
                                radius: 14,
                                backgroundColor: AppColors.appColor,
                                // child:ImageWidget(
                                //     imageUrl: URLS.buildImageUrl(
                                //         "${image}"))
                              child: Text(colors),
                            ),
                          ),
                          DataCell(
                              Container( child: Text(shape))),
                          DataCell(Container( child: Text(material))),
                          DataCell(Container( child: Text(category))),
                          DataCell(Container( child: Text(sub_category))),
                          DataCell(Container( child: Text(product_name))),
                          DataCell(Container( child: Text(varient))),

                        ]);
                  }),
                ),
              ),
            ),
          ),

        ],
      )
    );
  }
}

