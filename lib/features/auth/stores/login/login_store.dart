import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/dtos/auth_dto.dart';
import 'package:growstore/features/auth/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  LoginStoreBase([AuthRepository? repository])
    : _repository = repository ?? AuthRepository();

  final AuthRepository _repository;

  @observable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

      // Simula o tempo de resposta da API
      await Future.delayed(const Duration(seconds: 2));

      await _repository.login(AuthDto(email: email, pass: pass));

      return true;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    } finally {
      _isLoading = false;
    }
  }
}
