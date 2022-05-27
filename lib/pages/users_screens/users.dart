import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/navigation_service.dart';
import 'package:snapdash_admin/managers/user_managers.dart';
import 'package:snapdash_admin/models/users_models/user_list_model.dart';
import 'package:snapdash_admin/network_calls/base_response.dart';
import 'package:snapdash_admin/pages/orders_screens/widgets/drop_down_widget.dart';
import 'package:snapdash_admin/pages/users_screens/view_user.dart';
import 'package:snapdash_admin/utils/appColors.dart';
import 'package:snapdash_admin/utils/urls.dart';

class Users extends StatefulWidget {
  const Users({Key? key, this.query, this.gender}) : super(key: key);
  final String? query;
  final String? gender;

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
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

  bool _fetching = false;

  //PastOrders? pastOrders;

  UsersListModel? users;

  Future<void> _fetchUsers() async {
    setState(() {
      _fetching = true;
    });
    try {
      final response = await userManager.usersList(query: _searchController.text.trim(),gender: dropdownvalue);

      if (response.status == ResponseStatus.SUCCESS) {
        Fluttertoast.showToast(msg: response.message);
        print("------->Agents ${(response.data as UsersListModel).toJson()}");
        setState(() {
          users = response.data;
        });
        setState(() {
          _fetching = false;
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


  _searchUser(){
    final String query=_searchController.text.trim();

    // _fetchSearchVehicles(query);
    _fetchUsers();
  }

  UserDatum? userDataList;
  String dropdownvalue = '';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.query != null ){
      _searchController.text = widget.query ?? "" ;
    }
    if(widget.gender != null){
      dropdownvalue=widget.gender??"";
    }
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 3,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              color: AppColors.bgpink,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 100.0, left: 70, right: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Icon(
                            Icons.water_damage_rounded,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              // TakePhoto(ImageSource.gallery,insidePic!);
                            },
                            child: Text(
                              "Users",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          VerticalDivider(
                            color: AppColors.black,
                            thickness: 1.25,
                          ),
                          Text(
                            "Users List",
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
                          width: MediaQuery.of(context).size.width * 0.34,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.whitecolor,
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: _searchController,
                            autofocus: true,
                            onSubmitted: (value){
                              _searchUser();
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
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.whitecolor,
                          ),
                          child: Text(
                            "Search",
                            style: TextStyle(
                                color: AppColors.red,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Container()
                  ],
                ),
              ),
            ),
            Positioned(
              top: 160,
              left: 70,
              right: 70,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
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
                        child: DropdownButton<UserDatum>(
                          isExpanded: true,
                          underline:
                          DropdownButtonHideUnderline(child: Container()),
                          value: userDataList,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 15,
                            color:Colors.red,
                          ),
                          items: users?.userData.map<DropdownMenuItem<UserDatum>>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child:Text(
                                "${value.gender}",
                                style: TextStyle(
                                    color: AppColors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            //print("${value?.userId}");
                            setState(() {
                              dropdownvalue = value?.gender as String;
                            //  userDataList=value!.gender;
                              _searchUser();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Status",
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
                        child: DropdownButton<UserDatum>(
                          isExpanded: true,
                          underline:
                          DropdownButtonHideUnderline(child: Container()),
                          value: userDataList,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 15,
                            color:Colors.red,
                          ),
                          items: users?.userData.map<DropdownMenuItem<UserDatum>>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child:Text(
                                "${value.gender}",
                                style: TextStyle(
                                    color: AppColors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            //print("${value?.userId}");
                            setState(() {
                              dropdownvalue = value?.gender as String;
                              //  userDataList=value!.gender;
                              _searchUser();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select by Date",
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
                            height: 45,
                            width: 200,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.whitecolor,
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFFD1D5DB),
                                )),
                            child: selectedDate == null
                                ? Text("select date to filter")
                                : Text(
                                    "${selectedDate.toLocal()}".split(' ')[0],
                                    style: TextStyle(color: AppColors.red),
                                  ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 270,
              left: 70,
              right: 70,
              bottom: 30,
              child: users == null
                  ? CustomCircularProgressIndicator()
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.whitecolor,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 10,
                                spreadRadius: 0,
                                color: Colors.black.withOpacity(0.3))
                          ]),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.whitecolor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 3),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    color: Colors.black.withOpacity(0.3))
                              ]),
                          // columnSpacing: 38.0,
                          showCheckboxColumn: false,
                          dataRowHeight: 70,
                          headingRowColor: MaterialStateColor.resolveWith(
                            (states) {
                              return AppColors.lightblue;
                            },
                          ),
                          columns: [
                            DataColumn(
                              label: Text(
                                'S.NO',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Image',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'User Name',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Gender',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Email ID',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Mobile Number',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Placed Orders',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'status',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'View',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                          rows: List.generate(users!.userData.length, (index) {
                            final sNo =index.toString();
                            final image = Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: CachedNetworkImageProvider(
                                      URLS.parseImage(
                                        users!.userData[index].image ?? "",
                                      ),
                                    ),
                                  ),
                                ));
                            ;
                            final name = users!.userData[index].userName??"No Name";
                            final gender = users!.userData[index].gender??"Not Selected";
                            final emailID = "Sunil345@gmail.com";
                            final mobileNumber =
                                users!.userData[index].phoneNumber;
                            final placedOrders =
                                users!.userData[index].ordersPlaced;
                            final status = "Active";
                            final view = Icon(Icons.remove_red_eye_outlined);

                            return DataRow(
                                onSelectChanged: (bool) {
                                  NavigationService().navigatePage(ViewUser(userId: users!.userData[index].userId,));
                                },
                                cells: [
                                  DataCell(
                                    Text("${sNo}"),
                                  ),
                                  DataCell(
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: AppColors.appColor),
                                          child: image),
                                    ),
                                  ),
                                  DataCell(
                                    Text("${name}"),
                                  ),
                                  DataCell(
                                    Text(gender ?? ""),
                                  ),
                                  DataCell(Container(child: Text(emailID ?? ""))),
                                  DataCell(Container(
                                      child: Text("${mobileNumber}"))),
                                  DataCell(Container(
                                      child: Text("${placedOrders}"))),
                                  DataCell(Container(child: Text(status ?? ""))),
                                  DataCell(view),
                                ]);
                          }),
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }
}
