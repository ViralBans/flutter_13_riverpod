import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'functions.dart';

class CountState extends StateNotifier<int> {
  CountState() : super(0);

  void getCount() {
    state = GetIt.I.get<Basket>().ls.length;
  }
}

class ListState extends StateNotifier<List<String>> {
  ListState() : super([]);

  void getList() {
    state = GetIt.I
        .get<Basket>()
        .ls;
  }
}

class BasketState extends StateNotifier<bool> {
  BasketState(): super(true);

  void updateInBasket(int id, String name, double cost) {
    if (GetIt.I.get<Basket>().checkItemInBasket(id)) {
      GetIt.I.get<Basket>().deleteItem(id);
      GetIt.I.get<Basket>().ls.remove(name);
    } else {
      GetIt.I.get<Basket>().addItem(id, name, cost);
      GetIt.I.get<Basket>().ls.add(name);
    }
  }
}

class SelectState extends StateNotifier<bool> {
  SelectState(): super(false);

  void checkSelect(int id) {
    state = GetIt.I.get<Basket>().checkItemInBasket(id);
  }
}
