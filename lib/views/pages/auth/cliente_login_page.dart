import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/controllers/auth_controller.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/services/validators.dart';
import 'package:shop_fusion/views/pages/shared/box_elevated_button_style.dart';
import 'package:shop_fusion/views/pages/shared/box_text_button_style.dart';
import 'package:shop_fusion/views/pages/shared/box_text_field.dart';

class ClienteLoginPage extends StatefulWidget {
  const ClienteLoginPage({super.key});

  @override
  State<ClienteLoginPage> createState() => _ClienteLoginPageState();
}

class _ClienteLoginPageState extends State<ClienteLoginPage> {
  final _authController = Get.find<AuthController>();
  final UtilsServices utils = UtilsServices();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Acesse a sua conta',
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
                  Image.asset(
                    'assets/images/Illustration.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BoxTextField(
                    controller: emailController,
                    icon: Icons.email,
                    label: 'Email',
                    hintText: 'Insira o seu email',
                    validator: emailValidator,
                  ),
                  const SizedBox(
                    height: 25,
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
                    height: 25,
                  ),
                  Obx(() {
                    return ElevatedButton(
                      style:
                          BoxElevatedButtonStyle.style(const EdgeInsets.all(0)),
                      onPressed: _authController.loading
                          ? null
                          : () async {
                              await login();
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
                                      'Entrar',
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
                          'Ainda não possui uma conta?',
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
                                  Get.offAndToNamed(
                                      Routes.clienteCadastroRoute);
                                },
                          child: Text(
                            'Cadastre-se.',
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
    senhaController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      await _authController
          .loginUsuario(emailController.text, senhaController.text)
          .then((mensagem) {
        if (mensagem.isNotEmpty) {
          utils.showToast(
            message: mensagem,
            tipo: TipoMensagem.erro,
          );
        } else {
          Get.offAllNamed(Routes.mapaRoute);
        }
      });
    }
  }
}
