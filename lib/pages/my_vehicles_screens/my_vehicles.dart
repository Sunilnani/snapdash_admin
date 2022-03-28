import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/add_vehicles.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/view_vehicle_details.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class MyVehicles extends StatefulWidget {
  const MyVehicles({Key? key}) : super(key: key);

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {
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
                          onTap: (){
                            // _openAddProduct();
                           NavigationService().navigatePage(AddVehicle());
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
                    rows: List.generate(5, (index) {
                      final sNO ="1";
                      final image = "image";
                      final brandName = "Hero Honda";
                      final modelType = "passion plus";
                      final modelNumber = "h2-0a12u3";
                      final licencePlate = "Ap837388";
                      final vehicleStatus = "status 0";
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
                            NavigationService().navigatePage(ViewVehicleDetails());
                          },
                          cells: [
                            DataCell(
                                Text(
                                  sNO
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
                                    // child: ImageWidget(
                                    //     imageUrl: URLS.buildImageUrl(
                                    //         "${image}"))
                                  child: Text(image),
                                ),
                              ),
                            ),

                            DataCell(
                                Container( child: Text(brandName))),
                            DataCell(
                                Container( child: Text(modelType))),

                            DataCell(Container( child: Text(modelNumber))),
                            DataCell(Container( child: Text(licencePlate))),
                            DataCell(Container( child: Text(vehicleStatus))),
                            DataCell(Container( child: view)),
                            DataCell(Container( child: actions)),

                          ]);
                    }),
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
                  //           Text('S.NO',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                  //           Text('Image',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                  //           Text('Brand Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                  //           Text('Model Type',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                  //           Text('Model Number',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                  //           Text('Licence Palte',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                  //           Text('Vehicle status',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                  //           Text('View',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                  //           Text('Actions',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(height: 10,),
                  //     ListView.builder(
                  //         padding: EdgeInsets.only(
                  //           top: 20,
                  //         ),
                  //         shrinkWrap: true,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         scrollDirection: Axis.vertical,
                  //         itemCount: 3,
                  //
                  //         itemBuilder: (context, index) {
                  //           return Column(
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: [
                  //               InkWell(
                  //                 onTap:(){
                  //                   //NavigationService().navigatePage(DeliveryAgentDetails());
                  //                 },
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                   children: [
                  //                     Text("01"),
                  //                     CircleAvatar(
                  //                       backgroundColor: Colors.yellow,
                  //                       radius: 20,
                  //                     ),
                  //                     Text("Hero Honda"),
                  //                     Text("Passion Plus"),
                  //                     Text("HR1234"),
                  //                     Text("Ap394774"),
                  //                     Text("status 0"),
                  //                     Icon(Icons.remove_red_eye_outlined,size: 18,color: Colors.black,),
                  //                     Row(
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //                       children: [
                  //                         InkWell(
                  //                           onTap:(){
                  //                            // NavigationService().navigatePage(UpdateDeliveryAgent());
                  //                           },
                  //                           child: Container(
                  //                             alignment: Alignment.center,
                  //                             height: 30,
                  //                             width: 30,
                  //                             decoration: BoxDecoration(
                  //                                 borderRadius: BorderRadius.circular(4),
                  //                                 // border: Border.all(color: AppColors.red)
                  //                                 color: AppColors.red
                  //                             ),
                  //                             child:Icon(Icons.person_add_alt,color:AppColors.whitecolor,size: 18,),
                  //                           ),
                  //                         ),
                  //                         SizedBox(width: 20,),
                  //                         Container(
                  //                           alignment: Alignment.center,
                  //                           height: 30,
                  //                           width: 30,
                  //                           decoration: BoxDecoration(
                  //                               borderRadius: BorderRadius.circular(4),
                  //                               border: Border.all(color: AppColors.grey)
                  //
                  //                           ),
                  //                           child: Icon(Icons.delete_forever,size: 18,),
                  //                         )
                  //                       ],
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //               SizedBox(height: 20,)
                  //             ],
                  //           );
                  //         })
                  //
                  //
                  //   ],
                  // ),
                ),
              ),
            ),

          ],
        )
    );
  }
}
