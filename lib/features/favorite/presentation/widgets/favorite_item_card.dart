import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/features/favorite/presentation/bloc/remove_favorite_item/remove_favorite_item_bloc.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';

class FavoriteItemCard extends StatelessWidget {
  final MenuEntity menuEntity;

  const FavoriteItemCard({super.key, required this.menuEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
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
              menuEntity.image!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 250,
                child: Text(
                  '${menuEntity.name} ${menuEntity.toppings}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1e1e1e),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'Rp${menuEntity.price}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff1e1e1e),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    FeatherIcons.star,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${menuEntity.ratings}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff1e1e1e).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => showDialog(
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
                                context.read<RemoveFavoriteItemBloc>().add(
                                    RemoveItemButtonTapped(
                                        itemId: menuEntity.id));

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
                      ),
                  child: const SizedBox(
                    width: 32,
                    height: 32,
                    child: Icon(
                      FeatherIcons.trash,
                      color: Colors.red,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
