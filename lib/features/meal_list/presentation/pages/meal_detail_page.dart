import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:sehatin/core/common/widgets/custom_loading_indicator.dart';
import 'package:sehatin/features/cart/data/models/cart_items_model.dart';
import 'package:sehatin/features/cart/presentation/bloc/add_cart_item/add_cart_item_bloc.dart';
import 'package:sehatin/features/favorite/presentation/bloc/add_favorite_item/add_favorite_item_bloc.dart';
import 'package:sehatin/features/meal_list/data/models/menu_model.dart';
import 'package:sehatin/features/meal_list/presentation/bloc/menu_by_id_bloc.dart';

class MenuDetailPage extends StatefulWidget {
  final String? id;

  const MenuDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  int quantity = 1;

  @override
  void initState() {
    context.read<MenuByIdBloc>().add(GetMenuById(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddCartItemBloc, AddCartItemState>(
            listener: (context, state) {
              if (state is AddCartItemLoading) {
                showDialog(
                  context: context,
                  builder: (context) => const CustomLoadingIndicator(),
                );
              } else if (state is AddCartItemFailed) {
                context.pop();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message!)));
              } else {
                context.pop();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to Cart')));
              }
            },
          ),
          BlocListener<AddFavoriteItemBloc, AddFavoriteItemState>(
            listener: (context, state) {
              if (state is AddFavoriteItemLoading) {
                showDialog(
                  context: context,
                  builder: (context) => const CustomLoadingIndicator(),
                );
              } else if (state is AddFavoriteItemFailed) {
                context.pop();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message!)));
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item Added to Favorite')));
                context.pop();
              }
            },
          ),
        ],
        child: BlocConsumer<MenuByIdBloc, MenuByIdState>(
          listener: (context, state) {
            if (state is MenuByIdLoading) {
              showDialog(
                context: context,
                useRootNavigator: false,
                builder: (context) => const CustomLoadingIndicator(),
              );
            } else if (state is MenuByIdFailed) {
              context.pop();

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message!)));
            } else {
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is MenuByIdLoaded) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          state.menuEntity!.image!,
                          width: double.infinity,
                          height: 312,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => context.pop(),
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xfff4f4f9),
                                  ),
                                  child: const Center(
                                    child: Icon(FeatherIcons.arrowLeft),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => context
                                    .read<AddFavoriteItemBloc>()
                                    .add(AddItemToFavoriteButtonTapped(
                                        menuModel: MenuModel.fromEntity(
                                            state.menuEntity!))),
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xfff4f4f9),
                                  ),
                                  child: const Center(
                                    child: Icon(FeatherIcons.heart),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.menuEntity!.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1E1E1E),
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                state.menuEntity!.toppings!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color(0xff1E1E1E).withOpacity(0.5),
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Deskripsi',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1E1E1E),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ReadMoreText(
                                state.menuEntity!.description!,
                                trimMode: TrimMode.Line,
                                trimLines: 3,
                                trimCollapsedText: 'selengkapnya...',
                                trimExpandedText: 'tutup',
                                moreStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1E1E1E),
                                  fontSize: 12,
                                ),
                                lessStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1E1E1E),
                                  fontSize: 12,
                                ),
                                preDataTextStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff1E1E1E),
                                  fontSize: 12,
                                ),
                                postDataTextStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff1E1E1E),
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Kandungan Nutrisi',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1E1E1E),
                                  fontSize: 16,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  spacing: 12,
                                  children: [
                                    Chip(
                                      avatar: Image.asset(
                                          'assets/images/calorie.png'),
                                      backgroundColor: const Color(0xfff4f4f9),
                                      side: BorderSide.none,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      label: Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Kalori ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xff1e1e1e),
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '//${state.menuEntity!.nutrition!.calorie} cal',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff1e1e1e),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Chip(
                                      avatar: Image.asset(
                                          'assets/images/protein.png'),
                                      backgroundColor: const Color(0xfff4f4f9),
                                      side: BorderSide.none,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      label: Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Protein ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xff1e1e1e),
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '${state.menuEntity!.nutrition!.protein} gr',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff1e1e1e),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Chip(
                                      avatar: Image.asset(
                                          'assets/images/carbs.png'),
                                      backgroundColor: const Color(0xfff4f4f9),
                                      side: BorderSide.none,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      label: Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Karbo ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xff1e1e1e),
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '${state.menuEntity!.nutrition!.carbs} gr',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff1e1e1e),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Chip(
                                      avatar: Image.asset(
                                          'assets/images/fiber.png'),
                                      backgroundColor: const Color(0xfff4f4f9),
                                      side: BorderSide.none,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      label: Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Serat ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xff1e1e1e),
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '${state.menuEntity!.nutrition!.fiber} gr',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff1e1e1e),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Chip(
                                      avatar:
                                          Image.asset('assets/images/fat.png'),
                                      backgroundColor: const Color(0xfff4f4f9),
                                      side: BorderSide.none,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      label: Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Lemak ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xff1e1e1e),
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '${state.menuEntity!.nutrition!.fat} gr',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff1e1e1e),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Harga',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff1e1e1e),
                                    ),
                                  ),
                                  Text(
                                    'Rp${state.menuEntity!.price}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xff1e1e1e),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    customBorder: const CircleBorder(),
                                    onTap: () => setState(() {
                                      if (quantity == 1) {
                                        quantity = 1;
                                      } else {
                                        quantity--;
                                      }
                                    }),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: const BoxDecoration(
                                        color: Color(0xfff4f4f9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Icon(FeatherIcons.minus),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 76,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xfff4f4f9),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(quantity.toString()),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  InkWell(
                                    customBorder: const CircleBorder(),
                                    onTap: () => setState(() => quantity++),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: const BoxDecoration(
                                        color: Color(0xfff4f4f9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Icon(FeatherIcons.plus),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 48),
                          ElevatedButton(
                            onPressed: () {
                              final CartItemsModel cartItem = CartItemsModel(
                                menu: MenuModel.fromEntity(state.menuEntity!),
                                quantity: quantity,
                              );

                              context.read<AddCartItemBloc>().add(
                                  AddCartItemButtonTapped(
                                      cartItemsModel: cartItem));
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 52),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: const Color(0xff1e1e1e),
                              foregroundColor: const Color(0xffF4F4F9),
                            ),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Tambah ke Keranjang - ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xfff4f4f9),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Rp${state.menuEntity!.price! * quantity}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfff4f4f9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
