import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/controllers/auth_controller.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/services/validators.dart';
import 'package:shop_fusion/views/pages/shared/box_elevated_button_style.dart';
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

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Acesse a sua conta',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
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
                  style: BoxElevatedButtonStyle.style(
                    const EdgeInsets.only(top: 12, bottom: 12),
                  ),
                  onPressed: _authController.loading
                      ? null
                      : () async {
                          await login();
                        },
                  child: Center(
                    child: _authController.loading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Entrar',
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
                          Get.offAndToNamed(Routes.clienteCadastroRoute);
                        },
                  child: const Text('Ainda não possui uma conta? Cadastre-se.'),
                );
              }),
            ],
          ),
        ),
      ),
    );
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
          Get.offAllNamed('/map');
        }
      });
    }
  }
}
