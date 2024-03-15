import 'package:flutter/material.dart';

class BoxReutilizarText extends StatefulWidget {
  final String title;
  const BoxReutilizarText({super.key, required this.title});

  @override
  State<BoxReutilizarText> createState() => _BoxReutilizarTextState();
}

class _BoxReutilizarTextState extends State<BoxReutilizarText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 4,
        ),
      ),
    );
  }
}
