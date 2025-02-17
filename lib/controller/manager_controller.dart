import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:office_orbit/model/employee_model.dart';
import 'package:office_orbit/model/manager_team.dart';
import 'package:office_orbit/model/user_model.dart';
import 'package:office_orbit/model/working_hour_model.dart';
import 'package:office_orbit/utils/colors.dart';
import 'package:office_orbit/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api/networkUtils.dart';
import '../model/attendence_model.dart';
import '../model/company_model.dart';
import '../utils/constants.dart';
import 'package:intl/intl.dart';

class ManagerController {
  static Future<void> getCompany() async {
    try {
      // final response = await NetworkUtil().post('fetch_company');
      var URL =
          Uri.https('localhost', '/api/general/company/get');
      final res = await http.get(
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

  static Future<void> getManagerWorkingHours() async {
    try {
      // final response = await NetworkUtil().post('fetch_company');
      var URL = Uri.https(
          'localhost', '/api/manager/working-hours/get');
      final res = await http.get(URL, headers: {
        'Authorization': 'Bearer ${Constants.userToken}',
      }).timeout(const Duration(seconds: 60));
      final output = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (output['data'] != null)
          Constants.managerWorkingHours =
              WorkingHoursModel.fromMap(output['data']);
      }
    } catch (e) {
      print('SocketException: ${e}');
    }
  }

  static Future<void> managerCheckIn(
      String defaultTime, String checkInTime, String status) async {
    // try {
    var URL = Uri.https('localhost', '/api/manager/check-in');
    final res = await http.post(URL, body: {
      'check_in_time': defaultTime.toString(),
      'checking_time': checkInTime.toString(),
      'status': status
    }, headers: {
      'Authorization': 'Bearer ${Constants.userToken}',
    });
    final output = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if (output['data'] != null)
        Constants.attendanceDetail = AttendanceModel.fromMap(output['data']);
    }
    // } catch (e) {
    //   print('SocketException: ${e}');
    // }
  }

  static Future<void> managerCheckOut(
      String defaultTime, String checkOutTime, String workingHours) async {
    // try {
    var URL = Uri.https('localhost', '/api/manager/check-out');
    final res = await http.post(URL, body: {
      'check_out_time': defaultTime.toString(),
      'checkout_time': checkOutTime.toString(),
      'working_hours': workingHours.toString(),
      'id': Constants.attendanceDetail!.id.toString()
    }, headers: {
      'Authorization': 'Bearer ${Constants.userToken}',
    });
    final output = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if (output['data'] != null)
        Constants.attendanceDetail = AttendanceModel.fromMap(output['data']);
    }
    // } catch (e) {
    //   print('SocketException: ${e}');
    // }
  }

  static Future<void> getManagerTodayAttendance() async {
    try {
      // final response = await NetworkUtil().post('fetch_company');
      print(DateFormat('dd-MM-yyyy').format(DateTime.now()));
      var URL = Uri.https(
          'localhost', '/api/manager/attendance/date/fetch');
      final res = await http.post(URL, body: {
        'date': DateFormat('MM-dd-yyyy').format(DateTime.now())
      }, headers: {
        'Authorization': 'Bearer ${Constants.userToken}',
      }).timeout(const Duration(seconds: 60));
      final output = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (output['data'] != null)
          Constants.attendanceDetail = AttendanceModel.fromMap(output['data']);
      }
      print(Constants.attendanceDetail);
    } on http.ClientException catch (e) {
      print('TimeoutException: $e');
    } on SocketException catch (e) {
      print('SocketException: $e');
    } on TimeoutException catch (e) {
      print('SocketException: $e');
    }
  }

  static Future<void> geEmployees() async {
    // try {
    var URL = Uri.https('localhost', '/api/manager/employee');
    final res = await http.get(URL, headers: {
      'Authorization': 'Bearer ${Constants.userToken}',
    }).timeout(const Duration(seconds: 60));

    print(res.body);
    final output = jsonDecode(res.body);
    if (res.statusCode == 200) {
      Constants.teamList?.clear();
      List<dynamic> typeExpense = output['data'];
      for (var element in typeExpense) {
        element['working_hours'] = element['working_hours'] ?? '';
        ManagerTeamModel company = ManagerTeamModel.fromMap(element);
        Constants.teamList!.add(company);
      }
    }
  }

  static Future<void> logout() async {
    try {
      // final response = await NetworkUtil().post('fetch_company');
      var URL = Uri.https('localhost', '/api/manager/logout');
      final res = await http.get(
        URL,
      );
      final output = jsonDecode(res.body);
    } catch (e) {
      print('SocketException: ${e}');
    }
  }
}
