import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/features/cart/presentation/bloc/get_cart_item/get_cart_item_bloc.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xfff4f4f9),
      content: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xfff4f4f9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  FeatherIcons.checkCircle,
                  color: Colors.green,
                  size: 36,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pembayaran Berhasil',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1e1e1e),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Silakan ke Riwayat untuk melihat daftar pesanan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff1e1e1e).withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.pushReplacementNamed('history'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: const Color(0xff1e1e1e),
                    foregroundColor: const Color(0xffF4F4F9),
                  ),
                  child: const Text(
                    'Riwayat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xfff4f4f9),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<GetCartItemBloc>().add(GetCartItem());
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 42),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color(0xff1e1e1e),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: const Color(0xfff4f4f9),
                    foregroundColor: const Color(0xff1e1e1e),
                  ),
                  child: const Text(
                    'Tutup',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1e1e1e),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
