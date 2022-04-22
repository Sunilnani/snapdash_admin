import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/user_managers.dart';
import 'package:snapdash_admin/models/users_models/user_cancelled_orders_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/appColors.dart';
import 'package:snapdash_admin/utils/custom_date.dart';
import 'package:snapdash_admin/utils/urls.dart';
class CancelledOrders extends StatefulWidget {
  const CancelledOrders({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  State<CancelledOrders> createState() => _CancelledOrdersState();
}

class _CancelledOrdersState extends State<CancelledOrders> {

  bool  _fetching = false;
  UserCancelledOrdersModel? cancelledOrders;

  Future<void> _fetchCancelledOrders() async {
    setState(() {
      _fetching = true;
    });
    try {
      final response = await userManager.userCancelledOrders(widget.userId);

      if (response.status == ResponseStatus.SUCCESS) {
        Fluttertoast.showToast(msg: response.message);
        print("------->user Cancelled Orders ${(response.data).toJson()}");
        print("---------------------> user Id ${widget.userId}");
        setState(() {
          cancelledOrders = response.data;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCancelledOrders();
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
                child:cancelledOrders == null?Center(child: Text("No Cancelled Orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),) :
                Container(
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
                    rows: List.generate(cancelledOrders!.data.length, (index) {
                      final date = CustomDate().formatServerDate(cancelledOrders!.data[index].createdAt);
                      final orderId = cancelledOrders!.data[index].orderId;
                      final image = Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(URLS.parseImage(cancelledOrders!.data[index].itemImage ?? "",
                      ),
                      ),

                      ),

                      ));
                      final orderType = cancelledOrders!.data[index].categoryName;
                      final userName = cancelledOrders!.data[index].userName;
                      final paymentMethod = cancelledOrders!.data[index].paymentMode;
                      final orderStatus = cancelledOrders!.data[index].status;
                      final grandTotal = "c ${cancelledOrders!.data[index].price}";

                      final orderPicked = cancelledOrders!.data[index].receiverName;


                      return DataRow(
                          onSelectChanged: (bool){
                            // NavigationService().navigatePage(OrderDetails());
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
                                Container( child: Text(userName))),
                            DataCell(Container( child: Text(paymentMethod))),
                            DataCell(Container( child: Text("${orderStatus}",style: AppColors.subheadingred,))),
                            DataCell(Container( child: Text(grandTotal))),
                            DataCell(Text(orderPicked)),

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
