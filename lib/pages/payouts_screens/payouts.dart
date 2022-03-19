import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
class PayOuts extends StatefulWidget {
  const PayOuts({Key? key}) : super(key: key);

  @override
  State<PayOuts> createState() => _PayOutsState();
}

class _PayOutsState extends State<PayOuts> {
  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
        activeIndex: 1,
        child: Container(
          color: Colors.green,
        ));
  }
}
