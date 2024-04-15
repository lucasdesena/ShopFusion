import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
        selectedItemColor: Colors.deepPurple,
        currentIndex: currentPageIndex.value,
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
      body: Obx(() {
        switch (currentPageIndex.value) {
          case 0:
            return Pages.pages
                .firstWhere((page) => page.name == Routes.principalRoute)
                .page();
          case 1:
            return Pages.pages
                .firstWhere((page) => page.name == Routes.categoriaRoute)
                .page();
          case 2:
            return Pages.pages
                .firstWhere((page) => page.name == Routes.carrinhoRoute)
                .page();
          case 3:
            return Pages.pages
                .firstWhere((page) => page.name == Routes.favoritoRoute)
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
