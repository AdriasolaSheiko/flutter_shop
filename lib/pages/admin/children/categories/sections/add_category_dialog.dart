import 'package:flutter/material.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    return AlertDialog(
      title: const Text('Agregar categoría'),
      content: TextField(
        controller: nameController,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(
              nameController.text,
            );
          },
          child: const Text(
            'Ok',
          ),
        ),
      ],
    );
  }

  Future<String?> show(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (_) => this,
    );
  }
}
