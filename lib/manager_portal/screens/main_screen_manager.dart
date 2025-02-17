import 'package:office_orbit/manager_portal/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';
import '../../widgets/navBar.dart';
import 'apply_leave.dart';
import 'employee_lists.dart';
import 'manager_dashboard.dart';
import 'history_screen.dart';
import 'leave_detail.dart';
import 'f_mark_attendence.dart';

class ManagerMainScreen extends StatefulWidget {
  static String ID = "/manager_main_screen";
  const ManagerMainScreen({super.key});

  @override
  State<ManagerMainScreen> createState() => _ManagerMainScreenState();
}

class _ManagerMainScreenState extends State<ManagerMainScreen> {
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<dynamic> tabs = [
    ManagerDashboard(),
    HistoryScreen(),
    EmployeeListScreen(),
    // LeaveDetail(),
    ProfileScreen(),
  ];

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Have a good day';
    } else if (hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorRefer.kBackgroundColor,
      body: tabs[_selectedIndex],
      appBar: _selectedIndex == 0
          ? PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Constants.managerDetail?.image != null && Constants.managerDetail?.image!.isEmpty == false
                          ? CircleAvatar(
                        radius:
                        32.5, // Set radius to half of the desired diameter
                        backgroundImage: NetworkImage(
                            '${StringRefer.imagesPath}${Constants.managerDetail!.image!}'),
                        onBackgroundImageError: (_, __) =>
                        const Icon(Icons.error),
                      )
                          : Image.asset('assets/images/user.png'),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, ${Constants.managerDetail!.name!}!',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(getGreetingMessage(),
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // title: Text('Manager Tracker', style: TextStyle(color: ColorRefer.kPrimaryColor, fontWeight: FontWeight.bold)),
                actions: [
                  // IconButton(
                  //   icon: Icon(Icons.notifications_none, color: Colors.grey),
                  //   onPressed: () {},
                  // ),
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.grey),
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ],
              ),
            )
          : null,
      endDrawer:
          _selectedIndex == 0 ? NavDrawer(scaffoldKey: _scaffoldKey) : null,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: ColorRefer.kPrimaryColor,
        ),
        child: BottomNavigationBar(
          key: globalKey,
          currentIndex: _selectedIndex,
          unselectedItemColor: ColorRefer.kGreyColor,
          selectedItemColor: ColorRefer.kPrimaryColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: Icon(Icons.home,
                      color: _selectedIndex == 0
                          ? ColorRefer.kPrimaryColor
                          : ColorRefer.kGreyColor),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: Icon(Icons.history,
                      color: _selectedIndex == 1
                          ? ColorRefer.kPrimaryColor
                          : ColorRefer.kGreyColor),
                ),
                label: 'History'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: Icon(Icons.people,
                      color: _selectedIndex == 2
                          ? ColorRefer.kPrimaryColor
                          : ColorRefer.kGreyColor),
                ),
                label: 'Team'),
            // BottomNavigationBarItem(
            //     icon: Padding(
            //       padding: const EdgeInsets.only(top: 3, bottom: 3),
            //       child: Icon(Icons.edit_note_rounded,
            //           color: _selectedIndex == 2
            //               ? ColorRefer.kPrimaryColor
            //               : ColorRefer.kGreyColor),
            //     ),
            //     label: 'Leaves'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: Icon(Icons.person,
                      color: _selectedIndex == 3
                          ? ColorRefer.kPrimaryColor
                          : ColorRefer.kGreyColor),
                ),
                label: 'Profile'),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      //  floatingActionButton: _selectedIndex == 3 ? FloatingActionButton(
      //    onPressed: (){
      //      Navigator.pushNamed(context, ApplyLeave.ID);
      //    },
      //    backgroundColor: ColorRefer.kPrimaryColor,
      //    tooltip: 'Apply Requests',
      //    elevation: 4.0,
      //    child: const Icon(Icons.add, color: Colors.white),
      //  ) : null,
    );
  }
}
