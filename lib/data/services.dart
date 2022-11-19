import 'package:injectable/injectable.dart';

import '../models/food_model.dart';

@LazySingleton()
class Basket {
  static const String link = 'https://run.mocky.io/v3/ec49fec5-7437-46c4-98b3-c4ec823eca77';
  late final Map<int,Food> _basketList = {};

  List<String> ls = [];

  void addItem(int id, String name, double cost, bool isSelected) {
    _basketList.addAll({id : Food(id: id, name: name, cost: cost, isSelected: isSelected)});
  }

  void deleteItem(int id) {
    _basketList.remove(id);
  }

  bool checkItemInBasket(int id) {
    return _basketList.containsKey(id);
  }

  bool checkSelection(int id) {
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