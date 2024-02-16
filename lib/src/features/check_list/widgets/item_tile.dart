import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jewelist/src/features/check_list/controllers/controllers.dart';
import 'package:jewelist/src/models/models.dart';

class ItemTile extends ConsumerWidget {
  final Item item;

  const ItemTile({
    super.key,
    required this.item,
  });

  void Function(bool?) onChecked({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    return (_) {
      ref
          .read(
            checklistControllerProvider.notifier,
          )
          .updateItem(
            item.copyWith(isChecked: !item.isChecked),
            context,
          );
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      key: ValueKey(item.id),
      endActionPane: ActionPane(motion: ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            print('hi');
          },
          icon: Icons.edit,
          label: 'Edit',
        ),
      ]),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Checkbox(
              value: item.isChecked,
              onChanged: onChecked(context: context, ref: ref),
              fillColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (!states.contains(MaterialState.selected)) {
                    return Theme.of(context).colorScheme.primaryContainer;
                  }
                  return null;
                },
              ),
            ),
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              '${item.quantity}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
