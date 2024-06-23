import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:sehatin/features/auth/data/data_sources/auth_service.dart';
import 'package:sehatin/features/auth/data/repository/auth_repository_impl.dart';
import 'package:sehatin/features/auth/domain/repository/auth_repository.dart';
import 'package:sehatin/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:sehatin/features/auth/domain/usecases/user_log_out_usecase.dart';
import 'package:sehatin/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:sehatin/features/auth/domain/usecases/user_register_usecase.dart';
import 'package:sehatin/features/auth/presentation/bloc/get_user/get_user_bloc.dart';
import 'package:sehatin/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:sehatin/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:sehatin/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:sehatin/features/cart/data/data_sources/cart_api_service.dart';
import 'package:sehatin/features/cart/data/repository/cart_repository_impl.dart';
import 'package:sehatin/features/cart/domain/repository/cart_repository.dart';
import 'package:sehatin/features/cart/domain/usecases/delete_cart_item_usecase.dart';
import 'package:sehatin/features/cart/domain/usecases/get_cart_item_usecase.dart';
import 'package:sehatin/features/cart/domain/usecases/update_cart_item_usecase.dart';
import 'package:sehatin/features/cart/presentation/bloc/add_cart_item/add_cart_item_bloc.dart';
import 'package:sehatin/features/cart/presentation/bloc/delete_cart_item/delete_cart_item_bloc.dart';
import 'package:sehatin/features/cart/presentation/bloc/get_cart_item/get_cart_item_bloc.dart';
import 'package:sehatin/features/favorite/data/data_sources/favorite_api_service.dart';
import 'package:sehatin/features/favorite/data/repository/favorite_repository_impl.dart';
import 'package:sehatin/features/favorite/domain/repository/favorite_repository.dart';
import 'package:sehatin/features/favorite/domain/usecases/add_favorite_item_usecase.dart';
import 'package:sehatin/features/favorite/domain/usecases/get_user_favorite_item_usecase.dart';
import 'package:sehatin/features/favorite/domain/usecases/remove_item_from_favorite_usecase.dart';
import 'package:sehatin/features/favorite/presentation/bloc/add_favorite_item/add_favorite_item_bloc.dart';
import 'package:sehatin/features/favorite/presentation/bloc/get_user_favorite_item/get_user_favorite_item_bloc.dart';
import 'package:sehatin/features/favorite/presentation/bloc/remove_favorite_item/remove_favorite_item_bloc.dart';
import 'package:sehatin/features/history/data/data_sources/history_api_service.dart';
import 'package:sehatin/features/history/data/repository/history_repository_impl.dart';
import 'package:sehatin/features/history/domain/repository/history_repository.dart';
import 'package:sehatin/features/history/domain/usecases/add_item_to_history_usecase.dart';
import 'package:sehatin/features/history/domain/usecases/get_user_history_usecase.dart';
import 'package:sehatin/features/history/presentation/bloc/add_item_to_history/add_item_to_history_bloc.dart';
import 'package:sehatin/features/history/presentation/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:sehatin/features/meal_list/data/data_sources/menu_api_service.dart';
import 'package:sehatin/features/meal_list/data/repository/menu_repository_impl.dart';
import 'package:sehatin/features/meal_list/domain/repository/menu_repository.dart';
import 'package:sehatin/features/meal_list/domain/usecases/get_menu_by_id_usecase.dart';
import 'package:sehatin/features/meal_list/domain/usecases/get_menus_usecase.dart';
import 'package:sehatin/features/meal_list/presentation/bloc/menu_by_id_bloc.dart';
import 'package:sehatin/features/meal_list/presentation/get_menus/get_menus_bloc.dart';
import 'package:sehatin/features/profile/data/data_sources/user_details_api_service.dart';
import 'package:sehatin/features/profile/data/repository/user_details_repository_impl.dart';
import 'package:sehatin/features/profile/domain/repository/user_details_repository.dart';
import 'package:sehatin/features/profile/domain/usecases/add_user_details_usecase.dart';
import 'package:sehatin/features/profile/domain/usecases/get_user_details_usecase.dart';
import 'package:sehatin/features/profile/presentation/bloc/add_user_details/add_user_details_bloc.dart';
import 'package:sehatin/features/profile/presentation/bloc/get_user_details/get_user_details_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase
  injector.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  injector.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Services
  injector.registerSingleton<CartApiService>(CartApiService(injector()));
  injector
      .registerSingleton<FavoriteApiService>(FavoriteApiService(injector()));
  injector.registerSingleton<AuthService>(
      AuthService(injector(), injector(), injector(), injector()));
  injector.registerSingleton<UserDetailsApiService>(
      UserDetailsApiService(injector()));
  injector.registerSingleton<MenuApiService>(MenuApiService(injector()));
  injector.registerSingleton<HistoryApiService>(HistoryApiService(injector()));

  // Repositories
  injector.registerSingleton<AuthRepository>(AuthRepositoryImpl(injector()));
  injector.registerSingleton<UserDetailsRepository>(
      UserDetailsRepositoryImpl(injector(), injector()));
  injector.registerSingleton<MenuRepository>(MenuRepositoryImpl(injector()));
  injector.registerSingleton<CartRepository>(
      CartRepositoryImpl(injector(), injector()));
  injector.registerSingleton<HistoryRepository>(
      HistoryRepositoryImpl(injector(), injector()));
  injector.registerSingleton<FavoriteRepository>(
      FavoriteRepositoryImpl(injector(), injector()));

  // UseCases
  injector.registerSingleton<UserLoginUsecase>(UserLoginUsecase(injector()));
  injector.registerSingleton<UserLogOutUseCase>(UserLogOutUseCase(injector()));
  injector
      .registerSingleton<UserRegisterUseCase>(UserRegisterUseCase(injector()));
  injector.registerSingleton<GetUserUseCase>(GetUserUseCase(injector()));
  injector.registerSingleton<AddUserDetailsUseCase>(
      AddUserDetailsUseCase(injector()));
  injector.registerSingleton<GetUserDetailsUseCase>(
      GetUserDetailsUseCase(injector()));
  injector.registerSingleton<GetMenusUsecase>(GetMenusUsecase(injector()));
  injector
      .registerSingleton<GetMenuByIdUseCase>(GetMenuByIdUseCase(injector()));
  injector.registerSingleton<UpdateCartItemUseCase>(
      UpdateCartItemUseCase(injector()));
  injector
      .registerSingleton<GetCartItemUseCase>(GetCartItemUseCase(injector()));
  injector.registerSingleton<DeleteCartItemUseCase>(
      DeleteCartItemUseCase(injector()));
  injector.registerSingleton<AddItemToHistoryUseCase>(
      AddItemToHistoryUseCase(injector()));
  injector.registerSingleton<GetUserHistoryUseCase>(
      GetUserHistoryUseCase(injector()));
  injector.registerSingleton<AddFavoriteItemUseCase>(
      AddFavoriteItemUseCase(injector()));
  injector.registerSingleton<GetUserFavoriteItemUseCase>(
      GetUserFavoriteItemUseCase(injector()));
  injector.registerSingleton<RemoveItemFromFavoriteUseCase>(
      RemoveItemFromFavoriteUseCase(injector()));

  // Blocs
  injector.registerFactory<LoginBloc>(() => LoginBloc(injector()));
  injector.registerFactory<RegisterBloc>(() => RegisterBloc(injector()));
  injector.registerFactory<GetUserBloc>(() => GetUserBloc(injector()));
  injector.registerFactory<AddUserDetailsBloc>(
      () => AddUserDetailsBloc(injector()));
  injector.registerFactory<GetUserDetailsBloc>(
      () => GetUserDetailsBloc(injector()));
  injector.registerFactory<GetMenusBloc>(() => GetMenusBloc(injector()));
  injector.registerFactory<MenuByIdBloc>(() => MenuByIdBloc(injector()));
  injector.registerFactory<AddCartItemBloc>(() => AddCartItemBloc(injector()));
  injector.registerFactory<GetCartItemBloc>(() => GetCartItemBloc(injector()));
  injector.registerFactory<DeleteCartItemBloc>(
      () => DeleteCartItemBloc(injector()));
  injector.registerFactory<AddItemToHistoryBloc>(
      () => AddItemToHistoryBloc(injector()));
  injector.registerFactory<GetUserHistoryBloc>(
      () => GetUserHistoryBloc(injector()));
  injector.registerFactory<AddFavoriteItemBloc>(
      () => AddFavoriteItemBloc(injector()));
  injector.registerFactory<GetUserFavoriteItemBloc>(
      () => GetUserFavoriteItemBloc(injector()));
  injector.registerFactory<RemoveFavoriteItemBloc>(
      () => RemoveFavoriteItemBloc(injector()));
  injector.registerFactory<LogoutBloc>(() => LogoutBloc(injector()));
}
