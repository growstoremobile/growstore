import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/dtos/auth_dto.dart';
import 'package:growstore/features/auth/models/user_model.dart';
import 'package:growstore/features/auth/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  LoginStoreBase([AuthRepository? repository])
    : _repository = repository ?? AuthRepository();

  final AuthRepository _repository;

  @observable
  UserModel? currentUser;

  @readonly
  bool _isGoogleLoading = false;

  @readonly
  bool _isLoading = false;

  @observable
  String? error;

  @observable
  bool _showPassword = false;
  bool get showPassword => _showPassword;

  @action
  void toggleShowPassword() => _showPassword = !_showPassword;

  @action
  Future<bool> login(String email, String pass) async {
    try {
      error = null;
      _isLoading = true;

      currentUser = await _repository.login(
        AuthDto(email: email.trim(), pass: pass),
      );

      return true;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    } finally {
      _isLoading = false;
    }
  }

  @action
  Future<bool> loginWithGoogle() async {
    try {
      error = null;
      _isGoogleLoading = true;

      currentUser = await _repository.loginWithGoogle();

      return currentUser != null;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    } catch (_) {
      error = 'Nao foi possivel realizar o login com Google. Tente novamente.';
      return false;
    } finally {
      _isGoogleLoading = false;
    }
  }

  @action
  Future<void> logout() async {
    await _repository.logout();

    currentUser = null;
    error = null;
  }
}
