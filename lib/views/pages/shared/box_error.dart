import 'package:flutter/material.dart';

class BoxError extends StatelessWidget {
  const BoxError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Algo deu errado!',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade300,
          ),
        ),
        Image.asset('assets/error.png'),
      ],
    );
  }
}
