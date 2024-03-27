import 'package:flutter/material.dart';
import 'package:shop_fusion/views/pages/shared/box_banner.dart';
import 'package:shop_fusion/views/pages/shared/box_categoria.dart';
import 'package:shop_fusion/views/pages/shared/box_location.dart';
import 'package:shop_fusion/views/pages/shared/box_produto_feminino.dart';
import 'package:shop_fusion/views/pages/shared/box_produto_masculino.dart';
import 'package:shop_fusion/views/pages/shared/box_produtos_principal.dart';
import 'package:shop_fusion/views/pages/shared/box_reutilizar_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoxLocation(),
          SizedBox(height: 10),
          BoxBanner(),
          SizedBox(height: 10),
          BoxCategoria(),
          SizedBox(height: 10),
          BoxProdutosPrincipal(),
          SizedBox(height: 10),
          BoxReutilizarText(title: 'Produtos Masculinos'),
          SizedBox(height: 10),
          BoxProdutoMasculino(),
          SizedBox(height: 10),
          BoxReutilizarText(title: 'Produtos Femininos'),
          SizedBox(height: 10),
          BoxProdutoFeminino(),
        ],
      ),
    );
  }
}
