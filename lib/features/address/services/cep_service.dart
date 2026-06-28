import 'package:dio/dio.dart';
import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/address/models/cep_model.dart';

abstract class CepService {
  Future<CepModel> searchCep(String cep);
}

class ViaCepService implements CepService {
  final Dio dio;

  ViaCepService(this.dio);

  @override
  Future<CepModel> searchCep(String cep) async {
    try {
      final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');

      final response = await dio.get(
        'https://viacep.com.br/ws/$cleanCep/json/',
      );

      if (response.data['erro'] == true) {
        throw CustomError('CEP não encontrado.');
      }

      return CepModel.fromJson(response.data);
    } on DioException {
      throw CustomError('Não foi possível consultar o CEP.');
    }
  }
}
