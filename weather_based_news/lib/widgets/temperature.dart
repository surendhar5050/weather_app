import 'package:flutter/material.dart';

class Temperature extends StatelessWidget {
  final String title;
  final String temp;
  const Temperature({super.key, required this.title, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Text(
          temp,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
