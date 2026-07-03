import 'package:mobx/mobx.dart';

part 'payment_store.g.dart';

enum PaymentMethod {
  pix,
  card,
}

class PaymentStore = PaymentStoreBase with _$PaymentStore;

abstract class PaymentStoreBase with Store {

  @observable
  PaymentMethod selectedMethod = PaymentMethod.pix;

  @action
  void selectMethod(PaymentMethod method) {
    selectedMethod = method;
  }
}