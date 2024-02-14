import 'package:flutter/material.dart';
import 'package:jewelist/src/models/models.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final Function(bool?) onChecked;

  const ItemTile({
    super.key,
    required this.item,
    required this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
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
            onChanged: onChecked,
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
