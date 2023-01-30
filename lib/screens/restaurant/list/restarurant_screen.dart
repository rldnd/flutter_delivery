import 'package:delivery/models/restaurant/restaurant_model.dart';
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
            if (!snapshot.hasData) {
              return Container();
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                final parsedItem = RestaurantModel.fromJson(json: item);

                return RestaurantCard.fromModel(model: parsedItem);
              },
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16.0);
              },
            );
          },
        ),
      ),
    );
  }
}
