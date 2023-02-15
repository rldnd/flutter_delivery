import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/model/pagination_params.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) return null;

  return state.data.firstWhere((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({required this.repository})
      : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) return;
      }

      final isLoading = state is CursorPaginationLoading;
      final isRetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRetching || isFetchingMore)) return;

      PaginationParams paginationParams = PaginationParams(count: fetchCount);

      if (fetchMore) {
        final pState = state as CursorPagination;
        state = CursorPaginationFetchingMore(
          data: pState.data,
          meta: pState.meta,
        );

        paginationParams =
            paginationParams.copyWith(after: pState.data.last.id);
      } else {
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;

          state = CursorPaginationRefetching(
            data: pState.data,
            meta: pState.meta,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }

      final response = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;
        state = response.copyWith(data: [...pState.data, ...response.data]);
      } else {
        state = response;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }

  Future<void> getDetail({
    required String id,
  }) async {
    if (state is! CursorPagination) {
      await this.paginate();
      return;
    }

    final pState = state as CursorPagination;
    final response = await repository.getRestaurantDetail(id: id);
    state = pState.copyWith(
      data: pState.data
          .map<RestaurantModel>((e) => e.id == id ? response : e)
          .toList(),
    );
  }
}
