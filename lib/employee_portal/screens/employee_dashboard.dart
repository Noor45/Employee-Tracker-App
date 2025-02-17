import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:office_orbit/employee_portal/screens/daily_task_employee.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'f_mark_attendence.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     CircleAvatar(
            //       radius: 30,
            //       backgroundImage: AssetImage('assets/images/user.png'), // Add your avatar image
            //     ),
            //     SizedBox(width: 10),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Hi, ${Constants.employeeDetail!.name!}!',
            //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //         ),
            //         Text('Good Morning', style: TextStyle(color: Colors.grey)),
            //       ],
            //     ),
            //   ],
            // ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/images/banner.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildGridItem(Icons.fingerprint, 'Attendance', () {
                  if(Constants.employeeWorkingHours == null){
                    showNetWorkError('Network Error', 'Poor connection signal, Try again later.');
                  } else if (Constants.companyDetail == null){
                    showNetWorkError('Network Error', 'Poor connection signal, Try again later.');
                  } else{
                    Navigator.pushNamed(
                        context, EmployeeFullTimeAttendanceScreen.ID);
                  }
                  // Constants.employeeWorkingHours
                  // Constants.companyDetail

                }),
                _buildGridItem(CupertinoIcons.list_bullet, 'Daily Tasks', () {
                  Navigator.pushNamed(context, EmployeeDailyTaskScreen.ID);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showNetWorkError(title, message){
    MotionToast(
      icon: CupertinoIcons.info,
      primaryColor: Colors.redAccent,
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

  Widget _buildGridItem(IconData icon, String label, Function? onTap) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: ColorRefer.kPrimaryColor),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(fontSize: 16, color: ColorRefer.kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
