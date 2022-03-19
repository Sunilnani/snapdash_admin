import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 4,
        child: Container(
          color: Colors.red,
        ));
  }
}
