import 'dart:async';
import 'dart:convert';
import 'package:office_orbit/controller/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_progress_indicator/flutter_circular_progress_indicator.dart';
import 'package:location/location.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/fonts.dart';
import 'package:intl/intl.dart';

class EmployeePartTimeAttendanceScreen extends StatefulWidget {
  static String ID = "/employee_PartTime_attendance_screen";
  const EmployeePartTimeAttendanceScreen({super.key});

  @override
  State<EmployeePartTimeAttendanceScreen> createState() => _EmployeePartTimeAttendanceScreenState();
}

class _EmployeePartTimeAttendanceScreenState extends State<EmployeePartTimeAttendanceScreen> {
  bool showCheckOutWidget = false;
  bool showbreakWidget = false;
  bool showEndTimeWidget = false;
  bool progress = false;
  Location location = Location();
  Timer? _timer;
  String workingHours = '';
  String _currentTime = '';
  bool isInsideCompany = false;
  bool isCheckedIn = false;
  bool isCheckedOut = false;
  DateTime? _checkInTime;
  DateTime? _checkOutTime;

  List<Map<String, double>> companyCoordinates = List<Map<String, double>>.from(
    json.decode(Constants.companyDetail!.coordinates!).map(
          (item) => {
        "lat": (item["lat"] as num).toDouble(),
        "lng": (item["lng"] as num).toDouble(),
      },
    ),
  );

  @override
  void initState() {
    super.initState();
    _checkLocationService();
    _startTimer();
    _initializeAttendanceState();
  }

  void _initializeAttendanceState() {
    if (Constants.employeeWorkingHours != null) {
      DateTime now = DateTime.now();
      DateTime startBreakTime = _getDateTimeFromTimeString(Constants.employeeWorkingHours!.startBreakTime);
      DateTime endBreakTime = _getDateTimeFromTimeString(Constants.employeeWorkingHours!.endBreakTime);
      DateTime workEndTime = _getDateTimeFromTimeString(Constants.employeeWorkingHours!.endTime);
      if(Constants.attendanceDetail != null){
        setState(() {
          isCheckedIn = true;
          _checkInTime = _getDateTimeFromTimeString(Constants.attendanceDetail!.checkingTime);
          print(Constants.attendanceDetail!.checkoutTime);
          if(Constants.attendanceDetail!.checkoutTime != null){
            isCheckedOut = true;
            _checkOutTime = _getDateTimeFromTimeString(Constants.attendanceDetail!.checkoutTime);
          }
        });
      }else{
        setState(() {
          isCheckedIn = false;
        });
      }
      if (isCheckedIn == true) {
        if(isCheckedOut == true) {
          setState(() {
            showbreakWidget = false;
            showCheckOutWidget = false;
            showEndTimeWidget = true;
          });
        } else {
          if (now.isAfter(startBreakTime) && now.isBefore(endBreakTime)) {
            setState(() {
              showbreakWidget = true;
              showCheckOutWidget = false;
              showEndTimeWidget = false;
            });
          }
          else if (now.isAfter(endBreakTime) && now.isBefore(workEndTime)) {
            setState(() {
              showbreakWidget = false;
              showCheckOutWidget = true;
              showEndTimeWidget = false;
            });
          }
          else if (now.isAfter(workEndTime)) {
            setState(() {
              showbreakWidget = false;
              showCheckOutWidget = false;
              showEndTimeWidget = true;
            });
          }
          else {
            setState(() {
              showbreakWidget = false;
              showCheckOutWidget = true;
              showEndTimeWidget = false;
            });
          }
        }

      }
      else {
        setState(() {
          showbreakWidget = false;
          showCheckOutWidget = false;
          showEndTimeWidget = false;
        });
      }

      _startBreakCheck();
    }
  }

  DateTime _getDateTimeFromTimeString(String? timeString) {
    if (timeString == null) return DateTime.now();
    DateTime now = DateTime.now();
    DateTime time = DateFormat('HH:mm').parse(timeString);
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  void _startBreakCheck() {
    if (Constants.employeeWorkingHours != null) {
      DateTime now = DateTime.now();
      DateTime startBreakTime = _getDateTimeFromTimeString(Constants.employeeWorkingHours!.startBreakTime);
      DateTime endBreakTime = _getDateTimeFromTimeString(Constants.employeeWorkingHours!.endBreakTime);
      DateTime workEndTime = _getDateTimeFromTimeString(Constants.employeeWorkingHours!.endTime);

      if (startBreakTime.isAfter(now)) {
        Timer(startBreakTime.difference(now), () {
          if (isCheckedIn) {
            setState(() {
              showbreakWidget = true;
              showCheckOutWidget = false;
              showEndTimeWidget = false;
            });
          }
        });
      }

      if (endBreakTime.isAfter(now)) {
        Timer(endBreakTime.difference(now), () {
          if (isCheckedIn) {
            setState(() {
              showbreakWidget = false;
              showCheckOutWidget = true;
              showEndTimeWidget = false;
            });
          }
        });
      }

      if (workEndTime.isAfter(now)) {
        Timer(workEndTime.difference(now), () {
          if (isCheckedIn) {
            setState(() {
              showbreakWidget = false;
              showCheckOutWidget = false;
              showEndTimeWidget = true;
            });
          }
        });
      }
    }
  }

  void _startTimer() {
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _currentTime = _formatCurrentTime();
    });
  }

  String _formatCurrentTime() {
    DateTime now = DateTime.now();
    String period = now.hour < 12 ? 'AM' : 'PM';
    int hour = now.hour > 12 ? now.hour - 12 : now.hour;
    if (hour == 0) hour = 12;
    String minute = now.minute.toString().padLeft(2, '0');
    String second = now.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second $period';
  }

  void _checkLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData locationData = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      if (isCheckedIn) {
        _checkIfInsideCompany(currentLocation);
      }
    });
  }

  bool _isPointInPolygon(LocationData point, List<Map<String, double>> polygon) {
    if (point.longitude == null || point.latitude == null) {
      return false;
    }

    int i, j = polygon.length - 1;
    bool oddNodes = false;

    for (i = 0; i < polygon.length; i++) {
      if ((polygon[i]["lng"]! < point.longitude! &&
          polygon[j]["lng"]! >= point.longitude!) ||
          (polygon[j]["lng"]! < point.longitude! &&
              polygon[i]["lng"]! >= point.longitude!)) {
        if (polygon[i]["lat"]! +
            (point.longitude! - polygon[i]["lng"]!) /
                (polygon[j]["lng"]! - polygon[i]["lng"]!) *
                (polygon[j]["lat"]! - polygon[i]["lat"]!) <
            point.latitude!) {
          oddNodes = !oddNodes;
        }
      }
      j = i;
    }

    return oddNodes;
  }

  void _checkIfInsideCompany(LocationData locationData) {
    // bool inside = _isPointInPolygon(locationData, companyCoordinates);
    // if (inside && !isInsideCompany) {
    //   isInsideCompany = true;
    //   _showMessage('Welcome', 'You are back in the company.', true);
    // } else if (!inside && isInsideCompany) {
    //   isInsideCompany = false;
    //   _showMessage('Warning', 'You are going outside the company.', false);
    // }
  }

  void _showMessage(String title, String message, bool success) {
    if (success) {
      MotionToast(
        icon: Icons.check_circle_outline_sharp,
        primaryColor: ColorRefer.kPrimaryColor,
        secondaryColor: Colors.white.withOpacity(0.4),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        description: Text(message, style: const TextStyle(color: Colors.white)),
        toastDuration: const Duration(seconds: 6),
        position: MotionToastPosition.bottom,
        animationType: AnimationType.fromLeft,
        height: 100,
        width: 300,
      ).show(context);
    } else {
      MotionToast(
        icon: Icons.warning_amber_outlined,
        primaryColor: ColorRefer.kSecondaryColor,
        secondaryColor: Colors.black,
        title: Text(title, style: const TextStyle(color: Colors.black)),
        description: Text(message, style: const TextStyle(color: Colors.black)),
        toastDuration: const Duration(seconds: 6),
        position: MotionToastPosition.bottom,
        animationType: AnimationType.fromLeft,
        height: 100,
        width: 300,
      ).show(context);
    }
  }

  void _checkIn() async {
    setState(() {
      progress = true;
    });
    LocationData locationData = await location.getLocation();
    if (_isPointInPolygon(locationData, companyCoordinates)) {
      await EmployeeController
          .employeeCheckIn(Constants.employeeWorkingHours!.startPartTime!, '${DateTime.now().hour}:${DateTime.now().minute}', 'onjob')
          .then((value){
        setState(() {
          isCheckedIn = true;
          isInsideCompany = true;
          showCheckOutWidget = true;
          _checkInTime = DateTime.now();
        });
        _startBreakCheck();
        setState(() {
          progress = false;
        });
        _showMessage('Marked', 'Checked in successfully.', true);
      });
    } else {
      setState(() {
        progress = false;
      });
      _showMessage('Warning', 'You are not in office place right now.', false);
    }
    // try{
    //
    // }catch(e){
    //
    // }
  }

  _checkOut() async{
    setState(() {
      progress = true;
    });
    await EmployeeController.
    employeeCheckOut(
        Constants.employeeWorkingHours!.endTime!,
        '${DateTime.now().hour}:${DateTime.now().minute}',
        _calculateTotalHours(_getDateTimeFromTimeString(Constants.attendanceDetail!.checkingTime!), DateTime.now())
    ).then((value){
      setState(() {
        isCheckedIn = false;
        _checkOutTime = DateTime.now();
        progress = false;
        showCheckOutWidget = true;
        _showMessage('Marked', 'Checked out successfully.', true);
      });
    });
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '--:--';
    }
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    if (hour == 0) hour = 12;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  String _calculateTotalHours(DateTime? checkIn, DateTime? checkOut) {
    if (checkIn == null || checkOut == null) {
      return '0h 0m';
    }
    Duration diff = checkOut.difference(checkIn);
    int hours = diff.inHours;
    int minutes = diff.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorRefer.kPrimaryColor,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'Mark Attendance',
          style: TextStyle(fontFamily: FontRefer.Roboto, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              _buildClockInSection(),
              // const SizedBox(height: 20),
              // _buildAttendanceSummary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClockInSection() {
    String formattedDate = DateFormat('MMM d, yyyy - EEEE').format(DateTime.now());
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          showEndTimeWidget == true || showbreakWidget == true  ?
          const SizedBox() :
          Column(
              children: [
                Text(
                  _currentTime,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ]
          ) ,
          const SizedBox(height: 20),

          progress == false
              ? Column(
            children: [
              showCheckOutWidget == false
                  && showbreakWidget == false && showEndTimeWidget == false
                  ? CheckInWidget(
                onTap: () {
                  setState(() {
                    showCheckOutWidget = true;
                    showbreakWidget = false;
                    showEndTimeWidget = false;
                    _checkIn();
                  });
                },
              )
                  : showbreakWidget
                  ? BreakTimeWidget()
                  : showEndTimeWidget
                  ? EndTimeWidget()
                  : CheckOutWidget(
                endFunction: () async{
                  await _checkOut();

                  setState(() {
                    showbreakWidget = false;
                    showEndTimeWidget = true;
                  });
                },
              ),
              SizedBox(height: 10),
              !showCheckOutWidget && !showbreakWidget && !showEndTimeWidget
                  ? Text(
                'Check in and get started on your successful day.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              )
                  : SizedBox(),
              showbreakWidget || showEndTimeWidget
                  ? Column(
                children: [
                  Text(
                    _currentTime,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              )
                  : SizedBox(),
            ],
          )
              : CircularProgressInd().normalCircular(
            height: 70,
            width: 70,
            valueColor: ColorRefer.kPrimaryColor,
            valueWidth: 5,
            isSpining: true,
          ),
          SizedBox(height: 18),
          Divider(),
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimeColumn(
                  icon: Icons.access_time,
                  time: _formatTime(_checkInTime),
                  label: 'Check In',
                  iconColor: Colors.green,
                ),
                TimeColumn(
                  icon: Icons.access_time,
                  time: _formatTime(_checkOutTime),
                  label: 'Check Out',
                  iconColor: Colors.red,
                ),
                TimeColumn(
                  icon: Icons.check_circle_outline,
                  time: _calculateTotalHours(_checkInTime, _checkOutTime),
                  label: 'Total Hrs',
                  iconColor: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attendance',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAttendanceCard(
                'Early Leaves', '02', Colors.purple[100]!, Colors.purple),
            _buildAttendanceCard('Absents', '05', Colors.blue[100]!, Colors.blue),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAttendanceCard('Late in', '0', Colors.red[100]!, Colors.red),
            _buildAttendanceCard('Leaves', '08', Colors.orange[100]!, Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildAttendanceCard(
      String label, String count, Color backgroundColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckInWidget extends StatefulWidget {
  CheckInWidget({super.key, this.onTap});
  Function? onTap;

  @override
  State<CheckInWidget> createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap!.call();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: ColorRefer.kPrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: ColorRefer.kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'Check in',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckOutWidget extends StatefulWidget {
  CheckOutWidget({super.key, this.endFunction});
  Function? endFunction;
  // Function? breakFunction;

  @override
  State<CheckOutWidget> createState() => _CheckOutWidgetState();
}

class _CheckOutWidgetState extends State<CheckOutWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.endFunction!.call();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: ColorRefer.kPrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: ColorRefer.kPrimaryColor.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'Check Out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///Break Time Widget

class BreakTimeWidget extends StatefulWidget {
  const BreakTimeWidget({super.key});

  @override
  State<BreakTimeWidget> createState() => _BreakTimeWidgetState();
}

class _BreakTimeWidgetState extends State<BreakTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "It's Your Break Time!",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your break time will end at ${Constants.employeeWorkingHours!.endBreakTime!}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Image.asset('assets/images/coffee-cup.png', height: 150, width: 150,),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

///End Time Widget

class EndTimeWidget extends StatefulWidget {
  const EndTimeWidget({super.key});

  @override
  State<EndTimeWidget> createState() => _EndTimeWidgetState();
}

class _EndTimeWidgetState extends State<EndTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "The End Of The Day!",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 18),
          Image.asset('assets/images/plant.png', height: 150, width: 150,),
        ],
      ),
    );
  }
}


class TimeColumn extends StatelessWidget {
  final IconData icon;
  final String time;
  final String label;
  final Color iconColor;

  const TimeColumn({
    Key? key,
    required this.icon,
    required this.time,
    required this.label,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(height: 8),
        Text(
          time,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
