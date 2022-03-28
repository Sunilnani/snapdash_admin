import 'package:flutter/material.dart';
import 'package:snapdash_admin/base_home_page.dart';
class ActiveAreas extends StatefulWidget {
  const ActiveAreas({Key? key}) : super(key: key);

  @override
  State<ActiveAreas> createState() => _ActiveAreasState();
}

class _ActiveAreasState extends State<ActiveAreas> {
  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
      activeIndex: 5,
        child: Container(color: Colors.green,));
  }
}
