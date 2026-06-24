class UserModel {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.photoUrl,
  });
}
