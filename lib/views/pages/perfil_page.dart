import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/controllers/auth_controller.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/views/pages/shared/box_error.dart';
import 'package:shop_fusion/views/pages/shared/box_image_network.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _authController = Get.find<AuthController>();
  final UtilsServices utils = UtilsServices();

  @override
  Widget build(BuildContext context) {
    CollectionReference compradores =
        FirebaseFirestore.instance.collection('compradores');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.sunny_snowing,
              color: Colors.deepPurple,
            ),
          )
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: compradores.doc(_authController.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const BoxError();
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("O Documento não existe");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 65,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: BoxImageNetwork(data['imagem_perfil']),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data['nome'].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data['email'],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Editar perfil'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.settings,
                    ),
                    title: Text(
                      'Configurações',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.phone,
                    ),
                    title: Text(
                      'Telefone',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '+55 27 999999999',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.shopping_cart,
                    ),
                    title: Text(
                      'Carrinho',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.pedidoRoute);
                    },
                    leading: const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                    title: const Text(
                      'Pedidos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await logout();
                    },
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: const Text(
                      'Sair',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> logout() async {
    await _authController.logoutUsuario().then((mensagem) {
      if (mensagem.isNotEmpty) {
        utils.showToast(
          message: mensagem,
          tipo: TipoMensagem.erro,
        );
      } else {
        Get.offAllNamed(Routes.boasVindasLoginRoute);
      }
    });
  }
}
