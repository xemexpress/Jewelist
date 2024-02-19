import 'package:flutter/material.dart';

class ChecklistBottomLine extends StatelessWidget {
  const ChecklistBottomLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Theme.of(context).colorScheme.outline,
          height: 1,
          width: 70,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          'I literally have a bottom line',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          color: Theme.of(context).colorScheme.outline,
          height: 1,
          width: 70,
        ),
      ],
    );
  }
}
