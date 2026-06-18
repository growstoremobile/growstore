import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:growstore/features/auth/dtos/auth_dto.dart';
import 'package:growstore/features/auth/models/user_model.dart';
import 'package:growstore/features/auth/services/auth_service.dart';
import 'package:growstore/features/auth/services/google_auth_service.dart'
    show GoogleAuthService;
import 'package:growstore/shared/utils/constants.dart';

class AuthRepository {
  final AuthService _service;
  final GoogleAuthService _googleAuthService = GoogleAuthService();

  AuthRepository([AuthService? service])
    : _service = service ?? AuthServiceMock();

  Future<bool> createAccount(AuthDto auth) async {
    final success = await _service.createAccount(auth);

    if (success) {
      // Faz o login automático logo após o cadastro para já capturar e salvar o token
      await login(auth);
    }

    return success;
  }

  Future<String> login(AuthDto auth) async {
    final token = await _service.login(auth);

    Constants.userToken = token;
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: 'token_user', value: token);

    return token;
  }

  Future<UserModel> loginWithGoogle() async {
    return await _googleAuthService.signInWithGoogle();
  }

  Future<void> logout() async {
    await _googleAuthService.signOut();

    const secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'token_user');
  }
}
