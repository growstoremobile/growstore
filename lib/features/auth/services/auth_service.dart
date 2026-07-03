import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/dtos/auth_dto.dart';
import 'package:growstore/features/auth/models/user_model.dart';

abstract class AuthService {
  Future<UserModel> createAccount(AuthDto auth);
  Future<UserModel> login(AuthDto auth);
  Future<String> getToken();
  Future<void> logout();
}

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<UserModel> createAccount(AuthDto auth) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: auth.email.trim(),
        password: auth.pass,
      );

      final user = credential.user;
      if (user == null) {
        throw CustomError('Nao foi possivel criar sua conta.');
      }

      final displayName = auth.name?.trim();
      if (displayName != null && displayName.isNotEmpty) {
        await user.updateDisplayName(displayName);
        await user.reload();
      }

      return _mapFirebaseUser(_firebaseAuth.currentUser ?? user);
    } on FirebaseAuthException catch (e) {
      throw CustomError(_mapFirebaseError(e));
    }
  }

  @override
  Future<UserModel> login(AuthDto auth) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: auth.email.trim(),
        password: auth.pass,
      );

      final user = credential.user;
      if (user == null) {
        throw CustomError('Nao foi possivel obter os dados do usuario.');
      }

      return _mapFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw CustomError(_mapFirebaseError(e));
    }
  }

  @override
  Future<String> getToken() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    if (token == null || token.isEmpty) {
      throw CustomError('Sessao invalida. Faca login novamente.');
    }

    return token;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  UserModel _mapFirebaseUser(User user) {
    final email = user.email ?? '';

    return UserModel(
      id: user.uid,
      name: (user.displayName?.trim().isNotEmpty ?? false)
          ? user.displayName!.trim()
          : email,
      email: email,
      photoUrl: user.photoURL,
    );
  }

  String _mapFirebaseError(FirebaseAuthException error) {
    return switch (error.code) {
      'email-already-in-use' => 'E-mail ja cadastrado.',
      'invalid-email' => 'E-mail invalido.',
      'operation-not-allowed' =>
        'Cadastro por e-mail e senha nao esta habilitado no Firebase.',
      'weak-password' => 'A senha deve ter pelo menos 6 caracteres.',
      'user-disabled' => 'Usuario desabilitado.',
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => 'E-mail ou senha invalidos.',
      'network-request-failed' =>
        'Falha de conexao. Verifique sua internet e tente novamente.',
      _ => 'Nao foi possivel autenticar. Tente novamente.',
    };
  }
}

class AuthServiceMock implements AuthService {
  static final List<AuthDto> _mockDatabase = [
    AuthDto(name: 'Usuario Teste', email: 'teste@teste.com', pass: '123456'),
  ];

  AuthDto? _currentUser;

  @override
  Future<UserModel> createAccount(AuthDto auth) async {
    final emailExists = _mockDatabase.any((user) => user.email == auth.email);
    if (emailExists) {
      throw CustomError('E-mail ja cadastrado.');
    }

    _mockDatabase.add(auth);
    _currentUser = auth;

    return _mapMockUser(auth);
  }

  @override
  Future<UserModel> login(AuthDto auth) async {
    AuthDto? user;
    for (final candidate in _mockDatabase) {
      if (candidate.email == auth.email && candidate.pass == auth.pass) {
        user = candidate;
        break;
      }
    }

    if (user == null) {
      throw CustomError('E-mail ou senha invalidos.');
    }

    _currentUser = user;
    return _mapMockUser(user);
  }

  @override
  Future<String> getToken() async {
    final user = _currentUser;

    if (user == null) {
      throw CustomError('Sessao invalida. Faca login novamente.');
    }

    final header = base64UrlEncode(utf8.encode('{"alg":"HS256","typ":"JWT"}'));
    final payload = base64UrlEncode(utf8.encode('{"email":"${user.email}"}'));

    return '$header.$payload.mock_signature';
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
  }

  UserModel _mapMockUser(AuthDto auth) {
    return UserModel(
      id: auth.email,
      name: auth.name?.trim().isNotEmpty ?? false
          ? auth.name!.trim()
          : auth.email,
      email: auth.email,
    );
  }
}
