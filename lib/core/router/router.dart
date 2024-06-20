import 'package:go_router/go_router.dart';
import 'package:sehatin/features/auth/domain/entities/user_entity.dart';
import 'package:sehatin/features/auth/presentation/pages/auth_page.dart';
import 'package:sehatin/features/auth/presentation/pages/landing_page.dart';
import 'package:sehatin/features/cart/presentation/pages/cart_page.dart';
import 'package:sehatin/features/favorite/presentation/pages/favorite_page.dart';
import 'package:sehatin/features/history/presentation/pages/history_page.dart';
import 'package:sehatin/features/meal_list/presentation/pages/home_page.dart';
import 'package:sehatin/features/meal_list/presentation/pages/meal_detail_page.dart';
import 'package:sehatin/features/profile/presentation/pages/add_user_details_personal_page.dart';
import 'package:sehatin/features/profile/presentation/pages/profile_page.dart';
import 'package:sehatin/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/landing',
      name: 'landing',
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => AuthPage(
        authState: state.extra as AuthState,
      ),
    ),
    GoRoute(
      path: '/user-details-personal',
      name: 'user-details-personal',
      builder: (context, state) => AddUserDetailsPersonalPage(
        userEntity: state.extra as UserEntity,
      ),
    ),
    GoRoute(
      path: '/history',
      name: 'history',
      builder: (context, state) => const HistoryPage(),
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/favorite',
      name: 'favorite',
      builder: (context, state) => const FavoritePage(),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomePage(
        uid: state.extra as String?,
      ),
      routes: [
        GoRoute(
          path: ':id',
          name: 'menu-details',
          builder: (context, state) => MenuDetailPage(
            id: state.pathParameters['id'],
          ),
        )
      ],
    ),
  ],
);
