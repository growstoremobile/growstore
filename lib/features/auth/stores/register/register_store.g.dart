// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on RegisterStoreBase, Store {
  late final _$currentUserAtom =
      Atom(name: 'RegisterStoreBase.currentUser', context: context);

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
      Atom(name: 'RegisterStoreBase._isGoogleLoading', context: context);

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
      Atom(name: 'RegisterStoreBase._isLoading', context: context);

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

  late final _$errorAtom =
      Atom(name: 'RegisterStoreBase.error', context: context);

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

  late final _$_obscurePasswordAtom =
      Atom(name: 'RegisterStoreBase._obscurePassword', context: context);

  @override
  bool get _obscurePassword {
    _$_obscurePasswordAtom.reportRead();
    return super._obscurePassword;
  }

  @override
  set _obscurePassword(bool value) {
    _$_obscurePasswordAtom.reportWrite(value, super._obscurePassword, () {
      super._obscurePassword = value;
    });
  }

  late final _$_obscureConfirmPasswordAtom =
      Atom(name: 'RegisterStoreBase._obscureConfirmPassword', context: context);

  @override
  bool get _obscureConfirmPassword {
    _$_obscureConfirmPasswordAtom.reportRead();
    return super._obscureConfirmPassword;
  }

  @override
  set _obscureConfirmPassword(bool value) {
    _$_obscureConfirmPasswordAtom
        .reportWrite(value, super._obscureConfirmPassword, () {
      super._obscureConfirmPassword = value;
    });
  }

  late final _$_acceptedTermsAtom =
      Atom(name: 'RegisterStoreBase._acceptedTerms', context: context);

  @override
  bool get _acceptedTerms {
    _$_acceptedTermsAtom.reportRead();
    return super._acceptedTerms;
  }

  @override
  set _acceptedTerms(bool value) {
    _$_acceptedTermsAtom.reportWrite(value, super._acceptedTerms, () {
      super._acceptedTerms = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('RegisterStoreBase.register', context: context);

  @override
  Future<bool> register(String email, String pass) {
    return _$registerAsyncAction.run(() => super.register(email, pass));
  }

  late final _$loginWithGoogleAsyncAction =
      AsyncAction('RegisterStoreBase.loginWithGoogle', context: context);

  @override
  Future<bool> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  late final _$RegisterStoreBaseActionController =
      ActionController(name: 'RegisterStoreBase', context: context);

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleConfirmPasswordVisibility() {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.toggleConfirmPasswordVisibility');
    try {
      return super.toggleConfirmPasswordVisibility();
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAcceptedTerms(bool value) {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.setAcceptedTerms');
    try {
      return super.setAcceptedTerms(value);
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
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
