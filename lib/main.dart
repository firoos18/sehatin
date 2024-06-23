import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sehatin/core/router/router.dart';
import 'package:sehatin/features/auth/presentation/bloc/get_user/get_user_bloc.dart';
import 'package:sehatin/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:sehatin/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:sehatin/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:sehatin/features/cart/presentation/bloc/add_cart_item/add_cart_item_bloc.dart';
import 'package:sehatin/features/cart/presentation/bloc/delete_cart_item/delete_cart_item_bloc.dart';
import 'package:sehatin/features/cart/presentation/bloc/get_cart_item/get_cart_item_bloc.dart';
import 'package:sehatin/features/favorite/presentation/bloc/add_favorite_item/add_favorite_item_bloc.dart';
import 'package:sehatin/features/favorite/presentation/bloc/get_user_favorite_item/get_user_favorite_item_bloc.dart';
import 'package:sehatin/features/favorite/presentation/bloc/remove_favorite_item/remove_favorite_item_bloc.dart';
import 'package:sehatin/features/history/presentation/bloc/add_item_to_history/add_item_to_history_bloc.dart';
import 'package:sehatin/features/history/presentation/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:sehatin/features/meal_list/presentation/bloc/menu_by_id_bloc.dart';
import 'package:sehatin/features/meal_list/presentation/get_menus/get_menus_bloc.dart';
import 'package:sehatin/features/profile/presentation/bloc/add_user_details/add_user_details_bloc.dart';
import 'package:sehatin/features/profile/presentation/bloc/get_user_details/get_user_details_bloc.dart';
import 'package:sehatin/firebase_options.dart';
import 'package:sehatin/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<GetUserBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<AddUserDetailsBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<GetUserDetailsBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<GetMenusBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<MenuByIdBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<GetCartItemBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<AddCartItemBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<DeleteCartItemBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<AddItemToHistoryBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<GetUserHistoryBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<AddFavoriteItemBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<GetUserFavoriteItemBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<RemoveFavoriteItemBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<LogoutBloc>(
          create: (_) => injector(),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        routerConfig: router,
      ),
    );
  }
}
