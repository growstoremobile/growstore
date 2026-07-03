import 'package:mobx/mobx.dart';

part 'navigation_store.g.dart';

class NavigationStore = NavigationStoreBase with _$NavigationStore;

abstract class NavigationStoreBase with Store {
  @observable
  int currentIndex = 0;

  @action
  void changePage(int index) {
    currentIndex = index;
  }
}