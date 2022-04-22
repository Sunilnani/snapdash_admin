import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/orders_manager.dart';
import 'package:snapdash_admin/models/orders_model/order_details_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/appColors.dart';
import 'package:snapdash_admin/utils/custom_date.dart';
import 'package:snapdash_admin/utils/urls.dart';
class OrderDetails extends StatefulWidget {
 OrderDetails({required this.orderId});
 final int? orderId;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  OrderDetailsModel? orderDetails;

  bool _fetching=false;
  var address;
  var deliveryAddress;

  Future<void> _fetchOrderDetails() async {
    setState(() {
      _fetching = true;
    });
    print("..........responsed");
    print("-------->order id is ${widget.orderId}");
    final response = await ordersManager
        .fetchOrderDetail(widget.orderId);
    //print((response.data as OngoingOrderDetails).toJson());
    print(response.data);
    setState(() {
      _fetching = false;
    });

    if (response.status == ResponseStatus.SUCCESS) {
      Fluttertoast.showToast(msg: response.message);
      setState(() {
        orderDetails = response.data;
      });

      if(orderDetails != null){

        setState(() {
          address = orderDetails!.pickupAddress.split(",");
         deliveryAddress=orderDetails!.deliveryAddress.split(",");
        });
      }

      // print(orderDetails?.OrderDetails?.productImages);
    } else {
      Fluttertoast.showToast(msg: response.message);
    }
  }


  @override
  void initState() {
    // TODO: implement initState

    _fetchOrderDetails();


  }


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
                              NavigationService().pop();
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
              child: orderDetails == null? Center(child: CustomCircularProgressIndicator()):Container(
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
                                Text("${orderDetails!.orderId}",style: TextStyle(color: AppColors.black
                                    ,fontSize: 20,fontWeight: FontWeight.w600),),
                                SizedBox(height: 15,),
                                Text("Ordered on:  ${CustomDate().formatServerDate(orderDetails!.createdAt)}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),

                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Time of Order placed",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
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

                         pickUpDetails(),
                        deliveryDetails()

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
                          rows: List.generate(1, (index) {
                            final date = CustomDate().formatServerDate(orderDetails!.createdAt);
                            final orderId=orderDetails!.orderId;
                            final image =
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: CachedNetworkImageProvider(URLS.parseImage(orderDetails!.image ?? "",
                                    ),
                                    ),

                                  ),

                                ));
                            final orderType = orderDetails!.categoryName;
                            final Nmae = orderDetails!.userName;
                            final paymentMethod = orderDetails!.paymentMode;
                            final orderStatus = orderDetails!.status;
                            final grandTotal = "c ${orderDetails!.price}";
                            final orderPicked=orderDetails!.receiverName;


                            return DataRow(
                                onSelectChanged: (bool){
                                 // NavigationService().navigatePage(DeliveryAgentDetails());
                                },
                                cells: [
                                  DataCell(
                                    Text(date),
                                  ),
                                  DataCell(
                                    Text("${orderId}"),
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
                                          child: image

                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(orderType),
                                  ),
                                  DataCell(
                                      Container( child: Text(Nmae??""))),
                                  DataCell(Container( child: Text(paymentMethod))),
                                  DataCell(Container( child: Text("${orderStatus}"))),
                                  DataCell(Container( child: Text(grandTotal??""))),
                                  DataCell(Text(orderPicked??"")),


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
                          padding: const EdgeInsets.only(right: 300.0,top: 30),
                          child: Align(
                            alignment: Alignment.bottomRight,
                              child: Text("Total Amount     c${orderDetails!.price.round()}",style: TextStyle(color: AppColors.red,fontSize: 16,fontWeight: FontWeight.w500),)),
                        )
                    ],
                  ),
                ),
              ),
            ),

          ],
        )
    );
  }
  Widget pickUpDetails(){
    return  Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
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
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Customer Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                Text("${orderDetails!.userName}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Phone Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                Text("${orderDetails!.userNumber}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 15,),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Email ID",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
            //     Text("sunil123@gmail.com",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            //   ],
            // ),
            // SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Area",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                Text(address[0],style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Flat / Building Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                Text(address[1],style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Street Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                Text(address[2],style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 15,),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Pincode",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
            //     Text("002030",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            //   ],
            // ),


          ],
        ),
      ),
    );
  }

  Widget deliveryDetails(){
    return  Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
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
            Text("Delivery-Address",style: TextStyle(color: AppColors.red,fontSize: 16,fontWeight: FontWeight.w600),),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Agent Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                Text(orderDetails!.receiverName??"No name",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Phone Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                Text("${orderDetails!.receiverNumber}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 15,),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Email ID",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
            //     Text("sunil123@gmail.com",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            //   ],
            // ),
           // SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Area",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                Text(deliveryAddress[0]??"",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Street",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                Text(deliveryAddress[1]??"",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("City",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                Text(deliveryAddress[2]??"",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(height: 15,),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Pincode",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
            //     Text("002030",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            //   ],
            // ),


          ],
        ),
      ),
    );
  }
}