import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/dtos/auth_dto.dart';
import 'package:growstore/features/auth/services/auth_service.dart';
import 'package:growstore/shared/utils/constants.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  @action
  Future<bool> login(String email, String pass) async {
    try {
      error = null;
      isLoading = true;

      final service = AuthService();
      final tokenUser = await service.login(AuthDto(email: email, pass: pass));

      Constants.userToken = tokenUser;

      const secureStorage = FlutterSecureStorage();
      await secureStorage.write(key: 'token_user', value: tokenUser);

      return true;
    } on CustomError catch (e) {
      error = e.message;
      return false;
    } finally {
      isLoading = false;
    }
  }
}
