import 'package:get/get.dart';
import 'package:shop_fusion/views/pages/auth/cadastro_page.dart';
import 'package:shop_fusion/views/pages/auth/login_page.dart';
import 'package:shop_fusion/views/pages/home_page.dart';
import 'package:shop_fusion/views/pages/main_page.dart';
import 'package:shop_fusion/views/pages/map_page.dart';

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
      page: () => const MapPage(),
      name: Routes.mapRoute,
    ),
    GetPage(
      page: () => const MainPage(),
      name: Routes.mainRoute,
    ),
    GetPage(
      page: () => const HomePage(),
      name: Routes.homeRoute,
    ),
  ];
}

abstract class Routes {
  static const String loginRoute = '/login';
  static const String cadastroRoute = '/cadastro';
  static const String mapRoute = '/map';
  static const String mainRoute = '/main';
  static const String homeRoute = '/home';
}
