import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/dtos/auth_dto.dart';
import 'package:growstore/features/auth/models/user_model.dart';
import 'package:growstore/features/auth/services/auth_service.dart';
import 'package:growstore/features/auth/services/google_auth_service.dart'
    show GoogleAuthService;
import 'package:growstore/shared/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthRepository {
  final AuthService _service;
  final GoogleAuthService _googleAuthService = GoogleAuthService();

  AuthRepository([AuthService? service])
    : _service = service ?? AuthServiceMock();

  Future<UserModel?> createAccount(AuthDto auth) async {
    final success = await _service.createAccount(auth);

    // Salva os dados do usuário localmente no Hive após o cadastro
    if (success) {
      final userBox = await Hive.openBox<UserModel>('user_box');
      await userBox.put(
        auth.email,
        UserModel(
          id: 'local_${auth.email}',
          name: auth.name!,
          email: auth.email,
          password: auth.pass,
        ),
      );
    }

    if (success) {
      // Faz o login automático logo após o cadastro para já capturar e salvar o token
      // e retorna o usuário.
      return await login(auth);
    }
    return null;
  }

  Future<UserModel> login(AuthDto auth) async {
    final token = await _service.login(auth);

    Constants.userToken = token;
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: 'token_user', value: token);

    // Busca o usuário salvo localmente no Hive
    final userBox = await Hive.openBox<UserModel>('user_box');
    final user = userBox.get(auth.email);

    if (user != null) {
      return user;
    }

    // Fallback caso o usuário não seja encontrado no Hive (cenário improvável se o cadastro funcionar)
    throw CustomError(
      'Usuário não encontrado localmente. '
      'Por favor, tente fazer o cadastro novamente.',
    );
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
