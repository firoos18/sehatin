import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/features/cart/domain/entities/cart_items_entity.dart';
import 'package:sehatin/features/cart/presentation/bloc/delete_cart_item/delete_cart_item_bloc.dart';

class CartItemCard extends StatefulWidget {
  final CartItemsEntity cartItemsEntity;

  const CartItemCard({super.key, required this.cartItemsEntity});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  late int quantity;

  @override
  void initState() {
    setState(() => quantity = widget.cartItemsEntity.quantity!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black.withOpacity(0.25),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              widget.cartItemsEntity.menu!.image!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 250,
                child: Text(
                  '${widget.cartItemsEntity.menu!.name!} ${widget.cartItemsEntity.menu!.toppings!}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1e1e1e),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Rp',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff1e1e1e),
                      ),
                    ),
                    TextSpan(
                      text: '${widget.cartItemsEntity.menu!.price!}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1e1e1e),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Item Quantity : ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff1e1e1e),
                          ),
                        ),
                        TextSpan(
                          text: widget.cartItemsEntity.quantity!.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1e1e1e),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 112),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        useRootNavigator: false,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            'Delete Item?',
                            textAlign: TextAlign.center,
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Color(0xff1e1e1e),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<DeleteCartItemBloc>().add(
                                      DeleteCartItemButtonTapped(
                                          itemId:
                                              widget.cartItemsEntity.menu!.id),
                                    );

                                context.pop();
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(
                      FeatherIcons.trash,
                      color: Colors.red,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
