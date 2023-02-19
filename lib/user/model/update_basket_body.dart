import 'package:json_annotation/json_annotation.dart';

part 'update_basket_body.g.dart';

@JsonSerializable()
class UpdateBasketBody {
  final List<UpdateBasketBodyBasket> basket;

  UpdateBasketBody({required this.basket});

  Map<String, dynamic> toJson() => _$UpdateBasketBodyToJson(this);
}

@JsonSerializable()
class UpdateBasketBodyBasket {
  final String productId;
  final int count;

  UpdateBasketBodyBasket({required this.productId, required this.count});

  factory UpdateBasketBodyBasket.fromJson(Map<String, dynamic> json) =>
      _$UpdateBasketBodyBasketFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBasketBodyBasketToJson(this);
}
