import 'package:delivery/screens/restaurant/list/restaurant_card.dart';
import 'package:delivery/utils/constants/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> getPaginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN);
    final response = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );

    return response.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List>(
          future: getPaginateRestaurant(),
          builder: (context, snapshot) {
            print(snapshot.error);
            print(snapshot.data);

            return RestaurantCard(
              imageWidget: Image.asset('assets/images/food/ddeok_bok_gi.jpg',
                  fit: BoxFit.cover),
              name: '불타는 떡볶이',
              tags: ['떡볶이', '치즈', '매운맛'],
              ratingsCount: 100,
              ratings: 4.52,
              deliveryTime: 15,
              deliveryFee: 2000,
            );
          },
        ),
      ),
    );
  }
}
