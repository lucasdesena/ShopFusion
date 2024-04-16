import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 4,
        ),
      ),
    );
  }
}
