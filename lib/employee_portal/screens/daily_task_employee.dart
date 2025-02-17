import 'package:office_orbit/cards/appbar_card.dart';
import 'package:office_orbit/utils/fonts.dart';
import 'package:office_orbit/widgets/empty_widget.dart';
import 'package:office_orbit/widgets/round_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../utils/colors.dart';

class EmployeeDailyTaskScreen extends StatefulWidget {
  static String ID = "/employee_daily_task_screen";
  const EmployeeDailyTaskScreen({super.key});

  @override
  State<EmployeeDailyTaskScreen> createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<EmployeeDailyTaskScreen> {
  String _leaveType = "Casual";
  DateTime _currentDate = DateTime.now();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRefer.kBackgroundColor,
        appBar: appBar(
          title: 'Add Daily Tasks',
          leadingWidget: BackButton(
            color: ColorRefer.kBackgroundColor,
          ),
        ),
        body: Center(child: emptyWidget('Coming Soon!', context)));
  }
}
