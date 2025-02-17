import 'dart:ui';

import 'package:office_orbit/model/department_model.dart';
import 'package:office_orbit/model/manager_team.dart';
import 'package:office_orbit/widgets/dialogs.dart';

import '../model/attendence_model.dart';
import '../model/company_model.dart';
import '../model/employee_model.dart';
import '../model/manager_model.dart';
import '../model/working_hour_model.dart';

class Constants {
  static int? userId;
  static String? userToken;
  static String? companyToken;
  static String? token = '';
  static EmployeeModel? employeeDetail;
  static ManagerModel? managerDetail;
  static ManagerModel? employeeManagerDetail;
  static DepartmentModel? managerDepartment;
  static DepartmentModel? employeeDepartment;
  static WorkingHoursModel? employeeWorkingHours;
  static WorkingHoursModel? managerWorkingHours;
  static AttendanceModel? attendanceDetail;
  static CompanyModel? companyDetail;
  static List<CompanyModel>? companyList = [];
  static List<ManagerTeamModel>? teamList = [];
}

clear() {
  Constants.userId;
  Constants.employeeDetail = EmployeeModel();
  Constants.managerDetail = ManagerModel();
  Constants.token = '';
  Constants.employeeWorkingHours = WorkingHoursModel();
  Constants.managerWorkingHours = WorkingHoursModel();
  Constants.attendanceDetail = null;
  Constants.companyDetail = null;
  Constants.teamList = [];
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (this.isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
