import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/pages/payouts_screens/statistics.dart';
import 'package:snapdash_admin/pages/payouts_screens/payouts_history.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class AgentPaymentDetails extends StatefulWidget {
  const AgentPaymentDetails({Key? key}) : super(key: key);

  @override
  State<AgentPaymentDetails> createState() => _AgentPaymentDetailsState();
}

class _AgentPaymentDetailsState extends State<AgentPaymentDetails> {


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
        activeIndex: 4,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  color: AppColors.bgpink,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100.0,left: 70,right: 70),
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
                                  NavigationService().navigatePage(Statistics());
                                  // TakePhoto(ImageSource.gallery,insidePic!);
                                },
                                child: Text(
                                  "Payouts",
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
                          InkWell(
                            onTap: (){
                              NavigationService().pop();
                            },
                            child: Text(
                              "Payouts History",
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
                                "Agent Payout Details",
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

              ],
            ),
            Positioned(
              top:160,
              left: 70,
              right: 70,
              child:  Row(
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
                            child: selectedDate==null?Text("select date to filter"):Text("${selectedDate.toLocal()}".split(' ')[0],style: TextStyle(color: AppColors.red),),
                          )
                      ),

                    ],
                  ),
                ],
              ),
            ),


            Positioned(
              top: 270,
              left: 100,
              right: 100,
              bottom: 30,
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
                child: DataTable(

                  // columnSpacing: 38.0,
                  showCheckboxColumn: false,
                  dataRowHeight: 70,
                  headingRowColor: MaterialStateColor.resolveWith((states) {return AppColors.lightblue;},),
                  columns: [
                    DataColumn(label:Text('Transaction ID',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Date',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Time',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Mobile Number',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Account Number',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Payment Method',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Amount Paid',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                  ],
                  rows: List.generate(3, (index) {
                    final transactionId = "23";
                    final date = "29-12-2022";
                    final time = "12 Am";
                    final mobileNumber = "989898988988";
                    final accountNumber = "987878t8t8";
                    final paymentMethod = "Bank Transfer";
                    final amountPaid = "c 2050";


                    return DataRow(
                        onSelectChanged: (bool){
                          //NavigationService().navigatePage(OrderDetails());
                        },
                        cells: [
                          DataCell(
                            Text(transactionId),
                          ),
                          DataCell(
                            Text(date),
                          ),
                          DataCell(
                              Container( child: Text(time))),
                          DataCell(Container( child: Text(mobileNumber))),
                          DataCell(Container( child: Text(accountNumber,))),
                          DataCell(Container( child: Text(paymentMethod))),
                          DataCell(Text(amountPaid)),

                        ]);
                  }),
                ),


                // child: Container(
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.rectangle,
                //       color: AppColors.whitecolor,
                //       borderRadius: BorderRadius.circular(5),
                //       boxShadow: [
                //         BoxShadow(
                //             offset: Offset(0, 3),
                //             blurRadius: 10,
                //             spreadRadius: 0,
                //             color: Colors.black.withOpacity(0.3))
                //       ]),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         color: AppColors.lightblue,
                //         height: 60,
                //         //alignment: Alignment.center,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Text('Date',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //             Text('Order Id',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //             Text('User Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //             Text('Category name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //             Text('Payment Method',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //             Text('Order Status',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //             Text('Grand total',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //             Text('View',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //             Text('Order Picked',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                //           ],
                //         ),
                //       ),
                //       SizedBox(height: 10,),
                //       ListView.builder(
                //           padding: EdgeInsets.only(
                //             top: 20,
                //           ),
                //           shrinkWrap: true,
                //          // separatorBuilder: (_, __) => Divider(height: 2,color: Colors.white,),
                //           physics: NeverScrollableScrollPhysics(),
                //           scrollDirection: Axis.vertical,
                //           itemCount: 5,
                //
                //           itemBuilder: (context, index) {
                //             return InkWell(
                //               onTap:(){
                //                 NavigationService().navigatePage(OrderDetails());
                //               },
                //               child: Padding(
                //                 padding: const EdgeInsets.only(bottom: 40.0),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                   children: [
                //                     Text("25--3-22"),
                //                     Text("#123"),
                //                     Text("Mike"),
                //                     Text("Books"),
                //                     Text("Cash"),
                //                     Text("Ready to pick",style: TextStyle(color: AppColors.red),),
                //                     Text("c 20"),
                //                     Icon(Icons.remove_red_eye_outlined,size: 18,color: Colors.black,),
                //                     Text("Mike Jacob"),
                //
                //                   ],
                //                 ),
                //               ),
                //             );
                //           })
                //
                //
                //     ],
                //   ),
                // ),
              ),
            ),

          ],
        )
    );
  }
}
