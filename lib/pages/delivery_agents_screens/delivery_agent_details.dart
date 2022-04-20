import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/agents_manager.dart';
import 'package:snapdash_admin/models/agentsModels/agent_details_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/utils/appColors.dart';
class DeliveryAgentDetails extends StatefulWidget {
  DeliveryAgentDetails({
    required this.agentId
});
  final int? agentId;

  @override
  State<DeliveryAgentDetails> createState() => _DeliveryAgentDetailsState();
}

class _DeliveryAgentDetailsState extends State<DeliveryAgentDetails> {


  bool  _fetching = false;
  AgentDetailsModel? agentDetails;

  Future<void> _fetchAgentDetails() async {
    setState(() {
      _fetching = true;
    });
    try {
      final response = await agentManager.fetchAgentDetail(widget.agentId);

      if (response.status == ResponseStatus.SUCCESS) {
        Fluttertoast.showToast(msg: response.message);
        print("------->past ${(response.data).toJson()}");
        setState(() {
          agentDetails = response.data;
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
    _fetchAgentDetails();
  }

  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 1,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              color: AppColors.bgpink,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 58.0,left: 50,right: 90),
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
                              "Delivery Agents",
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
                            "Delivery Agent details",
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

                        GestureDetector(
                          onTap: (){
                            // _openAddProduct();
                           // NavigationService().navigatePage(AddDeliveryAgent());
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
                                      Icons.arrow_circle_down_sharp,
                                      size: 18,
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
                    )
                  ],
                ),
              ),
            ),

            Positioned(
              top: 170,
              left: 80,
              right: 80,
              bottom: 30,
              child: agentDetails == null ?CustomCircularProgressIndicator():Container(
                height: MediaQuery.of(context).size.height*0.98,
                padding: EdgeInsets.only(left: 60,right: 60,top: 40,bottom: 10),

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        agentsMonthlyDetails(),

                       agentsPersonalDetails(),

                        vehicleDetails()
                      ],
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.3,
                          width: MediaQuery.of(context).size.width*0.54,
                          padding: EdgeInsets.all(20),
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


                        agentAccountDetails()

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

  Widget agentsMonthlyDetails(){
    return  Container(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.yellow,
            ),
          ),
          SizedBox(height: 15,),
          Text(agentDetails?.agentName ?? "",style: TextStyle(color: AppColors.red,fontSize: 16,fontWeight: FontWeight.w600),),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Earned Amount",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text("c 35,020",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Orders",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text("1024",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Monthly Travel",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text("457 km",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Overall Distance",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text("223455 km",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
        ],
      ),
    );
  }

  Widget agentsPersonalDetails(){
    return  Container(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Agent Details",style: TextStyle(color: AppColors.red,fontSize: 16,fontWeight: FontWeight.w600),),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.agentName??"",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          // SizedBox(height: 15,),
          //
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("Last Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
          //     Text("Chowdary",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
          //   ],
          // ),
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
              Text("Date of Birth",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text("01/01/1998",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Mobile Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text("${agentDetails!.phoneNumber}",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
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
              Text("City",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text("Hyderabad",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),


        ],
      ),
    );
  }

  Widget vehicleDetails(){
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Vehicle Details",style: TextStyle(color: AppColors.red,fontSize: 16,fontWeight: FontWeight.w600),),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Vehicle Class",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.vehicleDetails.vehicleName?? "",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Make/Model",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.vehicleDetails.modelType?? "",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Registration Date",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.vehicleDetails.registrationDate?? "",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Engine Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.vehicleDetails.engineNumber??"",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Registration Upto",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.vehicleDetails.registrationUpto??"",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Bike Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.vehicleDetails.licenceNumber??"Ap2898954",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rc Status",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text("Active",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),


        ],
      ),
    );
  }

  Widget agentAccountDetails(){
    return Container(
      height: MediaQuery.of(context).size.height*0.3,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Agent Account Details",style: TextStyle(color: AppColors.red,fontSize: 16,fontWeight: FontWeight.w600),),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Account Holder Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.bankDetails.accountHolderName??"No name",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Account Number",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.bankDetails.accountNumber??"No number",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("IFSC Code",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.bankDetails.ifscNumber??"Empty",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Bank Name",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.bankDetails.bankName??"Empty",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Branch",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text(agentDetails!.bankDetails.branchName??"Empty",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("City",style: TextStyle(color: AppColors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              Text("Hyderabad",style: TextStyle(color: AppColors.darkGrey,fontSize: 14,fontWeight: FontWeight.w600),),
            ],
          ),

        ],
      ),
    );
  }


}
