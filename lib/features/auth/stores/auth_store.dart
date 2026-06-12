import 'package:growstore/features/auth/models/user_model.dart';
import 'package:mobx/mobx.dart';

import '../services/google_auth_service.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final GoogleAuthService _googleAuthService = GoogleAuthService();

  @observable
  bool isLoading = false;

  @observable
  UserModel? currentUser;

  @observable
  String? errorMessage;

  @action
  Future<void> signInWithGoogle() async {
    isLoading = true;
    errorMessage = null; 

    try {
      currentUser = await _googleAuthService.signInWithGoogle();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
