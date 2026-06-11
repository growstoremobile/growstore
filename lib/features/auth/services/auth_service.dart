import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/dtos/auth_dto.dart';

class AuthService {

  Future<bool> createAccount(AuthDto auth) async {
    // MOCK
    if (auth.email == 'erro@teste.com') {
      throw CustomError('E-mail já cadastrado.');
    }

    return true;
  }

  Future<String> login(AuthDto auth) async {
    // MOCK
    if (auth.email == 'teste@teste.com' && auth.pass == '123456') {
      return 'fake-jwt-token-eyJJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
    }

    throw CustomError('E-mail ou senha inválidos.');
  }
}
