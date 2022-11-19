import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_model.freezed.dart';

@freezed
class Food with _$Food {
  factory Food({required int id, required String name, required double cost}) = _Food;
}