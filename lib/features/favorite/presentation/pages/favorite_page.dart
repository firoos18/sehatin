import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/core/common/widgets/custom_loading_indicator.dart';
import 'package:sehatin/features/favorite/presentation/bloc/get_user_favorite_item/get_user_favorite_item_bloc.dart';
import 'package:sehatin/features/favorite/presentation/bloc/remove_favorite_item/remove_favorite_item_bloc.dart';
import 'package:sehatin/features/favorite/presentation/widgets/favorite_item_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    context.read<GetUserFavoriteItemBloc>().add(GetUserFavoriteItem());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorit',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff1e1e1e),
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(FeatherIcons.arrowLeft),
        ),
      ),
      body: BlocListener<RemoveFavoriteItemBloc, RemoveFavoriteItemState>(
        listener: (context, state) {
          if (state is RemoveFavoriteItemLoading) {
            showDialog(
              context: context,
              builder: (context) => const CustomLoadingIndicator(),
            );
          } else if (state is RemoveFavoriteItemFailed) {
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          } else {
            context.pop();
            context.read<GetUserFavoriteItemBloc>().add(GetUserFavoriteItem());
          }
        },
        child: BlocConsumer<GetUserFavoriteItemBloc, GetUserFavoriteItemState>(
          listener: (context, state) {
            if (state is GetUserFavoriteItemLoading) {
              showDialog(
                context: context,
                builder: (context) => const CustomLoadingIndicator(),
              );
            } else if (state is GetUserFavoriteItemFailed) {
              context.pop();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message!)));
            } else {
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is GetUserFavoriteItemLoaded) {
              if (state.items!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.items!.length,
                          itemBuilder: (context, index) => FavoriteItemCard(
                              menuEntity: state.items![index])),
                    ],
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(right: 15, left: 15, top: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('No Favorite Items Yet :('),
                    ],
                  ),
                );
              }
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
