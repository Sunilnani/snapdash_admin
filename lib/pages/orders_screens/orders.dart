import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
      activeIndex: 3,
        child: Container(
          color: Colors.yellow,
        ));
  }
}
