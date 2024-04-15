import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/views/pages/shared/box_elevated_button_style.dart';

class BoasVindasLoginPage extends StatefulWidget {
  const BoasVindasLoginPage({super.key});

  @override
  State<BoasVindasLoginPage> createState() => _BoasVindasLoginPageState();
}

class _BoasVindasLoginPageState extends State<BoasVindasLoginPage> {
  @override
  Widget build(BuildContext context) {
    final double larguraTela = MediaQuery.of(context).size.width;
    final double alturaTela = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: larguraTela,
        height: alturaTela,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 0,
              left: -40,
              child: Image.asset(
                'assets/icons/doorpng2.png',
                width: larguraTela + 80,
                height: alturaTela + 100,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: larguraTela * 0.024,
              top: larguraTela * 0.151,
              child: Image.asset('assets/icons/Illustration2.png'),
            ),
            Positioned(
              top: alturaTela * 0.641,
              left: larguraTela * 0.07,
              child: SizedBox(
                width: larguraTela * 0.85,
                height: alturaTela * 0.085,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.clienteLoginRoute);
                  },
                  style: BoxElevatedButtonStyle.style(const EdgeInsets.all(14)),
                  child: Text(
                    'Entrar como Cliente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: alturaTela * 0.022,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: alturaTela * 0.77,
              left: larguraTela * 0.07,
              child: SizedBox(
                width: larguraTela * 0.85,
                height: alturaTela * 0.085,
                child: ElevatedButton(
                  onPressed: () {},
                  style: BoxElevatedButtonStyle.style(const EdgeInsets.all(14)),
                  child: Text(
                    'Entrar como Vendedor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: alturaTela * 0.022,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: alturaTela * 0.88,
              left: larguraTela * 0.065,
              child: Row(
                children: [
                  const Text(
                    'Precisa de uma conta?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: larguraTela * 0.022),
                  InkWell(
                    onTap: () {
                      Get.offAndToNamed(Routes.boasVindasCadastroRoute);
                    },
                    child: const Text(
                      'Cadastro',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
