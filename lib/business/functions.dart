import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../data/services.dart';
import '../models/fruit_model.dart';

@LazySingleton()
class ProductListGenerate {
  late List<Fruit> fl;

  Future<List<Fruit>> getFruitList() async {
    try {
      Response response = await Dio()
          .get(Basket.link);
      fl =
          response.data.map<Fruit>((fruits) => Fruit.fromJson(fruits)).toList();
      return fl;
    } on DioError catch (e) {
      throw Exception(e.error);
    }
  }
}
