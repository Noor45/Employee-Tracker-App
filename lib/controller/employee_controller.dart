import 'dart:convert';
import 'package:office_orbit/model/user_model.dart';
import 'package:office_orbit/model/working_hour_model.dart';
import 'package:http/http.dart' as http;
import '../../api/networkUtils.dart';
import '../model/attendence_model.dart';
import '../model/company_model.dart';
import '../utils/constants.dart';
import 'package:intl/intl.dart';

class EmployeeController {
  static Future<void> getCompany() async {
    try {
      // final response = await NetworkUtil().post('fetch_company');
      var URL = Uri.https('localhost', '/api/general/company/get');
      final res = await http
          .get(
        URL,
      );
      final output = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Constants.companyList?.clear();
        List<dynamic> typeExpense = output['data'];
        for (var element in typeExpense) {
          print(element);
          CompanyModel company = CompanyModel.fromMap(element);
          Constants.companyList!.add(company);
        }
      }
    } catch (e) {
      print('SocketException: ${e}');
    }
  }

  static Future<void> getEmployeeWorkingHours() async {
    try {
      // final response = await NetworkUtil().post('fetch_company');
      var URL = Uri.https('localhost', '/api/employee/working-hours/get');
      final res = await http.get(
          URL,
          headers: {
          'Authorization': 'Bearer ${Constants.userToken}',
        }
      );
      final output = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if(output['data'] != null) Constants.employeeWorkingHours = WorkingHoursModel.fromMap(output['data']);
      }
    } catch (e) {
      print('SocketException: ${e}');
    }
  }

  static Future<void> employeeCheckIn(String defaultTime, String checkInTime, String status) async {
    // try {
      var URL = Uri.https('localhost', '/api/employee/check-in');
      final res = await http.post(
          URL,
          body: {
            'check_in_time': defaultTime.toString(),
            'checking_time': checkInTime.toString(),
            'status': status
          },
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
          }
      );
      final output = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if(output['data'] != null) Constants.attendanceDetail = AttendanceModel.fromMap(output['data']);
      }
    // } catch (e) {
    //   print('SocketException: ${e}');
    // }
  }

  static Future<void> employeeCheckOut(String defaultTime, String checkOutTime, String workingHours) async {
    // try {
      var URL = Uri.https('localhost', '/api/employee/check-out');
      final res = await http.post(
          URL,
          body: {
            'check_out_time': defaultTime.toString(),
            'checkout_time': checkOutTime.toString(),
            'working_hours': workingHours.toString(),
            'id': Constants.attendanceDetail!.id.toString()
          },
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
          }
      );
      final output = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if(output['data'] != null) Constants.attendanceDetail = AttendanceModel.fromMap(output['data']);
      }
    // } catch (e) {
    //   print('SocketException: ${e}');
    // }
  }

  static Future<void> getEmployeeTodayAttendance() async {
    // try {
      // final response = await NetworkUtil().post('fetch_company');
      print(DateFormat('dd-MM-yyyy').format(DateTime.now()));
      var URL = Uri.https('localhost', '/api/employee/attendance/date/fetch');
      final res = await http.post(
          URL,
          body: {
            'date': DateFormat('MM-dd-yyyy').format(DateTime.now())
          },
          headers: {
            'Authorization': 'Bearer ${Constants.userToken}',
          }
      );
      final output = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if(output['data'] != null) Constants.attendanceDetail = AttendanceModel.fromMap(output['data']);
      }
      print(Constants.attendanceDetail);
    // } catch (e) {
    //   print('SocketException: ${e}');
    // }
  }

  static Future<void> logout() async {
    try {
      // final response = await NetworkUtil().post('fetch_company');
      var URL = Uri.https('localhost', '/api/employee/logout');
      final res = await http
          .get(
        URL,
        headers: {
          'Authorization': 'Bearer ${Constants.userToken}',
        }
      );
    } catch (e) {
      print('SocketException: ${e}');
    }
  }
}