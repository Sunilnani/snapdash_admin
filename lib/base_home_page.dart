import 'package:flutter/material.dart';
import 'package:snapdash_admin/common/top_app_bar.dart';
import 'package:snapdash_admin/utils/appColors.dart';

class BaseHomePage extends StatefulWidget {
  const BaseHomePage({Key? key, required this.child, this.activeIndex}) : super(key: key);

  final Widget child;
  final int? activeIndex;

  @override
  _BaseHomePageState createState() => _BaseHomePageState();
}

class _BaseHomePageState extends State<BaseHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TopAppBar(

        activeIndex: widget.activeIndex,
      ),
      body: Column(
        children: [
          Expanded(
            child:widget.child,

          ),
        ],
      ),
    );
  }
}