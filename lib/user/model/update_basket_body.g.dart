// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_basket_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBasketBody _$UpdateBasketBodyFromJson(Map<String, dynamic> json) =>
    UpdateBasketBody(
      productId: json['productId'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$UpdateBasketBodyToJson(UpdateBasketBody instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'count': instance.count,
    };
