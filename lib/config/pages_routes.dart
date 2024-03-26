import 'package:get/get.dart';
import 'package:shop_fusion/views/pages/auth/boas_vindas_pages/boas_vindas_cadastro_page.dart';
import 'package:shop_fusion/views/pages/auth/boas_vindas_pages/boas_vindas_login_page.dart';
import 'package:shop_fusion/views/pages/auth/cliente_cadastro_page.dart';
import 'package:shop_fusion/views/pages/auth/cliente_login_page.dart';
import 'package:shop_fusion/views/pages/categoria_page.dart';
import 'package:shop_fusion/views/pages/interior_pages/categoria_produtos_page.dart';
import 'package:shop_fusion/views/pages/interior_pages/compra_page.dart';
import 'package:shop_fusion/views/pages/interior_pages/produto_detalhe_page.dart';
import 'package:shop_fusion/views/pages/principal_page.dart';
import 'package:shop_fusion/views/pages/main_page.dart';
import 'package:shop_fusion/views/pages/mapa_page.dart';

abstract class Pages {
  static final pages = <GetPage>[
    GetPage(
      page: () => const BoasVindasLoginPage(),
      name: Routes.boasVindasLoginRoute,
    ),
    GetPage(
      page: () => const BoasVindasCadastroPage(),
      name: Routes.boasVindasCadastroRoute,
    ),
    GetPage(
      page: () => const ClienteLoginPage(),
      name: Routes.clienteLoginRoute,
    ),
    GetPage(
      page: () => const ClienteCadastroPage(),
      name: Routes.clienteCadastroRoute,
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
    GetPage(
      page: () => const ProdutoDetalhePage(),
      name: Routes.produtoDetalheRoute,
    ),
    GetPage(
      page: () => const CompraPage(),
      name: Routes.comprarRoute,
    ),
  ];
}

abstract class Routes {
  static const String boasVindasLoginRoute = '/boasVindasLogin';
  static const String boasVindasCadastroRoute = '/boasVindasCadastro';
  static const String clienteLoginRoute = '/clienteLogin';
  static const String clienteCadastroRoute = '/clienteCadastro';
  static const String mapaRoute = '/map';
  static const String mainRoute = '/main';
  static const String principalRoute = '/home';
  static const String categoriaRoute = '/categoria';
  static const String categoriaProdutosRoute = '/categoriaProdutos';
  static const String produtoDetalheRoute = '/produtoDetalhe';
  static const String comprarRoute = '/comprar';
}
