import 'package:growstore/features/auth/models/user_model.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  @observable
  UserModel? user;

  @computed
  bool get isAuthenticated => user != null;

  @action
  void setUser(UserModel newUser) {
    user = newUser;
  }

  @action
  void logout() {
    user = null;
  }
}
