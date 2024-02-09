import 'package:get/get.dart';
import 'package:shop_fusion/views/pages/auth/cadastro_page.dart';
import 'package:shop_fusion/views/pages/auth/login_page.dart';
import 'package:shop_fusion/views/pages/auth/map_page.dart';

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
  ];
}

abstract class Routes {
  static const String loginRoute = '/login';
  static const String cadastroRoute = '/cadastro';
  static const String mapRoute = '/map';
}
