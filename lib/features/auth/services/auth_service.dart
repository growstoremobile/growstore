import 'package:growstore/features/auth/dtos/auth_dto.dart';
import 'package:growstore/features/auth/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _repository;

  AuthService([AuthRepository? repository])
    : _repository = repository ?? AuthRepositoryMock();

  Future<bool> createAccount(AuthDto auth) async {
    return await _repository.createAccount(auth);
  }

  Future<String> login(AuthDto auth) async {
    return await _repository.login(auth);
  }
}
