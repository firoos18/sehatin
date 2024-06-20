import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';

class OptionsContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const OptionsContainer(
      {super.key,
      required this.icon,
      required this.route,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (route == 'preferences') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Coming Soon!'),
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Tutup'),
                ),
              ],
            ),
          );
        } else {
          context.pushNamed(route);
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black.withOpacity(0.25),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1e1e1e),
                  ),
                ),
              ],
            ),
            const Icon(FeatherIcons.chevronRight),
          ],
        ),
      ),
    );
  }
}
