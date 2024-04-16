import 'package:flutter/material.dart';

class BoxTextButtonStyle {
  static ButtonStyle style() {
    return const ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      padding: MaterialStatePropertyAll(
        EdgeInsets.only(
          left: 4,
        ),
      ),
    );
  }
}
