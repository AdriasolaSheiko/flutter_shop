class UserModel {
  final String fullName;
  final String email;
  final String uuid;
  final bool isAdmin;

  UserModel({
    required this.fullName,
    required this.email,
    required this.uuid,
    required this.isAdmin,
  });

  factory UserModel.fromJson(Map json) {
    return UserModel(
      fullName: json['full_name'],
      email: json['email'],
      uuid: json['uuid'],
      isAdmin: json['is_admin'],
    );
  }
}
