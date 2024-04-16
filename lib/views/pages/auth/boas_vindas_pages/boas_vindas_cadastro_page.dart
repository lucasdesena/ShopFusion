import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/views/pages/shared/box_elevated_button_style.dart';

class BoasVindasCadastroPage extends StatefulWidget {
  const BoasVindasCadastroPage({super.key});

  @override
  State<BoasVindasCadastroPage> createState() => _BoasVindasCadastroPageState();
}

class _BoasVindasCadastroPageState extends State<BoasVindasCadastroPage> {
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
                'assets/images/texture.png',
                width: larguraTela + 80,
                height: alturaTela + 100,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: larguraTela * 0.024,
              top: larguraTela * 0.151,
              child: Image.asset('assets/images/Illustration.png'),
            ),
            Positioned(
              top: alturaTela * 0.641,
              left: larguraTela * 0.07,
              child: SizedBox(
                width: larguraTela * 0.85,
                height: alturaTela * 0.085,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.clienteCadastroRoute);
                  },
                  style: BoxElevatedButtonStyle.style(const EdgeInsets.all(14)),
                  child: Text(
                    'Cadastrar como Cliente',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: alturaTela * 0.020,
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
                    'Cadastrar como Vendedor',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: alturaTela * 0.020,
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
                  Text(
                    'Já possui uma conta?',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: larguraTela * 0.022),
                  InkWell(
                    onTap: () {
                      Get.offAndToNamed(Routes.boasVindasLoginRoute);
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.lato(
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
