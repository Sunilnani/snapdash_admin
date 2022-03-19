import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class DeliveryAgents extends StatefulWidget {
  const DeliveryAgents({Key? key}) : super(key: key);

  @override
  State<DeliveryAgents> createState() => _DeliveryAgentsState();
}

class _DeliveryAgentsState extends State<DeliveryAgents> {
  List<String> ListOfAlphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
  ];
  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
      activeIndex: 0,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            color: Colors.pink[200],
            child: Padding(
              padding: const EdgeInsets.only(bottom: 58.0,left: 30,right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Text(
                          "Delivery Boys",
                          style: TextStyle(
                              color:Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
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
                          // NavigationService().navigatePage(AddProduct());
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
            ),
          ),

        ],
      )
    );
  }
}

