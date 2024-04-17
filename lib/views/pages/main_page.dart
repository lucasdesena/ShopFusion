import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shop_fusion/config/pages_routes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final RxInt currentPageIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentPageIndex.value = value;
          });
        },
        currentIndex: currentPageIndex.value,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(HeroIcons.home, size: 30),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesome.heart_solid, size: 30),
            label: 'Favorito',
          ),
          BottomNavigationBarItem(
            icon: Icon(MingCute.shopping_bag_2_fill, size: 30),
            label: 'Categoria',
          ),
          BottomNavigationBarItem(
            icon: Icon(IonIcons.cart, size: 30),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.person, size: 30),
            label: 'Perfil',
          ),
        ],
      ),
      body: Obx(() {
        switch (currentPageIndex.value) {
          case 0:
            return Pages.pages
                .firstWhere((page) => page.name == Routes.principalRoute)
                .page();
          case 1:
            return Pages.pages
                .firstWhere((page) => page.name == Routes.favoritoRoute)
                .page();
          case 2:
            return Pages.pages
                .firstWhere((page) => page.name == Routes.categoriaRoute)
                .page();
          case 3:
            return Pages.pages
                .firstWhere((page) => page.name == Routes.carrinhoRoute)
                .page();
          case 4:
            return Pages.pages
                .firstWhere((page) => page.name == Routes.perfilRoute)
                .page();
          default:
            return Container();
        }
      }),
    );
  }
}
