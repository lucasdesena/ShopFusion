import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/services/validators.dart';
import 'package:shop_fusion/views/pages/auth/cadastro_page.dart';
import 'package:shop_fusion/views/pages/shared/box_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => CadastroPage());
                },
                child: const Text('Ainda não possui uma conta? Cadastre-se.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
