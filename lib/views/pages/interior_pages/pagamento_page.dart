import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_fusion/config/pages_routes.dart';

class PagamentoPage extends StatefulWidget {
  const PagamentoPage({super.key});

  @override
  State<PagamentoPage> createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {
  bool _pagarNaEntrega = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Opções de Pagamento',
          style:
              GoogleFonts.lato(fontWeight: FontWeight.w400, letterSpacing: 4),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Selecione o Método de Pagamento',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pagar na entrega',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Switch(
                  value: _pagarNaEntrega,
                  onChanged: (value) {
                    setState(() {
                      _pagarNaEntrega = value;
                    });

                    if (_pagarNaEntrega) {
                      Get.toNamed(Routes.comprarRoute);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
