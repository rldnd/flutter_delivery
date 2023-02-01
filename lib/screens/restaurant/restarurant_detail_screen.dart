import 'package:delivery/components/layout/default_layout.dart';
import 'package:delivery/components/product_card.dart';
import 'package:delivery/screens/restaurant/_shared/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: CustomScrollView(
          slivers: [
            renderTop(),
            renderLabel(),
            renderProducts(),
          ],
        )

        // Column(
        //   children: [
        // RestaurantCard(
        //   imageWidget: Image.asset('assets/images/food/ddeok_bok_gi.jpg'),
        //   name: '불타는 떡볶이',
        //   tags: ['떡볶이', '맛있음', '치즈'],
        //   ratingsCount: 100,
        //   deliveryFee: 3000,
        //   deliveryTime: 30,
        //   ratings: 4.76,
        //   isDetail: true,
        //   detail: '맛있는 떡볶이',
        // ),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //       child: ProductCard(),
        //     ),
        //   ],
        // ),
        );
  }

  renderLabel() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        imageWidget: Image.asset('assets/images/food/ddeok_bok_gi.jpg'),
        name: '불타는 떡볶이',
        tags: ['떡볶이', '맛있음', '치즈'],
        ratingsCount: 100,
        deliveryFee: 3000,
        deliveryTime: 30,
        ratings: 4.76,
        isDetail: true,
        detail: '맛있는 떡볶이',
      ),
    );
  }

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard(),
            );
          },
        ),
      ),
    );
  }
}
