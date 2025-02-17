class AttendanceModel {
  int? id;
  String? defaultCheckInTime;
  String? checkingTime;
  String? defaultCheckOutTime;
  String? checkoutTime;
  int? leaveId;
  String? workingHours;
  int? employeeId;
  int? managerId;
  String? status;
  String? date;
  String? day;

  AttendanceModel({
    this.id,
    this.defaultCheckInTime,
    this.checkingTime,
    this.defaultCheckOutTime,
    this.checkoutTime,
    this.leaveId,
    this.workingHours,
    this.employeeId,
    this.managerId,
    this.status,
    this.date,
    this.day,
  });

  Map<String, dynamic> toMap() {
    return {
      AttendanceModelFields.ID: id,
      AttendanceModelFields.CHECK_IN_TIME: defaultCheckInTime,
      AttendanceModelFields.CHECKING_TIME: checkingTime,
      AttendanceModelFields.CHECK_OUT_TIME: defaultCheckOutTime,
      AttendanceModelFields.CHECKOUT_TIME: checkoutTime,
      AttendanceModelFields.LEAVE_ID: leaveId,
      AttendanceModelFields.WORKING_HOURS: workingHours,
      AttendanceModelFields.EMPLOYEE_ID: employeeId,
      AttendanceModelFields.MANAGER_ID: managerId,
      AttendanceModelFields.STATUS: status,
      AttendanceModelFields.DATE: date,
      AttendanceModelFields.DAY: day,
    };
  }

  AttendanceModel.fromMap(Map<String, dynamic> map) {
    id = map[AttendanceModelFields.ID];
    defaultCheckInTime = map[AttendanceModelFields.CHECK_IN_TIME];
    checkingTime = map[AttendanceModelFields.CHECKING_TIME];
    defaultCheckOutTime = map[AttendanceModelFields.CHECK_OUT_TIME];
    checkoutTime = map[AttendanceModelFields.CHECKOUT_TIME];
    leaveId = map[AttendanceModelFields.LEAVE_ID];
    workingHours = map[AttendanceModelFields.WORKING_HOURS];
    employeeId = map[AttendanceModelFields.EMPLOYEE_ID];
    managerId = map[AttendanceModelFields.MANAGER_ID];
    status = map[AttendanceModelFields.STATUS];
    date = map[AttendanceModelFields.DATE];
    day = map[AttendanceModelFields.DAY];
  }

  @override
  String toString() {
    return 'AttendanceModel{id: $id, checkInTime: $defaultCheckInTime, checkingTime: $checkingTime, check_out_time: $defaultCheckOutTime, checkout_time: $checkoutTime, leaveId: $leaveId, workingHours: $workingHours, employeeId: $employeeId, managerId: $managerId, status: $status, date: $date, day: $day}';
  }
}

class AttendanceModelFields {
  static const String ID = "id";
  static const String CHECK_IN_TIME = "check_in_time";
  static const String CHECKING_TIME = "checking_time";
  static const String CHECK_OUT_TIME = "check_out_time";
  static const String CHECKOUT_TIME = "checkout_time";
  static const String LEAVE_ID = "leave_id";
  static const String WORKING_HOURS = "working_hours";
  static const String EMPLOYEE_ID = "employee_id";
  static const String MANAGER_ID = "manager_id";
  static const String STATUS = "status";
  static const String DATE = "date";
  static const String DAY = "day";
}
