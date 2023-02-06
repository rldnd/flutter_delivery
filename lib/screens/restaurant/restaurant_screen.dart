import 'package:delivery/common/dio.dart';
import 'package:delivery/models/restaurant/restaurant_model.dart';
import 'package:delivery/repository/restaurant_repository.dart';
import 'package:delivery/screens/restaurant/restaurant_detail_screen.dart';
import 'package:delivery/screens/restaurant/_shared/restaurant_card.dart';
import 'package:delivery/utils/constants/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> getPaginateRestaurant() async {
    final dio = Dio();
    dio.interceptors.add(CustomInterceptor(storage: storage));

    final response =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .paginate();

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<RestaurantModel>>(
          future: getPaginateRestaurant(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                final parsedItem = snapshot.data![index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            RestaurantDetailScreen(id: parsedItem.id),
                      ),
                    );
                  },
                  child: RestaurantCard.fromModel(model: parsedItem),
                );
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
