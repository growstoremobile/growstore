import 'dart:convert';
import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/dtos/auth_dto.dart';

abstract class AuthService {
  Future<bool> createAccount(AuthDto auth);
  Future<String> login(AuthDto auth);
}

class AuthServiceMock implements AuthService {
  static final List<AuthDto> _mockDatabase = [
    AuthDto(email: 'teste@teste.com', pass: '123456'),
  ];

  @override
  Future<bool> createAccount(AuthDto auth) async {
    final emailExists = _mockDatabase.any((user) => user.email == auth.email);
    if (emailExists) {
      throw CustomError('E-mail já cadastrado.');
    }

    _mockDatabase.add(auth);
    return true;
  }

  @override
  Future<String> login(AuthDto auth) async {
    final isValidUser = _mockDatabase.any(
      (user) => user.email == auth.email && user.pass == auth.pass,
    );
    if (isValidUser) {
      // Cria um mock com estrutura similar a um JWT contendo o e-mail no payload
      final header = base64UrlEncode(
        utf8.encode('{"alg":"HS256","typ":"JWT"}'),
      );
      final payload = base64UrlEncode(utf8.encode('{"email":"${auth.email}"}'));

      return '$header.$payload.mock_signature';
    }

    throw CustomError('E-mail ou senha inválidos.');
  }
}
