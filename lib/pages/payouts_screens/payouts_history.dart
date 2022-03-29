import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/pages/payouts_screens/agent_payment_details.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class PayOutHistory extends StatefulWidget {
  const PayOutHistory({Key? key}) : super(key: key);

  @override
  State<PayOutHistory> createState() => _PayOutHistoryState();
}

class _PayOutHistoryState extends State<PayOutHistory> {
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
                                  NavigationService().pop();
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
                              Text(
                                "Payouts History",
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
                    DataColumn(label: Text('Agent Image',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Agent Name',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Mobile Number',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Gender',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Payment Method',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('View',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                    DataColumn(label: Text('Grand Total',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),),),
                  ],
                  rows: List.generate(3, (index) {
                    final transactionId = "23";
                    final date = "29-12-2022";
                    final image=CircleAvatar(
                      backgroundColor: AppColors.red,
                      radius: 25,
                    );
                    final name = "hitler";
                    final mobileNumber = "989898988988";
                    final gender = "Male";
                    final paymentMethod = "Bank Transfer";
                    final view=Icon(Icons.remove_red_eye_outlined,size: 18,);
                    final grandTotal = "c 2050";


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
                              image
                          ),
                          DataCell(
                              Container( child: Text(name))),
                          DataCell(Container( child: Text(mobileNumber))),
                          DataCell(Container( child: Text(gender,))),
                          DataCell(Container( child: Text(paymentMethod))),
                          DataCell(
                              InkWell(
                                onTap: (){
                                  NavigationService().navigatePage(AgentPaymentDetails());
                                },
                                  child: view)
                          )
                          ,
                          DataCell(Text(grandTotal)),

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
