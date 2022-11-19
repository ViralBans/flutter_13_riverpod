import 'package:injectable/injectable.dart';

import '../models/product_model.dart';

@LazySingleton()
class Basket {
  late final Map<int,Product> _basketList = {};

  // Список наименований товаров в корзине
  List<String> ls = [];

  void addItem(int id, String name, double cost) {
    _basketList.addAll({id : Product(id: id, name: name, cost: cost, isSelected: true)});
  }

  void deleteItem(int id) {
    _basketList.remove(id);
  }

  bool checkItemInBasket(int id) {
    if(_basketList.containsKey(id)) {
      return _basketList[id]!.isSelected;
    } else {
      return false;
    }
  }

  int getBasketItems() {
    return _basketList.length;
  }
}