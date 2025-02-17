class EmployeeModel {
  int? id;
  int? departmentId;
  int? managerId;
  String? name;
  String? email;
  String? password;
  String? image;
  String? status;
  String? joinDate;
  String? endDate;
  String? companyToken;
  String? recoverPasswordOpt;

  EmployeeModel({
    this.id,
    this.departmentId,
    this.managerId,
    this.companyToken,
    this.name,
    this.email,
    this.password,
    this.image,
    this.status,
    this.joinDate,
    this.endDate,
    this.recoverPasswordOpt,
  });

  Map<String, dynamic> toMap() {
    return {
      EmployeeModelFields.ID: id,
      EmployeeModelFields.DEPARTMENT_ID: departmentId,
      EmployeeModelFields.MANAGER_ID: managerId,
      EmployeeModelFields.NAME: name,
      EmployeeModelFields.EMAIL: email,
      EmployeeModelFields.PASSWORD: password,
      EmployeeModelFields.IMAGE: image,
      EmployeeModelFields.STATUS: status,
      EmployeeModelFields.JOIN_DATE: joinDate,
      EmployeeModelFields.END_DATE: endDate,
      EmployeeModelFields.COMPANY_TOKEN: companyToken,
      EmployeeModelFields.RECOVER_PASSWORD_OPT: recoverPasswordOpt,
    };
  }

  EmployeeModel.fromMap(Map<String, dynamic> map) {
    id = map[EmployeeModelFields.ID];
    departmentId = map[EmployeeModelFields.DEPARTMENT_ID];
    managerId = map[EmployeeModelFields.MANAGER_ID];
    name = map[EmployeeModelFields.NAME];
    email = map[EmployeeModelFields.EMAIL];
    password = map[EmployeeModelFields.PASSWORD];
    image = map[EmployeeModelFields.IMAGE];
    status = map[EmployeeModelFields.STATUS];
    joinDate = map[EmployeeModelFields.JOIN_DATE];
    endDate = map[EmployeeModelFields.END_DATE];
    companyToken = map[EmployeeModelFields.COMPANY_TOKEN];
    recoverPasswordOpt = map[EmployeeModelFields.RECOVER_PASSWORD_OPT];
  }

  @override
  String toString() {
    return 'EmployeeModel{id: $id, departmentId: $departmentId, managerId: $managerId, name: $name, email: $email, password: $password, image: $image, status: $status, joinDate: $joinDate, endDate: $endDate, recoverPasswordOpt: $recoverPasswordOpt, company_token: $companyToken}';
  }
}

class EmployeeModelFields {
  static const String ID = "id";
  static const String DEPARTMENT_ID = "department_id";
  static const String MANAGER_ID = "manager_id";
  static const String NAME = "name";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";
  static const String IMAGE = "image";
  static const String STATUS = "status";
  static const String JOIN_DATE = "join_date";
  static const String END_DATE = "end_date";
  static const String COMPANY_TOKEN = "company_token";
  static const String RECOVER_PASSWORD_OPT = "recover_password_opt";
}
