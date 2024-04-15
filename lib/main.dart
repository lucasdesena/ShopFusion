import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/controllers/auth_controller.dart';
import 'package:shop_fusion/controllers/categoria_controller.dart';
import 'package:shop_fusion/controllers/chat_controller.dart';
import 'package:shop_fusion/controllers/compra_controller.dart';
import 'package:shop_fusion/controllers/perfil_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.get('FirebaseApiKey'),
      appId: dotenv.get('FirebaseAppID'),
      messagingSenderId: dotenv.get('FirebaseProjectNumber'),
      projectId: dotenv.get('FirebaseProjectId'),
      storageBucket: dotenv.get('FirebaseStorageBucket'),
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      title: 'ShopFusion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: Pages.pages,
      initialRoute: Routes.boasVindasLoginRoute,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(CompraController());
        Get.put(CategoriaController());
        Get.put(ChatController());
        Get.put(PerfilController());
      }),
    );
  }
}
