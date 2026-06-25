import 'package:growstore/features/auth/dtos/auth_dto.dart';
import 'package:growstore/features/auth/models/user_model.dart';
import 'package:growstore/features/auth/services/auth_service.dart';
import 'package:growstore/features/auth/services/google_auth_service.dart';
import 'package:growstore/shared/utils/constants.dart';
import 'package:hive/hive.dart';

class AuthRepository {
  AuthRepository([AuthService? service])
    : _service = service ?? FirebaseAuthService();

  final AuthService _service;
  final GoogleAuthService _googleAuthService = GoogleAuthService();

  Future<UserModel> createAccount(AuthDto auth) async {
    final user = await _service.createAccount(auth);
    await _persistSession(user, await _service.getToken());

    return user;
  }

  Future<UserModel> login(AuthDto auth) async {
    final user = await _service.login(auth);
    await _persistSession(user, await _service.getToken());

    return user;
  }

  Future<UserModel> loginWithGoogle() async {
    final user = await _googleAuthService.signInWithGoogle();
    await _persistSession(user, await _service.getToken());

    return user;
  }

  Future<void> logout() async {
    try {
      await _service.logout();
      await _googleAuthService.signOut();
    } finally {
      Constants.userToken = '';
      final authBox = await Hive.openBox('auth');
      await authBox.delete('token_user');
      await authBox.delete('user_id');
      await authBox.delete('user_name');
      await authBox.delete('user_email');
      await authBox.delete('user_photo_url');
    }
  }

  Future<void> _persistSession(UserModel user, String token) async {
    Constants.userToken = token;

    final authBox = await Hive.openBox('auth');
    await authBox.put('token_user', token);
    await authBox.put('user_id', user.id);
    await authBox.put('user_name', user.name);
    await authBox.put('user_email', user.email);
    await authBox.put('user_photo_url', user.photoUrl);
  }
}
