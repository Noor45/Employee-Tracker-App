import 'dart:async';
import 'dart:convert';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:http/http.dart' as http;
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:office_orbit/model/attendence_model.dart';
import 'package:office_orbit/utils/fonts.dart';
import 'package:flutter/material.dart';
import '../../cards/appbar_card.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:intl/intl.dart';
import '../../widgets/empty_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  bool hasData = false;
  int count = 1;
  List<AttendanceModel>? allAttendanceList = [];
  List<AttendanceModel>? dailyAttendanceList = [];
  List<AttendanceModel>? weeklyAttendanceList = [];
  List<AttendanceModel>? monthlyAttendanceList = [];
  List<AttendanceModel>? yearlyAttendanceList = [];
  StreamController? _AttendanceListController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future fetchPost() async {
    var URL = Uri.https('localhost', '/api/employee/attendance/fetch');
    final res = await http.get(
        URL,
        headers: {
          'Authorization': 'Bearer ${Constants.userToken}',
        }
    );
    Map<String, dynamic> jsonMap = json.decode(res.body);
    if (res.statusCode == 200) {
      List<dynamic> attendance = jsonMap['data'];
      allAttendanceList?.clear();
      for (var element in attendance) {
        AttendanceModel attendanceList = AttendanceModel.fromMap(element);
        allAttendanceList!.add(attendanceList);
      }
      return attendance;
    }
  }

  loadData() async {
    fetchPost().then((res) async {
      _AttendanceListController?.add(res);
      return res;
    });
  }


  showSnack() {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("New Content Loaded"),
        duration: Duration(milliseconds: 700),
      ),
    );
  }

  @override
  void initState() {
    _AttendanceListController = StreamController();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRefer.kBackgroundColor,
      appBar: appBar(
        title: 'History',
      ),
      body: StreamBuilder(
          stream: _AttendanceListController!.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == true && snapshot.data.length != 0) {
              List<dynamic> data = snapshot.data;
              filterAttendances();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTabController(
                  length: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonsTabBar(
                        radius: 60,
                        elevation: 5,
                        backgroundColor: ColorRefer.kPrimaryColor,
                        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        tabs: const [
                          Tab(text: 'Custom'),
                          Tab(text: 'Today'),
                          Tab(text: 'Weekly'),
                          Tab(text: 'Monthly'),
                          Tab(text: 'Yearly'),
                          Tab(text: 'All'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: TabBarView(
                          children: [
                            allAttendanceList!.isNotEmpty ? CustamizedCard(allAttendanceList: allAttendanceList) : emptyWidget('No Attendance to Show', context),
                            dailyAttendanceList!.isNotEmpty ? buildAttendanceListView(dailyAttendanceList) : emptyWidget('No Attendance to Show', context),
                            weeklyAttendanceList!.isNotEmpty ? buildAttendanceListView(weeklyAttendanceList) : emptyWidget('No Attendance to Show', context),
                            monthlyAttendanceList!.isNotEmpty ? buildAttendanceListView(monthlyAttendanceList) : emptyWidget('No Attendance to Show', context),
                            yearlyAttendanceList!.isNotEmpty ? buildAttendanceListView(yearlyAttendanceList) : emptyWidget('No Attendance to Show', context),
                            allAttendanceList!.isNotEmpty ? buildAttendanceListView(allAttendanceList) : emptyWidget('No Attendance to Show', context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              );
            }
            else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            else if (snapshot.hasData == false && snapshot.data == null) {
              return const Center(child: CircularProgressIndicator(color: ColorRefer.kPrimaryColor));
            }
            else if (snapshot.connectionState != ConnectionState.done) {
              return emptyWidget('No Record to Show', context);
            }
            else if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return emptyWidget('No Record to Show', context);
            }
            else if (snapshot.connectionState != ConnectionState.done) {
              return emptyWidget('No Record to Show', context);
            }
            else {
              return emptyWidget('No Record to Show', context);
            }


        }
      ),
    );
  }
  void filterAttendances() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday));
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfYear = DateTime(now.year, 1, 1);

    dailyAttendanceList = allAttendanceList?.where((transaction) {
      DateTime date = DateFormat('MM-dd-yyyy').parse(transaction.date!);
      return date.day == now.day &&
          date.month == now.month &&
          date.year == now.year;
    }).toList();

    weeklyAttendanceList = allAttendanceList?.where((transaction) {
      DateTime date = DateFormat('MM-dd-yyyy').parse(transaction.date!);
      return date.isAfter(startOfWeek) && date.isBefore(startOfWeek.add(const Duration(days: 7)));
    }).toList();

    monthlyAttendanceList = allAttendanceList?.where((transaction) {
      DateTime date = DateFormat('MM-dd-yyyy').parse(transaction.date!);
      return date.isAfter(startOfMonth) && date.isBefore(DateTime(now.year, now.month + 1, 1));
    }).toList();


    yearlyAttendanceList = allAttendanceList?.where((transaction) {
      DateTime date = DateFormat('MM-dd-yyyy').parse(transaction.date!);
      return date.isAfter(startOfYear) && date.isBefore(DateTime(now.year + 1, 1, 1));
    }).toList();
  }

  ListView buildAttendanceListView(List<AttendanceModel>? attendance) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: attendance?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        var marking = attendance![index];
        DateTime dateTime = DateFormat('MM-dd-yyyy').parse(marking.date!);
        String formattedDate = DateFormat('dd MMM').format(dateTime);
        String formattedCheckIn = marking.checkingTime != null
            ? DateFormat('h:mm a').format(DateFormat('H:mm').parse(marking.checkingTime!))
            : '--:--';
        String formattedCheckOut = marking.checkoutTime != null
            ? DateFormat('h:mm a').format(DateFormat('H:mm').parse(marking.checkoutTime!))
            : '--:--';
        return AttendanceRow(
          date: formattedDate,
          checkIn:  formattedCheckIn,
          checkOut:   formattedCheckOut,
          workingHours: marking.workingHours?? '0h:0m',
        );
      },
    );
  }

  String _convertToAmPm(String time) {
    DateTime dateTime = DateFormat('H:mm').parse(time);
    return DateFormat('h:mm a').format(dateTime);
  }
}




class MonthSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MonthButton(text: 'April', isSelected: false),
        MonthButton(text: 'May', isSelected: true),
        MonthButton(text: 'June', isSelected: false),
      ],
    );
  }
}

class MonthButton extends StatelessWidget {
  final String text;
  final bool isSelected;

  MonthButton({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.black, backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
      ),
      onPressed: () {},
      child: Text(text),
    );
  }
}

class AttendanceRow extends StatelessWidget {
  final String date;
  final String checkIn;
  final String checkOut;
  final String workingHours;

  const AttendanceRow({
    Key? key,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.workingHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        height: 100,
        // margin: const EdgeInsets.symmetric(horizontal: 6.0),
        padding: const EdgeInsets.only(right: 10),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.split(' ')[0],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date.split(' ')[1],
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.access_time, color: Colors.green),
                          SizedBox(height: 4),
                          Text(
                            checkIn,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontRefer.Roboto,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Check in',
                        style: TextStyle(
                          fontFamily: FontRefer.Roboto,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 35),
              child: VerticalDivider(
                width: 1,
                color: Colors.grey.shade200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(Icons.access_time, color: Colors.red),
                      SizedBox(height: 4),
                      Text(
                        checkOut,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: FontRefer.Roboto,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Check Out',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: FontRefer.Roboto,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 35),
              child: VerticalDivider(
                width: 1,
                color: Colors.grey.shade200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(Icons.access_time, color: Colors.blue),
                      SizedBox(height: 4),
                      Text(
                        workingHours,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontRefer.Roboto,

                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Total Hrs',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: FontRefer.Roboto,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class WeekendSection extends StatelessWidget {
  final String weekend;

  WeekendSection({required this.weekend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        color: Colors.grey[300],
        child: Text(
          weekend,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustamizedCard extends StatefulWidget {
  const CustamizedCard({super.key, this.allAttendanceList});
  final List<AttendanceModel>? allAttendanceList;

  @override
  State<CustamizedCard> createState() => _CustamizedCardState();
}

class _CustamizedCardState extends State<CustamizedCard> {
  late DateTime _currentDate;
  List<AttendanceModel>? _selectedDayAttendanceList;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _selectedDayAttendanceList = _filterAttendanceByDate(_currentDate);
    print(_selectedDayAttendanceList);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  List<AttendanceModel>? _filterAttendanceByDate(DateTime date) {
    String formattedDate = DateFormat('MM-dd-yyyy').format(date);
    return widget.allAttendanceList?.where((attendance) {
      return attendance.date == formattedDate;
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          color: Colors.white,
          child: CalendarCarousel(
            height: 340,
            headerMargin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            onDayPressed: (date, events) {
              setState(() {
                _currentDate = date;
                _selectedDayAttendanceList = _filterAttendanceByDate(date);
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
        Expanded(
          child: ListView.builder(
            itemCount: _selectedDayAttendanceList?.length ?? 0,
            itemBuilder: (context, index) {
              final attendance = _selectedDayAttendanceList![index];
              DateTime dateTime = DateFormat('MM-dd-yyyy').parse(attendance.date!);
              String formattedDate = DateFormat('dd MMM').format(dateTime);
              String formattedCheckIn = attendance.checkingTime != null
                  ? DateFormat('h:mm a').format(DateFormat('H:mm').parse(attendance.checkingTime!))
                  : '--:--';
              String formattedCheckOut = attendance.checkoutTime != null
                  ? DateFormat('h:mm a').format(DateFormat('H:mm').parse(attendance.checkoutTime!))
                  : '--:--';
              return AttendanceRow(
                date: formattedDate,
                checkIn: formattedCheckIn,
                checkOut: formattedCheckOut,
                workingHours: attendance.workingHours ?? '0h:0m',
              );
            },
          ),
        ),

      ],
    );
  }
}
