import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_fusion/controllers/auth_controller.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/services/validators.dart';
import 'package:shop_fusion/views/pages/shared/box_text_field.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _authController = Get.find<AuthController>();
  final UtilsServices utils = UtilsServices();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();

  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Crie uma conta',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      _image == null
                          ? const CircleAvatar(
                              radius: 70,
                              child: Icon(
                                Icons.person,
                                size: 70,
                              ),
                            )
                          : CircleAvatar(
                              radius: 70,
                              backgroundImage: MemoryImage(_image!),
                            ),
                      Positioned(
                        right: 5,
                        bottom: 10,
                        child: IconButton(
                          icon: const Icon(
                            Icons.photo_camera,
                          ),
                          onPressed: () {
                            selecionarImagemGaleria();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxTextField(
                    controller: emailController,
                    icon: Icons.email,
                    label: 'Email',
                    hintText: 'Insira o seu email',
                    validator: emailValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxTextField(
                    controller: nomeController,
                    icon: Icons.person,
                    label: 'Nome',
                    hintText: 'Insira o seu nome completo',
                    validator: nameValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BoxTextField(
                    controller: senhaController,
                    icon: Icons.lock,
                    label: 'Senha',
                    hintText: 'Insira a sua senha',
                    validator: passwordValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: _authController.loading
                          ? null
                          : () async {
                              await cadastrarUsuario();
                            },
                      child: Center(
                        child: _authController.loading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Cadastrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    );
                  }),
                  Obx(() {
                    return TextButton(
                      onPressed: _authController.loading
                          ? null
                          : () {
                              Get.back();
                            },
                      child: const Text('Já possui uma conta? Faça o login.'),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selecionarImagemGaleria() async {
    var img = await _authController.escolherImagemPerfil(ImageSource.gallery);

    if (img.imagem != null) {
      setState(() {
        _image = img.imagem;
      });
    } else {
      utils.showToast(
        message: 'Nenhuma imagem foi escolhida',
        tipo: TipoMensagem.info,
      );
    }
  }

  Future<void> cadastrarUsuario() async {
    if (_image != null) {
      if (_formKey.currentState!.validate()) {
        await _authController
            .criarNovoUsuario(
          email: emailController.text,
          nome: nomeController.text,
          senha: senhaController.text,
          imagem: _image!,
        )
            .then((mensagem) {
          if (mensagem.isNotEmpty) {
            utils.showToast(
              message: mensagem,
              tipo: TipoMensagem.erro,
            );
          } else {
            Get.back();
            utils.showToast(
              message: 'Cadastro realizado com sucesso',
              tipo: TipoMensagem.sucesso,
            );
          }
        });
      }
    } else {
      utils.showToast(
        message: 'Selecione uma imagem',
        tipo: TipoMensagem.info,
      );
    }
  }
}
