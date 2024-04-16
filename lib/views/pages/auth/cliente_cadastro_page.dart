import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/controllers/auth_controller.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/services/validators.dart';
import 'package:shop_fusion/views/pages/shared/box_elevated_button_style.dart';
import 'package:shop_fusion/views/pages/shared/box_text_button_style.dart';
import 'package:shop_fusion/views/pages/shared/box_text_field.dart';

class ClienteCadastroPage extends StatefulWidget {
  const ClienteCadastroPage({super.key});

  @override
  State<ClienteCadastroPage> createState() => _ClienteCadastroPageState();
}

class _ClienteCadastroPageState extends State<ClienteCadastroPage> {
  final _authController = Get.find<AuthController>();
  final UtilsServices utils = UtilsServices();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

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
                  Text(
                    'Crie uma conta',
                    style: GoogleFonts.poppins(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    'Para explorar as exclusividades',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
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
                    isSenha: true,
                    validator: passwordValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return ElevatedButton(
                      style: BoxElevatedButtonStyle.style(
                        const EdgeInsets.all(0),
                      ),
                      onPressed: _authController.loading
                          ? null
                          : () async {
                              await cadastrarUsuario();
                            },
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.deepPurple.shade900,
                                  Colors.deepPurple
                                ],
                              ),
                            ),
                            child: Center(
                              child: _authController.loading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Cadastrar',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 20,
                                        letterSpacing: 4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 19,
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                width: 60,
                                height: 60,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 12,
                                    color: Colors.deepPurple.shade900,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 70,
                            top: 29,
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                width: 10,
                                height: 10,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.deepPurple.shade900,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            top: 36,
                            child: Opacity(
                              opacity: 0.3,
                              child: Container(
                                width: 5,
                                height: 5,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 50,
                            top: -10,
                            child: Opacity(
                              opacity: 0.3,
                              child: Container(
                                width: 20,
                                height: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Já possui uma conta?',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        TextButton(
                          style: BoxTextButtonStyle.style(),
                          onPressed: _authController.loading
                              ? null
                              : () {
                                  Get.offAndToNamed(Routes.clienteLoginRoute);
                                },
                          child: Text(
                            'Faça o login.',
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
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

  @override
  void dispose() {
    emailController.dispose();
    nomeController.dispose();
    senhaController.dispose();
    super.dispose();
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
            Get.offAndToNamed(Routes.clienteLoginRoute);
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
