import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/controllers/auth_controller.dart';
import 'package:shop_fusion/controllers/chat_controller.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/views/pages/shared/box_error.dart';
import 'package:shop_fusion/views/pages/shared/box_image_network.dart';
import 'package:shop_fusion/views/pages/shared/box_text_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController _chatController = Get.find<ChatController>();
  final AuthController _authController = Get.find<AuthController>();

  final TextEditingController mensagemController = TextEditingController();

  final UtilsServices utils = UtilsServices();

  ///Pegando argumentos
  final dynamic args = Get.arguments;

  late Stream<QuerySnapshot> chatStream;

  @override
  void initState() {
    chatStream =
        _chatController.obterChat(args['id_vendedor'], args['id_produto']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat - ${args['nome_produto']}',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: chatStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const BoxError();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  reverse: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    String idRemetente = data['id_remetente'];

                    bool isComprador = idRemetente == _authController.uid;

                    String tipoRemetente =
                        isComprador ? 'Comprador' : 'Vendedor';

                    return ListTile(
                      leading: isComprador
                          ? CircleAvatar(
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    BoxImageNetwork(data['imagem_comprador']),
                              ),
                            )
                          : CircleAvatar(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: BoxImageNetwork(data['imagem_vendedor']),
                              ),
                            ),
                      title: Text(data['mensagem']),
                      subtitle: Text(
                        'Enviada pelo $tipoRemetente',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade100.withOpacity(0.5),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => SingleChildScrollView(
                  child: Row(
                    children: [
                      Expanded(
                        child: BoxTextField(
                          controller: mensagemController,
                          icon: Icons.message_outlined,
                          label: 'Mensagem',
                          hintText: 'Insira a sua mensagem',
                          textInputType: TextInputType.multiline,
                          maxLines: null,
                          isChat: true,
                          onFieldSubmitted: (_) async => _chatController.loading
                              ? null
                              : await enviarMensagem(),
                        ),
                      ),
                      _chatController.loading
                          ? const CircularProgressIndicator()
                          : IconButton(
                              onPressed: () async => await enviarMensagem(),
                              icon: const Icon(Icons.send),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mensagemController.dispose();
    super.dispose();
  }

  Future<void> enviarMensagem() async {
    String mensagem = mensagemController.text.trim();
    if (mensagem.isNotEmpty) {
      await _chatController
          .enviarMensagem(
        mensagemController.text,
        args['id_vendedor'],
        args['id_produto'],
      )
          .then((mensagemErro) {
        if (mensagemErro.isEmpty) {
          mensagemController.clear();
        } else {
          utils.showToast(
            message: mensagemErro,
            tipo: TipoMensagem.erro,
          );
        }
      });
    }
  }
}
