import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String email;
  String? password;
  String? token;
  String? finalMessage;
  UserModel({
    required this.email,
    this.id,
    this.name,
    this.password,
    this.token,
    this.finalMessage,
  });

  String toJson() {
    return jsonEncode({
      if (id != null || id != '') "id": id,
      if (name != null || name != '') "name": name,
      "email": email,
      if (password != null || password != '') "password": password,
      if (token != null || token != '') "token": token,
      if (finalMessage != null || token != '') "finalMessage": finalMessage,
    });
  }

  factory UserModel.fromMap(Map map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] as String,
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      finalMessage: map['_final_message'] ?? '',
    );
  }

  @override
  String toString() {
    return "UserModel(name: $name, email: $email, final_message: $finalMessage)";
  }
}
