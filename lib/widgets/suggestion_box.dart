import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SuggestionBox extends StatelessWidget {
  const SuggestionBox({
    super.key,
    required this.title,
    required this.loading,
  });

  final String title;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.purple, borderRadius: BorderRadius.circular(8)),
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            if (loading) ...[
              const SizedBox(
                width: 8.0,
              ),
              const SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
