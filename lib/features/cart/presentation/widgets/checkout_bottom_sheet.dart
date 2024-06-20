import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sehatin/core/common/widgets/custom_loading_indicator.dart';
import 'package:sehatin/core/common/widgets/custom_textfield.dart';
import 'package:sehatin/features/cart/presentation/widgets/payment_success_dialog.dart';
import 'package:sehatin/features/history/presentation/bloc/add_item_to_history/add_item_to_history_bloc.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final int deliveryFee;
  final int subTotal;

  const CheckoutBottomSheet(
      {super.key, required this.deliveryFee, required this.subTotal});

  @override
  State<CheckoutBottomSheet> createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  final TextEditingController _addressController = TextEditingController();
  final List<DropdownMenuItem> items = [
    const DropdownMenuItem(
      value: 'bca',
      child: Text('Transfer Bank BCA'),
    ),
    const DropdownMenuItem(
      value: 'bri',
      child: Text('Transfer Bank BRI'),
    ),
    const DropdownMenuItem(
      value: 'bni',
      child: Text('Transfer Bank BNI'),
    ),
    const DropdownMenuItem(
      value: 'qris',
      child: Text('QRIS'),
    ),
  ];
  var selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddItemToHistoryBloc, AddItemToHistoryState>(
      listener: (context, state) {
        if (state is AddItemToHistoryLoading) {
          showDialog(
            context: context,
            builder: (context) => const CustomLoadingIndicator(),
          );
        } else if (state is AddItemToHistorySuccess) {
          context.pop();
          context.pop();
          showDialog(
            context: context,
            builder: (context) => const PaymentSuccessDialog(),
          );
        } else {
          context.pop();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Alamat',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1e1e1e),
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hint: 'Masukkan Alamat',
                  icon: FeatherIcons.mapPin,
                  controller: _addressController,
                  isObscure: false,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1e1e1e),
                  ),
                ),
                DropdownButtonFormField(
                  items: items,
                  onChanged: (value) => setState(() => selectedValue = value),
                  borderRadius: BorderRadius.circular(12),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xfff4f4f9),
                    prefixIcon: Icon(FeatherIcons.creditCard),
                    hintText: 'Pilih Metode Pembayaran',
                  ),
                  icon: const Icon(FeatherIcons.chevronDown),
                ),
              ],
            ),
            const Spacer(flex: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sub Total',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xff1e1e1e),
                      ),
                    ),
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
                            text: widget.subTotal.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff1e1e1e),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Biaya Pengiriman',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xff1e1e1e),
                      ),
                    ),
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
                            text: widget.deliveryFee.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff1e1e1e),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
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
                              fontWeight: FontWeight.w300,
                              color: Color(0xff1e1e1e),
                            ),
                          ),
                          TextSpan(
                            text: (widget.deliveryFee + widget.subTotal)
                                .toString(),
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
              ],
            ),
            const Spacer(flex: 1),
            ElevatedButton(
              onPressed: () => context
                  .read<AddItemToHistoryBloc>()
                  .add(ProceedPaymentButtonTapped()),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color(0xff1e1e1e),
                foregroundColor: const Color(0xffF4F4F9),
              ),
              child: const Text(
                'Proses Pembayaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xfff4f4f9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
