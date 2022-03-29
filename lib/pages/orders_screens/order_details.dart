import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 2,
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
                              "Orders",
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
                            "Order Details",
                            style: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        // _openAddProduct();
                        //NavigationService().navigatePage(AddDeliveryAgent());
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
                                Text("Download Receipt",
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
                ),
              ),
            ),


            Positioned(
              top: 180,
              left: 70,
              right: 70,
              child: Container(
                height: MediaQuery.of(context).size.height*0.7,
                padding: EdgeInsets.only(top: 40,bottom: 30),

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*0.32,
                            width: MediaQuery.of(context).size.width*0.26,
                            padding: EdgeInsets.only(top: 20,left: 35,right: 35),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                // boxShadow: [
                                //   BoxShadow(
                                //       offset: Offset(0, 3),
                                //       blurRadius: 5,
                                //       spreadRadius: 0,
                                //       color: Colors.black.withOpacity(0.4))
                                // ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Order ID: #123",style: TextStyle(color: AppColors.black
                                    ,fontSize: 20,fontWeight: FontWeight.w600),),
                                SizedBox(height: 15,),
                                Text("Ordered on OCTOBER 25,2022",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),

                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Tome of Order placed",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("11:00 Am",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Time of Order Accepted",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("11:10 Am",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Pick Up Time",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("11:25 Am",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Delivered Time",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("11:45 Am",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Delivered By",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("Sunny",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: MediaQuery.of(context).size.height*0.32,
                            width: MediaQuery.of(context).size.width*0.26,
                            padding: EdgeInsets.only(top: 20,left: 35,right: 35),

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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pick-Up-Address",style: TextStyle(color: AppColors.red,fontSize: 16,fontWeight: FontWeight.w600),),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Customer Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("Sunil",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Phone Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("9998989898",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Email ID",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("sunil123@gmail.com",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Address Line",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("Anna Nagar",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Flat / Building Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("21-10/2",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Street Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("Nagar",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Pincode",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("002030",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),


                              ],
                            ),
                          ),

                          Container(
                            height: MediaQuery.of(context).size.height*0.32,
                            width: MediaQuery.of(context).size.width*0.26,
                            padding: EdgeInsets.only(top: 20,left: 35,right: 35),

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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pick-Up-Address",style: TextStyle(color: AppColors.red,fontSize: 16,fontWeight: FontWeight.w600),),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Customer Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("Sunil",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Phone Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("9998989898",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Email ID",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("sunil123@gmail.com",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Address Line",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("Anna Nagar",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Flat / Building Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("21-10/2",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Street Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("Nagar",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Pincode",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text("002030",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50,),
                      Container(
                        width: double.infinity,
                        child: DataTable(
                          // columnSpacing: 38.0,
                          showCheckboxColumn: false,
                          dataRowHeight: 70,
                          headingRowColor: MaterialStateColor.resolveWith((states) {return AppColors.lightblue;},),
                          columns: [
                            DataColumn(label:Text('Date',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                            DataColumn(label:Text('OrderID',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                            DataColumn(label: Text('Image',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                            DataColumn(label: Text('OrderType',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                            DataColumn(label: Text('UserName',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                            DataColumn(label: Text('PaymentMethod',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                            DataColumn(label: Text('OrderStatus',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                            DataColumn(label: Text('Grand Total',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                            DataColumn(label: Text('OrderPicked',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                          ],
                          rows: List.generate(2, (index) {
                            final date = "23-12-2022";
                            final orderId="123";
                            final image = "image";
                            final orderType = "Electronics";
                            final Nmae = "Sunil";
                            final paymentMethod = "Cod";
                            final orderStatus = "Delivered";
                            final grandTotal = "c 20";
                            final orderPicked="peter st";


                            return DataRow(
                                onSelectChanged: (bool){
                                 // NavigationService().navigatePage(DeliveryAgentDetails());
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
                                      Container( child: Text(Nmae))),
                                  DataCell(Container( child: Text(paymentMethod))),
                                  DataCell(Container( child: Text(orderStatus))),
                                  DataCell(Container( child: Text(grandTotal))),
                                  DataCell(Text(orderPicked)),


                                ]);
                          }),
                        ),
                      ),
                  Divider(
                         color: AppColors.grey,
                          height: 2,
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(right: 330.0,top: 30),
                          child: Align(
                            alignment: Alignment.bottomRight,
                              child: Text("Total Amount     c40",style: TextStyle(color: AppColors.red,fontSize: 16,fontWeight: FontWeight.w500),)),
                        )




                      // Column(
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
                      //           Text("Order Type",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                      //           Text('User Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                      //           Text('Payment Method',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                      //           Text('Order Status',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                      //           Text('Order Picked',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                      //           Text('Grand Total',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                      //
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
                      //         itemCount: 2,
                      //
                      //         itemBuilder: (context, index) {
                      //           return InkWell(
                      //             onTap:(){
                      //              // NavigationService().navigatePage(OrderDetails());
                      //             },
                      //             child: Padding(
                      //               padding: const EdgeInsets.only(bottom: 40.0),
                      //               child: Row(
                      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                 children: [
                      //                   Text("25--3-22"),
                      //                   Text("#123"),
                      //                   CircleAvatar(
                      //                     backgroundColor: Colors.yellow,
                      //                     radius: 20,
                      //                   ),
                      //                   Text("Books"),
                      //                   Text("Mike"),
                      //                   Text("Cash"),
                      //                   Text("Ready to pick",style: TextStyle(color: AppColors.red),),
                      //                   Text("Mike Jacob"),
                      //                   Text("c 20"),
                      //
                      //
                      //                 ],
                      //               ),
                      //             ),
                      //           );
                      //         }),
                      //     Divider(
                      //       color: AppColors.grey,
                      //       height: 2,
                      //     ),
                      //     SizedBox(height: 10,),
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 130.0),
                      //       child: Align(
                      //         alignment: Alignment.bottomRight,
                      //           child: Text("Total Amount     c40",style: TextStyle(color: AppColors.red,fontSize: 16,fontWeight: FontWeight.w500),)),
                      //     )
                      //
                      //
                      //   ],
                      // ),
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
