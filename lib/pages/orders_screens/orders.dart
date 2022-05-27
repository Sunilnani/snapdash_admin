import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/orders_manager.dart';
import 'package:snapdash_admin/models/orders_model/orders_list_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/pages/orders_screens/order_details.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/utils/appColors.dart';
import 'package:snapdash_admin/utils/custom_date.dart';
class Orders extends StatefulWidget {
  const Orders({Key? key, this.query, this.name}) : super(key: key);
  final String? query;
  final String? name;

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

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

  late DateTime _date;
  late String _formatteDate;

  bool _fetching = false;

  //PastOrders? pastOrders;

  OrdersListModel? orders;

  Future<void> _fetchOrders() async {
    setState(() {
      _fetching = true;
    });
    try {
      final response = await ordersManager.ordersList(query: _searchController.text.trim(),name: dropdownvalue);

      if (response.status == ResponseStatus.SUCCESS) {
        Fluttertoast.showToast(msg: response.message);
        print("------->ordersList ${(response.data as OrdersListModel).toJson()}");
        setState(() {
          orders = response.data;
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


  TextEditingController _searchController = TextEditingController();


  _searchOrder(){
    final String query=_searchController.text.trim();
    final String name=dropdownvalue;

    // _fetchSearchVehicles(query);
    _fetchOrders();



  }


  Datum? ordersList;
  String dropdownvalue = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.query != null ){
      _searchController.text = widget.query ?? "" ;
    }
    if(widget.name != null){
      dropdownvalue=widget.name??"";
    }
    _fetchOrders();
  }

  @override
  void dispose(){
    //_scrollController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 2,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  color: AppColors.bgpink,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100,left: 70,right: 70),
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
                                "Orders List",
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
                                controller: _searchController,
                                autofocus: true,
                                onSubmitted: (value){
                                  _searchOrder();
                                },
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
                        ),
                        Container()
                      ],
                    ),
                  ),
                ),

              ],
            ),
            Positioned(
              top:160,
              left: 70,
              right: 70,
              child:   Row(
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status",
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
                        "Date To Filter",
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
                            height: 50,
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
                  SizedBox(width: 70,),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category Name To Filter",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.whitecolor,
                            border: Border.all(
                              width: 1,
                              color: Color(0xFFD1D5DB),
                            )),
                        child: DropdownButton<Datum>(
                          isExpanded: true,
                          underline:
                          DropdownButtonHideUnderline(child: Container()),
                          value: ordersList,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 15,
                            color:Colors.red,
                          ),
                          items: orders?.data.map<DropdownMenuItem<Datum>>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                "${value.categoryName}",
                                style: TextStyle(
                                    color: AppColors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            print("${value?.userId}");
                            setState(() {
                              dropdownvalue = value?.categoryName as String;
                              ordersList=value;
                              // if(widget.name != null)
                              // dropdownvalue = widget.name??"";
                              _searchOrder();
                            });
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),


            Positioned(
              top: 270,
              left: 70,
              right: 70,
              bottom: 30,
              child:orders == null ? Center(child: CustomCircularProgressIndicator()): Container(
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    // columnSpacing: 38.0,
                    showCheckboxColumn: false,
                    dataRowHeight: 70,
                    headingRowColor: MaterialStateColor.resolveWith((states) {return AppColors.lightblue;},),
                    columns: [
                      DataColumn(label:Text('Date',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('OrderID',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('User Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Category Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Payment Method',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Order Status',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Grand Total',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('View',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                      DataColumn(label: Text('Order Picked',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    ],
                    rows: List.generate(orders!.data.length, (index) {
                      final date = CustomDate().formatServerDate(orders!.data[index].createdAt);
                      final orderId = orders!.data[index].orderId;
                      final name = orders!.data[index].userName;
                      final categoryName = orders!.data[index].categoryName;;
                      final paymentMethod = orders!.data[index].paymentMode;
                      final orderSttatus = orders!.data[index].status;
                      final grandTotal = orders!.data[index].price;
                      final view = Icon(Icons.remove_red_eye_outlined);
                      final orderPicked = orders!.data[index].receiverName??"";


                      return DataRow(
                          onSelectChanged: (bool){
                            NavigationService().navigatePage(OrderDetails(orderId: orders!.data[index].orderId,));
                          },
                          cells: [
                            DataCell(
                              Text(date),
                            ),
                            DataCell(
                              Text("${orderId}"),
                            ),
                            DataCell(
                              Text(name),
                            ),
                            DataCell(
                                Container( child: Text(categoryName))),
                            DataCell(Container( child: Text(paymentMethod))),
                            DataCell(Container( child: "${orderSttatus}"=="8"?Text("Delivered",style: AppColors.subheadingGreen,):Text("Accepted",style: AppColors.subheadingred,))),
                            DataCell(Container( child: Text("c ${grandTotal}"))),
                            DataCell(view),
                            DataCell(Text("${orderPicked}")),

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
