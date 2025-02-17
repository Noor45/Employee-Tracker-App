import 'package:office_orbit/manager_portal/screens/manager_dashboard.dart';
import 'package:office_orbit/model/department_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../controller/employee_controller.dart';
import '../employee_portal/screens/main_screen_employee.dart';
import '../manager_portal/screens/main_screen_manager.dart';
import '../model/employee_model.dart';
import '../model/manager_model.dart';
import '../screens/option_screen.dart';
import '../model/user_model.dart';
import '../utils/constants.dart';
import 'helping_funtion.dart';

Future<void> checkEmployeeSession(BuildContext context) async {
  await EmployeeController.getCompany();
  dynamic employeeCheck = await SessionManager().containsKey("emp");
  dynamic managerCheck = await SessionManager().containsKey("mang");
  if (employeeCheck) {
    dynamic userToken = await SessionManager().get("employee_token");
    dynamic employeeDetail = await SessionManager().get("employee_detail");
    dynamic department = await SessionManager().get("department");
    dynamic manager = await SessionManager().get("manager");
    Constants.employeeDetail =
        EmployeeModel.fromMap(employeeDetail as Map<String, dynamic>);
    Constants.employeeDepartment =
        DepartmentModel.fromMap(department as Map<String, dynamic>);
    Constants.employeeManagerDetail =
        ManagerModel.fromMap(manager as Map<String, dynamic>);
    Constants.userId = Constants.employeeDetail!.id!;
    Constants.userToken = userToken;
    Constants.companyToken = Constants.employeeDetail!.companyToken!;
    for (var e in Constants.companyList!) {
      if (Constants.companyToken == e.token!) {
        Constants.companyDetail = e;
      }
    }
    await getEmployeeData();
    Navigator.pushNamedAndRemoveUntil(
        context, EmployeeMainScreen.ID, (r) => false);
  } else if (managerCheck) {
    dynamic userToken = await SessionManager().get("manager_token");
    Constants.userToken = userToken;

    dynamic managerDetail = await SessionManager().get("manager_detail");
    Constants.managerDetail =
        ManagerModel.fromMap(managerDetail as Map<String, dynamic>);

    dynamic department = await SessionManager().get("department");
    Constants.managerDepartment =
        DepartmentModel.fromMap(department as Map<String, dynamic>);

    Constants.userId = Constants.managerDetail!.id!;
    Constants.companyToken = Constants.managerDetail!.companyToken!;

    for (var e in Constants.companyList!) {
      if (Constants.companyToken == e.token!) {
        Constants.companyDetail = e;
      }
    }
    await getManagerData();
    Navigator.pushNamedAndRemoveUntil(
        context, ManagerMainScreen.ID, (r) => false);
  } else {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, OptionScreen.ID);
    });
  }
}
