import 'package:flutter/material.dart';

Future<void> showAppErrorDialog({
  required BuildContext context,
  required String message,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Erro', textAlign: TextAlign.center),
        content: Text(message),

        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
