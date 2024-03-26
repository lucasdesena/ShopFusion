import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: const Text(
          'Opções de Pagamento',
          style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 4),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Selecione o Método de Pagamento',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: Colors.black87,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pagar na entrega',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
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
