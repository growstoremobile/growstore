import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/dtos/auth_dto.dart';
import 'package:growstore/features/auth/models/user_model.dart';
import 'package:growstore/features/auth/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  RegisterStoreBase([AuthRepository? repository])
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
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  @observable
  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  @observable
  bool _acceptedTerms = false;
  bool get acceptedTerms => _acceptedTerms;

  @action
  void togglePasswordVisibility() => _obscurePassword = !_obscurePassword;

  @action
  void toggleConfirmPasswordVisibility() =>
      _obscureConfirmPassword = !_obscureConfirmPassword;

  @action
  void setAcceptedTerms(bool value) => _acceptedTerms = value;

  @action
  Future<bool> register(String name, String email, String pass) async {
    try {
      error = null;
      _isLoading = true;

      currentUser = await _repository.createAccount(
        AuthDto(name: name.trim(), email: email.trim(), pass: pass),
      );

      return currentUser != null;
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
}
