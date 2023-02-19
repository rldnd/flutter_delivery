import 'package:json_annotation/json_annotation.dart';

part 'update_basket_body.g.dart';

@JsonSerializable()
class UpdateBasketBody {
  final String productId;
  final int count;

  UpdateBasketBody({required this.productId, required this.count});

  Map<String, dynamic> toJson() => _$UpdateBasketBodyToJson(this);
}
