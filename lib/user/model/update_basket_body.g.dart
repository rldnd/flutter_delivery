// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_basket_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBasketBody _$UpdateBasketBodyFromJson(Map<String, dynamic> json) =>
    UpdateBasketBody(
      basket: (json['basket'] as List<dynamic>)
          .map(
              (e) => UpdateBasketBodyBasket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateBasketBodyToJson(UpdateBasketBody instance) =>
    <String, dynamic>{
      'basket': instance.basket,
    };

UpdateBasketBodyBasket _$UpdateBasketBodyBasketFromJson(
        Map<String, dynamic> json) =>
    UpdateBasketBodyBasket(
      productId: json['productId'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$UpdateBasketBodyBasketToJson(
        UpdateBasketBodyBasket instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'count': instance.count,
    };
