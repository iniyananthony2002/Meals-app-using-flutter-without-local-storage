import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        icon,
        size: 17,
        color: color,
      ),
      const SizedBox(width: 6),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ]);
  }
}

class ReverseMealItemTrait extends StatelessWidget {
  const ReverseMealItemTrait({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        "$label: ",
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      Icon(
        icon,
        size: 17,
        color: color,
      ),
    ]);
  }
}