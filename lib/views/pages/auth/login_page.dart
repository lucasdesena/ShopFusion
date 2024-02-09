import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/controllers/auth_controller.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/services/validators.dart';
import 'package:shop_fusion/views/pages/shared/box_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                validator: passwordValidator,
              ),
              const SizedBox(
                height: 25,
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
                          Get.toNamed(Routes.cadastroRoute);
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
          .logarUsuario(emailController.text, senhaController.text)
          .then((mensagem) {
        if (mensagem.isNotEmpty) {
          utils.showToast(
            message: mensagem,
            tipo: TipoMensagem.erro,
          );
        } else {
          Get.toNamed('/map');
        }
      });
    }
  }
}
