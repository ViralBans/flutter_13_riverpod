import 'package:json_annotation/json_annotation.dart';

part 'fruit_model.g.dart';

@JsonSerializable()
class Fruit {
  final int id;
  final String name;
  final double cost;
  final bool isSelected;

  Fruit({required this.id, required this.name, required this.cost, this.isSelected = false});

  factory Fruit.fromJson(Map<String, dynamic> json) => _$FruitFromJson(json);
  Map<String, dynamic> toJson() => _$FruitToJson(this);
}