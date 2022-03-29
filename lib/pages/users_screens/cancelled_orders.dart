import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class CancelledOrders extends StatefulWidget {
  const CancelledOrders({Key? key}) : super(key: key);

  @override
  State<CancelledOrders> createState() => _CancelledOrdersState();
}

class _CancelledOrdersState extends State<CancelledOrders> {
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
                          Icon(Icons.water_damage_rounded,size: 20,),
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
                            "Users",
                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          VerticalDivider(
                            color: AppColors.black,
                            thickness: 1.25,
                          ),
                          InkWell(
                            onTap: (){
                              NavigationService().pop();
                            },
                            child: Text(
                              "View Users",
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
                            "Cancelled orders",
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
                child: Container(
                  width: double.infinity,
                  child: DataTable(
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
                    // columnSpacing: 38.0,
                    showCheckboxColumn: false,
                    dataRowHeight: 70,
                    headingRowColor: MaterialStateColor.resolveWith((states) {return AppColors.lightblue;},),
                    columns: [
                      DataColumn(label:Text('Date',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('OrderID',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Image',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Order Type',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('User Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Payment Method',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Order Status',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Grand Total',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Agent Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    ],
                    rows: List.generate(3, (index) {
                      final date = "23-10-2022";
                      final orderId = "#12344";
                      final image = "image";
                      final orderType = "Books";
                      final userName = "Sandy";
                      final paymentMethod = "COD";
                      final orderStatus = "Cancelled";
                      final grandTotal = "c 20";

                      final orderPicked = "peter st";


                      return DataRow(
                          onSelectChanged: (bool){
                            // NavigationService().navigatePage(OrderDetails());
                          },
                          cells: [
                            DataCell(
                              Text(date),
                            ),
                            DataCell(
                              Text(orderId),

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
                              Text(orderType),
                            ),
                            DataCell(
                                Container( child: Text(userName))),
                            DataCell(Container( child: Text(paymentMethod))),
                            DataCell(Container( child: Text(orderStatus,style: AppColors.subheadingred,))),
                            DataCell(Container( child: Text(grandTotal))),
                            DataCell(Text(orderPicked)),

                          ]);
                    }),
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
                //           Text('Date',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //           Text('Order Id',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //           Text('Image',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //           Text('Order Type',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //           Text('User Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //           Text('Payment Method',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //           Text('Order Status',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //           Text('Grand total',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //           Text('Order Picked',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //         ],
                //       ),
                //     ),
                //     SizedBox(height: 10,),
                //     ListView.builder(
                //         padding: EdgeInsets.only(
                //           top: 20,
                //         ),
                //         shrinkWrap: true,
                //         // separatorBuilder: (_, __) => Divider(height: 2,color: Colors.white,),
                //         physics: NeverScrollableScrollPhysics(),
                //         scrollDirection: Axis.vertical,
                //         itemCount: 5,
                //
                //         itemBuilder: (context, index) {
                //           return InkWell(
                //             onTap:(){
                //               //NavigationService().navigatePage(OrderDetails());
                //             },
                //             child: Padding(
                //               padding: const EdgeInsets.only(bottom: 40.0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Text("25--3-22"),
                //                   Text("#123"),
                //                  Container(
                //                    height: 60,
                //                    width: 60,
                //                    decoration: BoxDecoration(
                //                      borderRadius: BorderRadius.circular(5),
                //                      color: Colors.yellow
                //                    ),
                //                  ),
                //                   Text("Books"),
                //                   Text("Mike"),
                //                   Text("Cash"),
                //                   Text("Ready to pick",style: TextStyle(color: AppColors.red),),
                //                   Text("c 20"),
                //                   Text("Mike Jacob"),
                //
                //                 ],
                //               ),
                //             ),
                //           );
                //         })
                //
                //
                //   ],
                // ),
              ),
            ),

          ],
        )
    );
  }
}
