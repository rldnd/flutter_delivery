import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/provider/pagination_provider.dart';
import 'package:actual/order/model/order_model.dart';
import 'package:actual/order/model/post_order_body.dart';
import 'package:actual/order/repository/order_repository.dart';
import 'package:actual/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final orderProvider =
    StateNotifierProvider<OrderStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(orderRepositoryProvider);
    return OrderStateNotifier(ref: ref, repository: repository);
  },
);

class OrderStateNotifier
    extends PaginationProvider<OrderModel, OrderRepository> {
  final Ref ref;

  OrderStateNotifier({required this.ref, required super.repository});

  Future<bool> postOrder() async {
    try {
      final uuid = Uuid();
      final id = uuid.v4();
      final state = ref.read(basketProvider);
      await repository.postOrder(
        body: PostOrderBody(
          id: id,
          products: state
              .map(
                (e) => PostOrderBodyProduct(
                  productId: e.product.id,
                  count: e.count,
                ),
              )
              .toList(),
          totalPrice: state.fold<int>(
            0,
            (acc, cur) => acc + cur.count * cur.product.price,
          ),
          createdAt: DateTime.now().toString(),
        ),
      );

      ref.read(basketProvider.notifier).clearBasket();

      return true;
    } catch (e) {
      return false;
    }
  }
}
