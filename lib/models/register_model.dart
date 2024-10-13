import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  final String fullName;
  final String email;
  final String uuid;
  final bool isAdmin;

  RegisterModel({
    required this.fullName,
    required this.email,
    required this.uuid,
    required this.isAdmin,
  });

  factory RegisterModel.fromJson(Map json) {
    return RegisterModel(
      fullName: json['full_name'],
      email: json['email'],
      uuid: json['uuid'],
      isAdmin: json['is_admin'],
    );
  }

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'email': email,
        'uuid': uuid,
        'is_admin': isAdmin,
      };
}
