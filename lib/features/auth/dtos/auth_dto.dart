class AuthDto {
  final String? name;
  final String email;
  final String pass;

  AuthDto({this.name, required this.email, required this.pass});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'email': email, 'password': pass};
  }
}
