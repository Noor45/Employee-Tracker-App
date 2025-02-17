class CompanyModel {
  int? id;
  String? name;
  String? email;
  String? image;
  String? token;
  String? password;
  String? description;
  String? recover_password_opt;
  String? coordinates;
  String? created_at;
  String? updated_at;

  CompanyModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.password,
    this.token,
    this.description,
    this.recover_password_opt,
    this.coordinates,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      CompanyModelFields.ID: id,
      CompanyModelFields.NAME: name,
      CompanyModelFields.EMAIL: email,
      CompanyModelFields.IMAGE: image,
      CompanyModelFields.PASSWORD: password,
      CompanyModelFields.RECOVER_PASSWORD_OTP: recover_password_opt,
      CompanyModelFields.TOKEN: token,
      CompanyModelFields.DESCRIPTION: description,
      CompanyModelFields.COORDINATES: coordinates,
      CompanyModelFields.CREATED_AT: created_at,
      CompanyModelFields.UPDATED_AT: updated_at,
    };
  }

  CompanyModel.fromMap(Map<String, dynamic> map) {
    id = map[CompanyModelFields.ID];
    name = map[CompanyModelFields.NAME];
    email = map[CompanyModelFields.EMAIL];
    image = map[CompanyModelFields.IMAGE];
    token = map[CompanyModelFields.TOKEN];
    recover_password_opt = map[CompanyModelFields.RECOVER_PASSWORD_OTP];
    created_at = map[CompanyModelFields.CREATED_AT];
    updated_at = map[CompanyModelFields.UPDATED_AT];
    coordinates = map[CompanyModelFields.COORDINATES];
    description = map[CompanyModelFields.DESCRIPTION];
  }

  @override
  String toString() {
    return 'CompanyModel{id: $id, name: $name, token: $token, email: $email, image: $image, password: $password, coordinates: $coordinates, recover_password_opt: $recover_password_opt, description: $description,  created_at: $created_at,  updated_at: $updated_at} ';
  }
}

class CompanyModelFields {
  static const String ID = "id";
  static const String NAME = "name";
  static const String IMAGE = "image";
  static const String EMAIL = "email";
  static const String TOKEN = "token";
  static const String PASSWORD = "password";
  static const String COORDINATES = "coordinates";
  static const String RECOVER_PASSWORD_OTP = "recover_password_opt";
  static const String DESCRIPTION = "description";
  static const String CREATED_AT = "created_at";
  static const String UPDATED_AT = "updated_at";
}
