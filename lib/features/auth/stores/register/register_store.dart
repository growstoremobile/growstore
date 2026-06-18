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
  Future<bool> register(String email, String pass) async {
    try {
      error = null;
      _isLoading = true;

      // Simula o tempo de resposta da API
      await Future.delayed(const Duration(seconds: 2));

      // O Repository fará a criação e o login automático em seguida
      return await _repository.createAccount(AuthDto(email: email, pass: pass));
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
      await Future.delayed(const Duration(seconds: 2));

      currentUser = await _repository.loginWithGoogle();

      return currentUser != null;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    } catch (e) {
      error = 'Não foi possível realizar o login com Google. Tente novamente.';
      return false;
    } finally {
      _isGoogleLoading = false;
    }
  }
}
