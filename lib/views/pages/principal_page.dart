import 'package:flutter/material.dart';
import 'package:shop_fusion/views/pages/shared/box_banner.dart';
import 'package:shop_fusion/views/pages/shared/box_categoria_text.dart';
import 'package:shop_fusion/views/pages/shared/box_location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoxLocation(),
        SizedBox(height: 10),
        BoxBanner(),
        SizedBox(height: 10),
        BoxCategoriaText(),
      ],
    );
  }
}
