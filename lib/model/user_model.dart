// class UserModel {
//   int? uid;
//   String? companyToken;
//   String? name;
//   String? email;
//   String? image;
//   String? status;
//
//   UserModel({
//     this.uid,
//     this.companyToken,
//     this.name,
//     this.email,
//     this.image,
//     this.status
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       UserModelFields.UID: uid,
//       UserModelFields.NAME: name,
//       UserModelFields.EMAIL: email,
//       UserModelFields.IMAGE: image,
//       UserModelFields.STATUS: status,
//       UserModelFields.COMPANY_TOKEN: companyToken,
//     };
//   }
//
//   UserModel.fromMap(Map<String, dynamic> map) {
//     uid = map[UserModelFields.UID];
//     name = map[UserModelFields.NAME];
//     email = map[UserModelFields.EMAIL];
//     image = map[UserModelFields.IMAGE];
//     status = map[UserModelFields.STATUS];
//     companyToken = map[UserModelFields.COMPANY_TOKEN];
//   }
//
//   @override
//   String toString() {
//     return 'UserModel{id: $uid, name: $name, email: $email, image: $image, status: $status, company_token: $companyToken} ';
//   }
// }
//
// class UserModelFields {
//   static const String UID = "id";
//   static const String NAME = "name";
//   static const String IMAGE = "image";
//   static const String EMAIL = "email";
//   static const String STATUS = "status";
//   static const String COMPANY_TOKEN = "company_token";
// }
