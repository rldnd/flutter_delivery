import 'package:actual/product/model/product_model.dart';
import 'package:actual/user/model/basket_item_model.dart';
import 'package:actual/user/model/update_basket_body.dart';
import 'package:actual/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider =
    StateNotifierProvider<BasketStateNotifier, List<BasketItemModel>>(
  (ref) {
    final repository = ref.watch(userMeRepositoryProvider);
    return BasketStateNotifier(repository: repository);
  },
);

class BasketStateNotifier extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;

  BasketStateNotifier({required this.repository}) : super([]);

  Future<void> updateBasket() async {
    await repository.updateBasket(
      body: UpdateBasketBody(
        basket: state
            .map(
              (basket) => UpdateBasketBodyBasket(
                productId: basket.product.id,
                count: basket.count,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    final isExists =
        state.firstWhereOrNull((basket) => basket.product.id == product.id) !=
            null;

    if (isExists) {
      state = state
          .map((basket) => basket.product.id == product.id
              ? basket.copyWith(count: basket.count + 1)
              : basket)
          .toList();
    } else {
      state = [...state, BasketItemModel(product: product, count: 1)];
    }

    await updateBasket();
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    bool isDelete = false,
  }) async {
    final isExists =
        state.firstWhereOrNull((basket) => basket.product.id == product.id) !=
            null;

    if (!isExists) return;

    final existingProduct =
        state.firstWhere((basket) => basket.product.id == product.id);

    if (existingProduct.count == 1 || isDelete) {
      state = state.where((basket) => basket.product.id != product.id).toList();
    } else {
      state = state
          .map((basket) => basket.product.id == product.id
              ? basket.copyWith(count: basket.count - 1)
              : basket)
          .toList();
    }

    await updateBasket();
  }
}
