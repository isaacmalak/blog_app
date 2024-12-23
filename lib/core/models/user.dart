class UserModel {
  final String name;
  final String email;
  final String id;

  UserModel({
    required this.name,
    required this.email,
    required this.id,
  });
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? '',
    );
  }
}
