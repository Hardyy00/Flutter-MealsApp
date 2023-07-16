import 'package:flutter/material.dart';

class MealTrait extends StatelessWidget {
  const MealTrait({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 6,
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
