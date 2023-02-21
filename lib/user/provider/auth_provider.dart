import 'dart:async';

import 'package:actual/common/view/root_tab.dart';
import 'package:actual/common/view/splash_screen.dart';
import 'package:actual/restaurant/view/basket_screen.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:actual/user/model/user_model.dart';
import 'package:actual/user/provider/user_me_provider.dart';
import 'package:actual/user/view/login_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>(
  (ref) => AuthProvider(ref: ref),
);

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) notifyListeners();
    });
  }

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  // Splash screen
  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    if (user == null && !logginIn) return '/login';
    if (user is UserModel && (logginIn || state.location == '/splash'))
      return '/';

    if (user is UserModelError && !logginIn) return '/login';
    return null;
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (context, state) => const RootTab(),
          routes: [
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (context, state) => RestaurantDetailScreen(
                id: state.params['rid']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/basket',
          name: BasketScreen.routeName,
          builder: (context, state) => BasketScreen(),
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
      ];
}
