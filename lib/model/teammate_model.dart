class TeammateModel {
  int? id;
  int? projectId;
  int? moduleId;
  int? employeeId;

  TeammateModel({
    this.id,
    this.projectId,
    this.moduleId,
    this.employeeId,
  });

  Map<String, dynamic> toMap() {
    return {
      TeammateModelFields.ID: id,
      TeammateModelFields.PROJECT_ID: projectId,
      TeammateModelFields.MODULE_ID: moduleId,
      TeammateModelFields.EMPLOYEE_ID: employeeId,
    };
  }

  TeammateModel.fromMap(Map<String, dynamic> map) {
    id = map[TeammateModelFields.ID];
    projectId = map[TeammateModelFields.PROJECT_ID];
    moduleId = map[TeammateModelFields.MODULE_ID];
    employeeId = map[TeammateModelFields.EMPLOYEE_ID];
  }

  @override
  String toString() {
    return 'TeammateModel{id: $id, projectId: $projectId, moduleId: $moduleId, employeeId: $employeeId}';
  }
}

class TeammateModelFields {
  static const String ID = "id";
  static const String PROJECT_ID = "project_id";
  static const String MODULE_ID = "modules_id";
  static const String EMPLOYEE_ID = "employee_id";
}
