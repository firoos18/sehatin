import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/core/common/widgets/custom_loading_indicator.dart';
import 'package:sehatin/features/cart/presentation/bloc/delete_cart_item/delete_cart_item_bloc.dart';
import 'package:sehatin/features/cart/presentation/bloc/get_cart_item/get_cart_item_bloc.dart';
import 'package:sehatin/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:sehatin/features/cart/presentation/widgets/checkout_bottom_sheet.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<GetCartItemBloc>().add(GetCartItem());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang',
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
      body: BlocListener<DeleteCartItemBloc, DeleteCartItemState>(
        listener: (context, state) {
          if (state is DeleteCartItemLoading) {
            showDialog(
              context: context,
              builder: (context) => const CustomLoadingIndicator(),
            );
          } else if (state is DeleteCartItemFailed) {
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          } else {
            context.pop();
            context.read<GetCartItemBloc>().add(GetCartItem());
          }
        },
        child: BlocConsumer<GetCartItemBloc, GetCartItemState>(
          listener: (context, state) {
            if (state is GetCartItemLoading) {
              showDialog(
                context: context,
                builder: (context) => const CustomLoadingIndicator(),
              );
            } else if (state is GetCartItemFailed) {
              context.pop();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            } else {
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is GetCartItemLoaded) {
              if (state.cartEntity!.items!.isNotEmpty) {
                var subTotal = 0;

                for (var item in state.cartEntity!.items!) {
                  subTotal += item.quantity! * item.menu!.price!;
                }

                var deliveryFee = (subTotal * 0.1).ceil();

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      right: 15,
                      left: 15,
                      bottom: 24,
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<GetCartItemBloc>().add(GetCartItem());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.cartEntity!.items!.length,
                            itemBuilder: (context, index) => CartItemCard(
                              cartItemsEntity: state.cartEntity!.items![index],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sub Total',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1e1e1e),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Rp',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff1e1e1e),
                                      ),
                                    ),
                                    TextSpan(
                                      text: subTotal.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff1e1e1e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => showModalBottomSheet(
                              showDragHandle: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => CheckoutBottomSheet(
                                deliveryFee: deliveryFee,
                                subTotal: subTotal,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 52),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: const Color(0xff1e1e1e),
                              foregroundColor: const Color(0xffF4F4F9),
                            ),
                            child: const Text(
                              "Checkout",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 24, right: 15, left: 15, bottom: 24),
                  child: RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    onRefresh: () async {
                      context.read<GetCartItemBloc>().add(GetCartItem());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: const [
                              Center(child: Text('No Items Added Yet :(')),
                            ],
                          ),
                        ),
                        const Spacer(flex: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sub Total',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff1e1e1e),
                              ),
                            ),
                            Text(
                              'Rp0',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff1e1e1e),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(flex: 1),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: const Color(0xff1e1e1e),
                            foregroundColor: const Color(0xffF4F4F9),
                          ),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
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
