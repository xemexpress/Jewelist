import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  String dismissText = '',
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    dismissText.isEmpty
        ? SnackBar(content: Text(message))
        : SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 20),
            action: SnackBarAction(
              label: dismissText,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
  );
}
