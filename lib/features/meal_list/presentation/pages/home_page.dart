import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/core/common/widgets/custom_profile_picture.dart';
import 'package:sehatin/core/common/widgets/custom_textfield.dart';
import 'package:sehatin/features/cart/presentation/bloc/get_cart_item/get_cart_item_bloc.dart';
import 'package:sehatin/features/meal_list/presentation/get_menus/get_menus_bloc.dart';
import 'package:sehatin/features/meal_list/presentation/widgets/menu_card.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  final String? uid;

  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  final listChoices = <ItemChoice>[
    ItemChoice(1, 'Meal', 'assets/images/meal.png'),
    ItemChoice(2, 'Snack', 'assets/images/snack.png'),
    ItemChoice(3, 'Desert', 'assets/images/desert.png'),
    ItemChoice(4, 'Vegan', 'assets/images/vegan.png'),
  ];

  var selectedId = 0;

  @override
  void initState() {
    context.read<GetMenusBloc>().add(GetMenus());
    context.read<GetCartItemBloc>().add(GetCartItem());
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pushNamed('profile'),
          child: const CustomProfilePicture(),
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.bell)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('cart'),
        backgroundColor: const Color(0xff1e1e1e),
        child: BlocBuilder<GetCartItemBloc, GetCartItemState>(
          builder: (context, state) {
            if (state is GetCartItemLoaded) {
              return badges.Badge(
                badgeContent: Text(state.cartEntity!.items!.length.toString()),
                position: badges.BadgePosition.topEnd(top: -13, end: -10),
                child: const Icon(
                  FeatherIcons.shoppingCart,
                  color: Color(0xfff4f4f9),
                ),
              );
            } else {
              return const Icon(
                FeatherIcons.shoppingCart,
                color: Color(0xfff4f4f9),
              );
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<GetMenusBloc>().add(GetMenus());
              context.read<GetCartItemBloc>().add(GetCartItem());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 250,
                  child: Text(
                    'Ayo cari makanan dietmu!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: 'Cari Makanan',
                  icon: FeatherIcons.search,
                  controller: _searchController,
                  isObscure: false,
                ),
                const SizedBox(height: 25),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 8,
                    children: listChoices
                        .map(
                          (choice) => ChoiceChip(
                            label: Text(
                              choice.label,
                              style: TextStyle(
                                color: selectedId != choice.id
                                    ? const Color(0xff1e1e1e)
                                    : const Color(0xffF4F4F9),
                              ),
                            ),
                            selected: selectedId == choice.id,
                            onSelected: (_) => setState(
                              () => selectedId = choice.id,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            avatar: Image.asset(choice.image),
                            selectedColor: const Color(0xff1e1e1e),
                            showCheckmark: false,
                            backgroundColor: const Color(0xfff4f4f9),
                            side: BorderSide.none,
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<GetMenusBloc, GetMenusState>(
                  builder: (context, state) {
                    if (state is GetMenusLoaded) {
                      return Flexible(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 1.48),
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: state.menuList!.length,
                          itemBuilder: (context, index) =>
                              MenuCard(menu: state.menuList![index]),
                          padding: const EdgeInsets.only(bottom: 16),
                        ),
                      );
                    } else if (state is GetMenusLoading) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemChoice {
  final int id;
  final String label;
  final String image;

  ItemChoice(
    this.id,
    this.label,
    this.image,
  );
}
