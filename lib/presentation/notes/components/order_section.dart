import 'package:clean_architecture_note/domain/util/note_order.dart';
import 'package:clean_architecture_note/domain/util/order_type.dart';
import 'package:flutter/material.dart';

class OrderSection extends StatelessWidget {
  final NoteOrder noteOrder;
  final Function(NoteOrder noteOrder) onOrderChanged;

  const OrderSection({
    Key? key,
    required this.noteOrder,
    required this.onOrderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio<NoteOrder>(
              value: NoteOrder.title(noteOrder.orderType),
              groupValue: noteOrder,
              onChanged: (NoteOrder? noteOrder) {
                onOrderChanged(NoteOrder.title(noteOrder!.orderType));
              },
              activeColor: Colors.white,
            ),
            const Text('제목'),
            Radio<NoteOrder>(
              value: NoteOrder.date(noteOrder.orderType),
              groupValue: noteOrder,
              onChanged: (NoteOrder? noteOrder) {
                onOrderChanged(NoteOrder.date(noteOrder!.orderType));
              },
              activeColor: Colors.white,
            ),
            const Text('날짜'),
            Radio<NoteOrder>(
              value: NoteOrder.color(noteOrder.orderType),
              groupValue: noteOrder,
              onChanged: (NoteOrder? noteOrder) {
                onOrderChanged(NoteOrder.color(noteOrder!.orderType));
              },
              activeColor: Colors.white,
            ),
            const Text('색상'),
          ],
        ),
        Row(
          children: [
            Radio<OrderType>(
              value: const OrderType.ascending(),
              groupValue: noteOrder.orderType,
              onChanged: (OrderType? orderType) {
                onOrderChanged(noteOrder.copyWith(orderType: const OrderType.ascending()));
              },
              activeColor: Colors.white,
            ),
            const Text('오름차순'),
            Radio<OrderType>(
              value: const OrderType.descending(),
              groupValue: noteOrder.orderType,
              onChanged: (OrderType? orderType) {
                onOrderChanged(noteOrder.copyWith(orderType: const OrderType.descending()));
              },
              activeColor: Colors.white,
            ),
            const Text('내림차순'),
          ],
        ),
      ],
    );
  }
}
