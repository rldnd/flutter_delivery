import 'package:delivery/models/restaurant/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // @GET('/')
  // paginate();

  @GET('/{id}')
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
