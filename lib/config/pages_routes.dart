import 'package:get/get.dart';
import 'package:shop_fusion/views/pages/auth/cadastro_page.dart';
import 'package:shop_fusion/views/pages/auth/login_page.dart';
import 'package:shop_fusion/views/pages/categoria_page.dart';
import 'package:shop_fusion/views/pages/interior_pages/categoria_produtos_page.dart';
import 'package:shop_fusion/views/pages/principal_page.dart';
import 'package:shop_fusion/views/pages/main_page.dart';
import 'package:shop_fusion/views/pages/mapa_page.dart';

abstract class Pages {
  static final pages = <GetPage>[
    GetPage(
      page: () => const LoginPage(),
      name: Routes.loginRoute,
    ),
    GetPage(
      page: () => const CadastroPage(),
      name: Routes.cadastroRoute,
    ),
    GetPage(
      page: () => const MapaPage(),
      name: Routes.mapaRoute,
    ),
    GetPage(
      page: () => const MainPage(),
      name: Routes.mainRoute,
    ),
    GetPage(
      page: () => const HomePage(),
      name: Routes.principalRoute,
    ),
    GetPage(
      page: () => const CategoriaPage(),
      name: Routes.categoriaRoute,
    ),
    GetPage(
      page: () => const CategoriaProdutosPage(),
      name: Routes.categoriaProdutosRoute,
    ),
  ];
}

abstract class Routes {
  static const String loginRoute = '/login';
  static const String cadastroRoute = '/cadastro';
  static const String mapaRoute = '/map';
  static const String mainRoute = '/main';
  static const String principalRoute = '/home';
  static const String categoriaRoute = '/categoria';
  static const String categoriaProdutosRoute = '/categoriaProdutos';
}
