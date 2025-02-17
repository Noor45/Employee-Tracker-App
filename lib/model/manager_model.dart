class ManagerModel {
  int? id;
  int? departmentId;
  String? name;
  String? email;
  String? password;
  String? image;
  String? status;
  String? joinDate;
  String? endDate;
  String? companyToken;
  String? recoverPasswordOpt;

  ManagerModel({
    this.id,
    this.departmentId,
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
      ManagerModelFields.ID: id,
      ManagerModelFields.DEPARTMENT_ID: departmentId,
      ManagerModelFields.NAME: name,
      ManagerModelFields.EMAIL: email,
      ManagerModelFields.PASSWORD: password,
      ManagerModelFields.IMAGE: image,
      ManagerModelFields.STATUS: status,
      ManagerModelFields.JOIN_DATE: joinDate,
      ManagerModelFields.END_DATE: endDate,
      ManagerModelFields.COMPANY_TOKEN: companyToken,
      ManagerModelFields.RECOVER_PASSWORD_OPT: recoverPasswordOpt,
    };
  }

  ManagerModel.fromMap(Map<String, dynamic> map) {
    id = map[ManagerModelFields.ID];
    departmentId = map[ManagerModelFields.DEPARTMENT_ID];
    name = map[ManagerModelFields.NAME];
    email = map[ManagerModelFields.EMAIL];
    password = map[ManagerModelFields.PASSWORD];
    image = map[ManagerModelFields.IMAGE];
    status = map[ManagerModelFields.STATUS];
    joinDate = map[ManagerModelFields.JOIN_DATE];
    endDate = map[ManagerModelFields.END_DATE];
    companyToken = map[ManagerModelFields.COMPANY_TOKEN];
    recoverPasswordOpt = map[ManagerModelFields.RECOVER_PASSWORD_OPT];
  }

  @override
  String toString() {
    return 'ManagerModel{id: $id, departmentId: $departmentId, name: $name, email: $email, password: $password, image: $image, status: $status, joinDate: $joinDate, endDate: $endDate, recoverPasswordOpt: $recoverPasswordOpt, company_token: $companyToken}';
  }
}

class ManagerModelFields {
  static const String ID = "id";
  static const String DEPARTMENT_ID = "department_id";
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
