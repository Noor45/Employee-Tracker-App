class DepartmentModel {
  int? id;
  String? name;
  String? status;

  DepartmentModel({
    this.id,
    this.name,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      DepartmentModelFields.ID: id,
      DepartmentModelFields.NAME: name,
      DepartmentModelFields.STATUS: status,
    };
  }

  DepartmentModel.fromMap(Map<String, dynamic> map) {
    id = map[DepartmentModelFields.ID];
    name = map[DepartmentModelFields.NAME];
    status = map[DepartmentModelFields.STATUS];
  }

  @override
  String toString() {
    return 'DepartmentModel{id: $id, name: $name, status: $status}';
  }
}

class DepartmentModelFields {
  static const String ID = "id";
  static const String NAME = "name";
  static const String STATUS = "status";
}
