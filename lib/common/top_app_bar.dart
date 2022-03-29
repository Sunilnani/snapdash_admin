import 'package:flutter/material.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/my_account.dart';
import 'package:snapdash_admin/pages/active_areas_screens/active_orders.dart';
import 'package:snapdash_admin/pages/delivery_agents_screens/delivery_agents.dart';
import 'package:snapdash_admin/pages/my_vehicles_screens/my_vehicles.dart';
import 'package:snapdash_admin/pages/orders_screens/orders.dart';
import 'package:snapdash_admin/pages/payouts_screens/statistics.dart';
import 'package:snapdash_admin/pages/users_screens/users.dart';
import 'package:snapdash_admin/utils/appColors.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBar({Key? key, this.activeIndex}) : super(key: key);

  final int? activeIndex;

  @override
  _TopAppBarState createState() => _TopAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}

class _TopAppBarState extends State<TopAppBar> {
  List<String> TabsList = [
    "My Vehicles",
    "Delivery Agents",
    "Orders",
    "Users",
    "PayOuts",
    "Active Areas",

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 55),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 5,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.4))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/logo.png",
            height: 50,
            width: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 28.0),
            child: Row(
              children: [
                Container(
                  height: 36,
                  child: ListView.separated(
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: TabsList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      width: 50,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   widget.activeIndex == index;
                          // });
                          if(index==0){
                            NavigationService().navigatePage(MyVehicles());
                          }
                          if(index==1){
                            NavigationService().navigatePage(DeliveryAgents());
                          }
                          if(index==2){
                            NavigationService().navigatePage(Orders());
                          }
                          if(index==3){
                            NavigationService().navigatePage(Users());
                          }
                          if(index==4){
                            NavigationService().navigatePage(Statistics());
                          }
                          if(index==5){
                            NavigationService().navigatePage(ActiveAreas());
                          }

                        },
                        child: TabsWidget(
                          name: TabsList[index],
                          isActive: widget.activeIndex == index,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                InkWell(
                  onTap: (){
                    NavigationService().navigatePage(MyProfile());
                  },
                  child: CircleAvatar(
                    radius: 20,
                     backgroundColor: AppColors.red,
                   // backgroundImage: AssetImage("assets/profile.png"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TabsWidget extends StatelessWidget {
  const TabsWidget({
    this.name,
    this.isActive = false,
  });
  final String? name;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(6),
        color: isActive ? AppColors.red : Colors.white,
      ),
      child: Center(
        child: Text(
          '${name}',
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}