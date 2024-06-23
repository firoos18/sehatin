import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/features/meal_list/domain/entities/menu_entity.dart';

class MenuCard extends StatelessWidget {
  final MenuEntity menu;

  const MenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        'menu-details',
        pathParameters: {'id': menu.id!},
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 6),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xfff4f4f9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    menu.image!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  menu.name!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1e1e1e),
                  ),
                ),
                Text(
                  menu.toppings!,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff1e1e1e).withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Rp',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff1e1e1e),
                        ),
                      ),
                      TextSpan(
                        text: '${menu.price!}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1e1e1e),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      FeatherIcons.star,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${menu.ratings!}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xff1e1e1e),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
