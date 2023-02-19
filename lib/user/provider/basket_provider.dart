import 'package:actual/product/model/product_model.dart';
import 'package:actual/user/model/basket_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider =
    StateNotifierProvider<BasketStateNotifier, List<BasketItemModel>>(
  (ref) {
    return BasketStateNotifier();
  },
);

class BasketStateNotifier extends StateNotifier<List<BasketItemModel>> {
  BasketStateNotifier() : super([]);

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
  }
}
