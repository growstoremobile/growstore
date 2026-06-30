import 'package:growstore/features/address/models/address_model.dart';
import 'package:growstore/features/address/models/cep_model.dart';
import 'package:growstore/features/address/repositories/address_repository.dart';
import 'package:growstore/features/address/services/cep_service.dart';
import 'package:mobx/mobx.dart';

part 'address_store.g.dart';

class AddressStore = AddressStoreBase with _$AddressStore;

abstract class AddressStoreBase with Store {
  AddressStoreBase(this._repository, this._cepService);

  final AddressRepository _repository;
  final CepService _cepService;

  @observable
  ObservableList<AddressModel> addresses = ObservableList<AddressModel>();

  @observable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @observable
  String? error;

  //Buscar cep
  @action
  Future<CepModel?> searchCep(String cep) async {
    try {
      error = null;

      return await _cepService.searchCep(cep);
    } catch (e) {
      error = e.toString();
      return null;
    }
  }

  //Carregar endereços

  @action
  Future<void> loadAddresses() async {
    try {
      error = null;
      _isLoading = true;

      final result = await _repository.getAddresses();

      addresses = ObservableList.of(result);
    } catch (e) {
      error = 'Erro ao carregar endereços.';
    } finally {
      _isLoading = false;
    }
  }

  //Adicionar endereço
  @action
  Future<void> addAddress(AddressModel address) async {
    try {
      error = null;
      _isLoading = true;

      await _repository.saveAddress(address);

      final result = await _repository.getAddresses();

      addresses = ObservableList.of(result);
    } catch (e) {
      error = 'Erro ao salvar endereço.';
    } finally {
      _isLoading = false;
    }
  }

  //Remover endereço
  @action
  Future<void> removeAddress(String id) async {
    try {
      error = null;
      _isLoading = true;

      await _repository.removeAddress(id);

      final result = await _repository.getAddresses();

      addresses = ObservableList.of(result);
    } catch (e) {
      error = 'Erro ao remover endereço.';
    } finally {
      _isLoading = false;
    }
  }

  //Definir endereço padrão
  @action
  Future<void> setDefaultAddress(String id) async {
    await _repository.setDefaultAddress(id);
    await loadAddresses();
  }

  // Encontrar endereço padrão
  @computed
  AddressModel? get defaultAddress {
    try {
      return addresses.firstWhere((a) => a.isDefault);
    } catch (_) {
      return null;
    }
  }
}
