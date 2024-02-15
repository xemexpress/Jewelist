import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(10),
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
    );
  }
}
