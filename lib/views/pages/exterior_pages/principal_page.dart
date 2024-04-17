import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shop_fusion/views/pages/shared/box_banner.dart';
import 'package:shop_fusion/views/pages/shared/box_categoria.dart';
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
    return Scaffold(
      appBar: AppBar(
          title: Column(
            children: [
              Text(
                'ShopFusion',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 26,
                ),
              ),
              Image.asset(
                'assets/images/joke.gif',
                color: Colors.white,
                scale: 6,
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                MingCute.notification_line,
                size: 25,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                MingCute.message_2_line,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade900,
                  Colors.deepPurple.shade800,
                  Colors.deepPurple.shade700,
                  Colors.deepPurple,
                ],
              ),
            ),
          )),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
      ),
    );
  }
}
