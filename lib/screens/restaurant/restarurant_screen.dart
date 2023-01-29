import 'package:delivery/screens/restaurant/components/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RestaurantCard(
          imageWidget: Image.asset('assets/images/food/ddeok_bok_gi.jpg',
              fit: BoxFit.cover),
          name: '불타는 떡볶이',
          tags: ['떡볶이', '치즈', '매운맛'],
          ratingCount: 100,
          rating: 4.52,
          deliveryTime: 15,
          deliveryFee: 2000,
        ),
      ),
    );
  }
}
