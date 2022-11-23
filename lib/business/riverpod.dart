import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'functions.dart';

class CountState extends StateNotifier<int> {
  CountState() : super(0);

  void getCount() {
    state = GetIt.I.get<Basket>().basket.length;
  }
}

class ListState extends StateNotifier<List<String>> {
  ListState() : super([]);

  void getList() {
    state = GetIt.I.get<Basket>().basket;
  }
}

class BasketState extends StateNotifier<bool> {
  BasketState() : super(true);

  void updateElementInBasket(int id, String name, double cost) {
    if(GetIt.I.get<Basket>().basket.contains(name)) {
      GetIt.I.get<Basket>().basket.remove(name);
      state = false;
    } else {
      GetIt.I.get<Basket>().basket.add(name);
      state = true;
    }
  }
}

class SelectState extends StateNotifier<bool> {
  SelectState() : super(false);

  void updateButton(String s) {
    if(GetIt.I.get<Basket>().select[s] == false) {
      GetIt.I.get<Basket>().select[s] = true;
    } else {
      GetIt.I.get<Basket>().select[s] = false;
    }
    bool? get = GetIt.I.get<Basket>().select[s];
    state = get!;
  }
}
