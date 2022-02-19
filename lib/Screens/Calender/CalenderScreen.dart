import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalenderScreen extends StatefulWidget {
  final String currentUserId;

  const CalenderScreen({Key? key, required this.currentUserId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => CalenderScreenState();
}

class CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
