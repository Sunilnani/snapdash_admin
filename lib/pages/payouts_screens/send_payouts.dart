import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/pages/payouts_screens/payouts.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class SendPayOuts extends StatefulWidget {
  const SendPayOuts({Key? key}) : super(key: key);

  @override
  State<SendPayOuts> createState() => _SendPayOutsState();
}

class _SendPayOutsState extends State<SendPayOuts> {
  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 4,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              color: AppColors.bgpink,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 58.0,left: 50,right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Icon(Icons.water_damage_rounded,size: 18,),
                          SizedBox(width: 10,),
                          Text(
                            "Payouts",
                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          VerticalDivider(
                            color: AppColors.black,
                            thickness: 1.25,
                          ),

                          Text(
                            "Send Payout",
                            style: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
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
              left: 150,
              right: 150,
              child: Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  padding: EdgeInsets.only(bottom: 30,top: 50),

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



                  child:  Column(
                    children: [

                      Container(
                        padding: EdgeInsets.only(top: 40,left: 100,right: 100),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Expanded(
                              //width: MediaQuery.of(context).size.width*0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Agent Progress",style: AppColors.titleRed,),
                                  SizedBox(height: 30,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Full Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("Sunil",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Monthly Orders",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("120",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Monthly Distance Travelled",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("500 km",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Oerders",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("3980",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Distance Travelled",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("3987 km",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Previous Month Paid",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("c 4,020",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Present Amount",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("c 4,908",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),


                                ],
                              ),
                            ),

                            SizedBox(width: 150,),

                            Expanded(
                              //width: MediaQuery.of(context).size.width*0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bank Details",style: AppColors.titleRed,),
                                  SizedBox(height: 30,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Benificiary Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("John Cena",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Bank  Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("ABC Bank",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Account Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("19293838393939",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("IFSC Code",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("ABC1234",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Branch",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("Ghana",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Area",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("Ghana Area",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Zip Code",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Text("12345",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
                                    ],
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 80,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              NavigationService().pop();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.red)
                              ),
                              child: Text("Back",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.red),),
                            ),
                          ),
                          SizedBox(width: 100,),
                          InkWell(
                            onTap: (){
                              showDialog(context: context, builder: (BuildContext context) => errorDialog);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.red
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.send,color: AppColors.whitecolor,size: 20,),
                                  SizedBox(width: 10,),
                                  Text("Send",style:TextStyle(color: AppColors.whitecolor,fontWeight:FontWeight.w600,fontSize: 14),),

                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
              ),
            ),

          ],
        )
    );
  }

}
Dialog errorDialog = Dialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
  child: Container(
    height: 220.0,
    width: 400.0,
    padding: EdgeInsets.only(left: 35,top: 25,bottom: 20,right: 20),

    child: Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Sending Payment', style: TextStyle(color: AppColors.darkGrey,fontSize: 16,fontWeight: FontWeight.w600),),
       SizedBox(height: 25,),
       Row(
         children: [
           Text('Name    :'   , style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w500),),
           SizedBox(width: 5,),
           Text('  John cena', style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w600),),
         ],
       ),
        SizedBox(height: 10,),
        Row(
          children: [
            Text('Amount :'   , style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w500),),
            SizedBox(width: 5,),
            Text('  c 4,908', style: TextStyle(color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w600),),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 25.0)),
        InkWell(
          onTap: (){
            NavigationService().navigatePage(PayOuts());
          },
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.red
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.send,color: AppColors.whitecolor,size: 20,),
                SizedBox(width: 10,),
                Text("Send",style:TextStyle(color: AppColors.whitecolor,fontWeight:FontWeight.w600,fontSize: 14),),

              ],
            ),),
          ),
      ],
    ),
  ),
);