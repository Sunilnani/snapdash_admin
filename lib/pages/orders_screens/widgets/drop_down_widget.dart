import 'package:flutter/material.dart';
import 'package:snapdash_admin/utils/appColors.dart';



class DropDownWidget extends StatefulWidget {
  DropDownWidget({this.Width, });
  double? Width;


  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {


  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2 Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 50,
      width: widget.Width,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
          color: AppColors.whitecolor,
          border: Border.all(
            width: 1,
            color: Color(0xFFD1D5DB),
          )),
      child: DropdownButton(
        isExpanded: true,
        underline:
        DropdownButtonHideUnderline(child: Container()),
        value: dropdownvalue,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 15,
          color: Color(0xFF818181),
        ),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
        },
      ),
    );
  }
}