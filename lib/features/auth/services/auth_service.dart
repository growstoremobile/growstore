import 'package:dio/dio.dart';
import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/dtos/auth_dto.dart';

class AuthService {
  late final Dio _dio;

  AuthService(Dio dio) : _dio = dio;

  Future<bool> createAccount(AuthDto auth) async {
    // TODO: Descomentar quando a API estiver pronta
    // try {
    //   await _dio.post(
    //     '/register',
    //     data: auth.toMap(),
    //   );
    //
    //   return true;
    // } on DioException catch (e) {
    //   throw CustomError(e.response!.data['error']);
    // }

    // MOCK
    if (auth.email == 'erro@teste.com') {
      throw CustomError('E-mail já cadastrado.');
    }

    return true;
  }

  Future<String> login(AuthDto auth) async {
    // TODO: Descomentar quando a API estiver pronta
    // try {
    //   final result = await _dio.post(
    //     '/login',
    //     data: auth.toMap(),
    //   );
    //
    //   return result.data;
    // } on DioException catch (e) {
    //   throw CustomError(e.response!.data['error']);
    // }

    // MOCK
    await Future.delayed(const Duration(seconds: 2)); // Simula tempo de rede

    if (auth.email == 'teste@teste.com' && auth.pass == '123456') {
      return 'fake-jwt-token-eyJJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
    }

    // Simula erro de validação (Credenciais incorretas)
    throw CustomError('E-mail ou senha inválidos.');
  }
}
