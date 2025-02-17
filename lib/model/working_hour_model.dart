class WorkingHoursModel {
  int? id;
  int? employeeId;
  int? managerId;
  String? type;
  String? startTime;
  String? endTime;
  String? startBreakTime;
  String? endBreakTime;
  String? partType;
  String? startPartTime;
  String? endPartTime;

  WorkingHoursModel({
    this.id,
    this.employeeId,
    this.managerId,
    this.type,
    this.startTime,
    this.endTime,
    this.startBreakTime,
    this.endBreakTime,
    this.partType,
    this.startPartTime,
    this.endPartTime,
  });

  Map<String, dynamic> toMap() {
    return {
      WorkingHoursModelFields.ID: id,
      WorkingHoursModelFields.EMPLOYEE_ID: employeeId,
      WorkingHoursModelFields.MANAGER_ID: managerId,
      WorkingHoursModelFields.TYPE: type,
      WorkingHoursModelFields.START_TIME: startTime,
      WorkingHoursModelFields.END_TIME: endTime,
      WorkingHoursModelFields.START_BREAK_TIME: startBreakTime,
      WorkingHoursModelFields.END_BREAK_TIME: endBreakTime,
      WorkingHoursModelFields.PART_TYPE: partType,
      WorkingHoursModelFields.START_PART_TIME: startPartTime,
      WorkingHoursModelFields.END_PART_TIME: endPartTime,
    };
  }

  WorkingHoursModel.fromMap(Map<String, dynamic> map) {
    id = map[WorkingHoursModelFields.ID];
    employeeId = map[WorkingHoursModelFields.EMPLOYEE_ID];
    managerId = map[WorkingHoursModelFields.MANAGER_ID];
    type = map[WorkingHoursModelFields.TYPE];
    startTime = map[WorkingHoursModelFields.START_TIME];
    endTime = map[WorkingHoursModelFields.END_TIME];
    startBreakTime = map[WorkingHoursModelFields.START_BREAK_TIME];
    endBreakTime = map[WorkingHoursModelFields.END_BREAK_TIME];
    partType = map[WorkingHoursModelFields.PART_TYPE];
    startPartTime = map[WorkingHoursModelFields.START_PART_TIME];
    endPartTime = map[WorkingHoursModelFields.END_PART_TIME];
  }

  @override
  String toString() {
    return 'WorkingHoursModel{id: $id, employeeId: $employeeId, managerId: $managerId, type: $type, startTime: $startTime, endTime: $endTime, startBreakTime: $startBreakTime, endBreakTime: $endBreakTime, partType: $partType, startPartTime: $startPartTime, endPartTime: $endPartTime}';
  }
}

class WorkingHoursModelFields {
  static const String ID = "id";
  static const String EMPLOYEE_ID = "employee_id";
  static const String MANAGER_ID = "manager_id";
  static const String TYPE = "type";
  static const String START_TIME = "startTime";
  static const String END_TIME = "endTime";
  static const String START_BREAK_TIME = "startBreakTime";
  static const String END_BREAK_TIME = "endBreakTime";
  static const String PART_TYPE = "partType";
  static const String START_PART_TIME = "startpartTime";
  static const String END_PART_TIME = "endpartTime";
}
