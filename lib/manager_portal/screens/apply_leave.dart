import 'package:office_orbit/cards/appbar_card.dart';
import 'package:office_orbit/utils/fonts.dart';
import 'package:office_orbit/widgets/round_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../utils/colors.dart';

class ApplyLeave extends StatefulWidget {
  static String ID = "/apply_leave_screen";
  const ApplyLeave({super.key});

  @override
  State<ApplyLeave> createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {
  String _leaveType = "Casual";
  DateTime _currentDate = DateTime.now();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRefer.kBackgroundColor,
      appBar: appBar(
        title: 'Apply For Leave',
        leadingWidget: BackButton(
          color: ColorRefer.kBackgroundColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type of leave',
              style: TextStyle(fontSize: 16, color: ColorRefer.kLabelColor, fontFamily: FontRefer.Roboto),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                _buildLeaveTypeButton("Casual"),
                SizedBox(width: 10),
                _buildLeaveTypeButton("Sick"),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Date',
              style: TextStyle(fontSize: 16, color: ColorRefer.kLabelColor, fontFamily: FontRefer.Roboto),
            ),
            Expanded(
              child: CalendarCarousel(
                height: 250,
                headerMargin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                onDayPressed: (date, events) {
                  setState(() {
                    _currentDate = date;
                  });
                },
                weekendTextStyle: const TextStyle(
                  color: Colors.red,
                ),
                thisMonthDayBorderColor: Colors.grey,
                selectedDateTime: _currentDate,
                selectedDayBorderColor: ColorRefer.kPrimaryColor,
                selectedDayButtonColor: ColorRefer.kPrimaryColor,
                daysHaveCircularBorder: false,
                iconColor: ColorRefer.kPrimaryColor,
                headerTextStyle: TextStyle(color: ColorRefer.kPrimaryColor),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Note',
              style: TextStyle(fontSize: 16, color: ColorRefer.kLabelColor, fontFamily: FontRefer.Roboto),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Change border radius
                  borderSide: BorderSide(
                    color: ColorRefer.kLabelColor, // Change border color
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Change border radius
                  borderSide: BorderSide(
                    color: ColorRefer.kLabelColor, // Change border color
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), // Change border radius
                  borderSide: BorderSide(
                    color: ColorRefer.kLabelColor, // Change border color
                  ),
                ),
                hintStyle: TextStyle(fontSize: 13, color: ColorRefer.kLabelColor, fontFamily: FontRefer.Roboto),
                hintText: 'Write a reason',

              ),
            ),
            const SizedBox(height: 20),
            RoundedButton(
              width: MediaQuery.of(context).size.width,
              colour: ColorRefer.kPrimaryColor,
              onPressed: (){},
              title: 'Apply',
              height: 50,
              buttonRadius: 12,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveTypeButton(String type) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _leaveType = type;
          });
        },
        child: Text(type),
        style: ElevatedButton.styleFrom(
          foregroundColor: _leaveType == type ? Colors.white : Colors.black, backgroundColor: _leaveType == type ? ColorRefer.kPrimaryColor : Colors.white,
          side: BorderSide(color: ColorRefer.kPrimaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Adjust this value as needed
          ),
        ),
      ),
    );
  }
}
