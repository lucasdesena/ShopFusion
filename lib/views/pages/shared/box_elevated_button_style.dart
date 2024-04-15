import 'package:flutter/material.dart';

class BoxElevatedButtonStyle {
  static ButtonStyle style(EdgeInsetsGeometry padding) {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
