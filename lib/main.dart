import 'package:office_orbit/employee_portal/auth/e_forget_password.dart';
import 'package:office_orbit/employee_portal/auth/e_login.dart';
import 'package:office_orbit/employee_portal/auth/e_signup.dart';
import 'package:office_orbit/employee_portal/screens/daily_task_employee.dart';
import 'package:office_orbit/manager_portal/screens/daily_task_manager.dart';
import 'package:flutter/material.dart';
import 'employee_portal/screens/apply_leave.dart';
import 'employee_portal/screens/main_screen_employee.dart';
import 'employee_portal/screens/f_mark_attendence.dart';
import 'manager_portal/auth/m_forget_password.dart';
import 'manager_portal/auth/m_login.dart';
import 'manager_portal/screens/f_mark_attendence.dart';
import 'manager_portal/screens/main_screen_manager.dart';
import 'screens/option_screen.dart';
import 'screens/term_and_condition.dart';
import 'screens/privacy_policy.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        ManagerForgetPasswordScreen.ID: (_) =>
            const ManagerForgetPasswordScreen(),
        EmployeeForgetPasswordScreen.ID: (_) =>
            const EmployeeForgetPasswordScreen(),
        ManagerSignInScreen.signInScreenID: (context) =>
            const ManagerSignInScreen(),
        EmployeeSignInScreen.signInScreenID: (context) =>
            const EmployeeSignInScreen(),
        OptionScreen.ID: (context) => const OptionScreen(),
        EmployeeMainScreen.ID: (context) => EmployeeMainScreen(),
        ManagerMainScreen.ID: (context) => ManagerMainScreen(),
        EmployeeFullTimeAttendanceScreen.ID: (context) =>
            EmployeeFullTimeAttendanceScreen(),
        ManagerFullTimeAttendanceScreen.ID: (context) =>
            ManagerFullTimeAttendanceScreen(),
        ApplyLeave.ID: (context) => ApplyLeave(),
        ManagerDailyTaskScreen.ID: (context) => ManagerDailyTaskScreen(),
        EmployeeDailyTaskScreen.ID: (context) => EmployeeDailyTaskScreen(),
        TermsAndConditionScreen.ID: (context) => TermsAndConditionScreen(),
        PrivacyAndPolicyScreen.ID: (context) => PrivacyAndPolicyScreen(),
      },
    );
  }
}
