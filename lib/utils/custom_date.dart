import 'package:intl/intl.dart';

//
class CustomDate{
  String formatServerDate(DateTime date){
    final formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(date);
  }
}