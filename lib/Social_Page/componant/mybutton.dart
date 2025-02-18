import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final String text;
  final Function()? OnTop;
  const Mybutton({super.key, required this.text, required this.OnTop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTop,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
