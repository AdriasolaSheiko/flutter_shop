import 'package:flutter/material.dart';

class DialogSimple extends StatelessWidget {
  const DialogSimple({
    super.key,
    required this.message,
  });

  final String message;

  Future<void> show(BuildContext context) async {
    await showDialog(context: context, builder: (_) => this);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Ok',
          ),
        ),
      ],
    );
  }
}
