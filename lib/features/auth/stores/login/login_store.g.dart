// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreBase, Store {
  late final _$currentUserAtom =
      Atom(name: 'LoginStoreBase.currentUser', context: context);

  @override
  UserModel? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(UserModel? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$_isGoogleLoadingAtom =
      Atom(name: 'LoginStoreBase._isGoogleLoading', context: context);

  bool get isGoogleLoading {
    _$_isGoogleLoadingAtom.reportRead();
    return super._isGoogleLoading;
  }

  @override
  bool get _isGoogleLoading => isGoogleLoading;

  @override
  set _isGoogleLoading(bool value) {
    _$_isGoogleLoadingAtom.reportWrite(value, super._isGoogleLoading, () {
      super._isGoogleLoading = value;
    });
  }

  late final _$_isLoadingAtom =
      Atom(name: 'LoginStoreBase._isLoading', context: context);

  bool get isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  bool get _isLoading => isLoading;

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$errorAtom = Atom(name: 'LoginStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$_showPasswordAtom =
      Atom(name: 'LoginStoreBase._showPassword', context: context);

  @override
  bool get _showPassword {
    _$_showPasswordAtom.reportRead();
    return super._showPassword;
  }

  @override
  set _showPassword(bool value) {
    _$_showPasswordAtom.reportWrite(value, super._showPassword, () {
      super._showPassword = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('LoginStoreBase.login', context: context);

  @override
  Future<bool> login(String email, String pass) {
    return _$loginAsyncAction.run(() => super.login(email, pass));
  }

  late final _$loginWithGoogleAsyncAction =
      AsyncAction('LoginStoreBase.loginWithGoogle', context: context);

  @override
  Future<bool> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  late final _$logoutAsyncAction =
      AsyncAction('LoginStoreBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$LoginStoreBaseActionController =
      ActionController(name: 'LoginStoreBase', context: context);

  @override
  void toggleShowPassword() {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.toggleShowPassword');
    try {
      return super.toggleShowPassword();
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
error: ${error}
    ''';
  }
}
