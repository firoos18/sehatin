import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sehatin/features/history/domain/entities/history_item_entity.dart';

class HistoryItemCard extends StatefulWidget {
  final HistoryItemEntity historyItemEntity;

  const HistoryItemCard({
    super.key,
    required this.historyItemEntity,
  });

  @override
  State<HistoryItemCard> createState() => _HistoryItemCardState();
}

class _HistoryItemCardState extends State<HistoryItemCard> {
  @override
  void initState() {
    initializeDateFormatting('id_ID', null);
    super.initState();
  }

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
              widget.historyItemEntity.cartItem.first.menu!.image!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 250,
                child: Text(
                  widget.historyItemEntity.cartItem.length > 1
                      ? '${widget.historyItemEntity.cartItem.first.menu!.name} ${widget.historyItemEntity.cartItem.first.menu!.toppings}, + ${(widget.historyItemEntity.cartItem.length - 1)} item lainnya'
                      : '${widget.historyItemEntity.cartItem.first.menu!.name} ${widget.historyItemEntity.cartItem.first.menu!.toppings}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1e1e1e),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                DateFormat.yMMMd('id_ID')
                    .add_jm()
                    .format(widget.historyItemEntity.timestamp),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xff1e1e1e).withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      minimumSize: const Size(100, 36),
                      backgroundColor: const Color(0xff1e1e1e),
                      foregroundColor: const Color(0xfff4f4f9),
                    ),
                    child: const Text('Pesan Lagi'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      minimumSize: const Size(100, 36),
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xff1e1e1e),
                      ),
                      foregroundColor: const Color(0xff1e1e1e),
                    ),
                    child: const Text('Ulas'),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
