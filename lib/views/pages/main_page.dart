import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_fusion/views/pages/carrinho_page.dart';
import 'package:shop_fusion/views/pages/categoria_page.dart';
import 'package:shop_fusion/views/pages/favorito_page.dart';
import 'package:shop_fusion/views/pages/home_page.dart';
import 'package:shop_fusion/views/pages/perfil_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    CategoriaPage(),
    CarrinhoPage(),
    FavoritoPage(),
    PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        selectedItemColor: Colors.deepPurple,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/store-1.svg',
              width: 25,
            ),
            label: 'PRINCIPAL',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/explore.svg'),
            label: 'CATEGORIA',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/cart.svg'),
            label: 'CARRINHO',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/favorite.svg'),
            label: 'FAVORITO',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/account.svg'),
            label: 'PERFIL',
          ),
        ],
      ),
      body: _pages[pageIndex],
    );
  }
}
