import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/controllers/compra_controller.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/provider/carrinho_provider.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/views/pages/shared/box_elevated_button_style.dart';
import 'package:shop_fusion/views/pages/shared/box_image_network.dart';

class CompraPage extends ConsumerStatefulWidget {
  const CompraPage({super.key});

  @override
  ConsumerState<CompraPage> createState() => _CompraPageState();
}

class _CompraPageState extends ConsumerState<CompraPage> {
  final UtilsServices utils = UtilsServices();
  final _compraController = Get.find<CompraController>();

  @override
  Widget build(BuildContext context) {
    final providerCarrinho = ref.read(carrinhoProvider.notifier);
    final carrinho = ref.watch(carrinhoProvider);
    final valorTotal = ref.read(carrinhoProvider.notifier).calcularValortotal();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comprar',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 5,
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: carrinho.length,
        itemBuilder: (context, index) {
          final item = carrinho.values.toList()[index];

          return Card(
            child: SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: BoxImageNetwork(
                      item.imagensProduto[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.nomeProduto,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'R\$ ${item.preco.toStringAsFixed(2).toString().replaceAll('.', ',')}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                          'Quantidade: ${item.quantidade}',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          return ElevatedButton(
            onPressed: _compraController.loading
                ? null
                : () async {
                    await _compraController
                        .finalizarcompra(providerCarrinho.getCarrinhoItens)
                        .then((mensagem) {
                      if (mensagem.isNotEmpty) {
                        utils.showToast(
                          message: mensagem,
                          tipo: TipoMensagem.erro,
                        );
                      } else {
                        ///Também da para usar o "Get.close(2);" sendo "2" o número de rotas que você quer fechar
                        ///Sempre do topo da pilha para a base ou seja a última rota aberta é a primeira a ser fechada
                        Get.until((_) => Get.currentRoute == Routes.mainRoute);
                        utils.showToast(
                          message: 'Pedido realizado com sucesso',
                          tipo: TipoMensagem.sucesso,
                        );
                      }
                    });
                  },
            style: BoxElevatedButtonStyle.style(
              const EdgeInsets.all(14),
            ),
            child: _compraController.loading
                ? const CircularProgressIndicator()
                : Text(
                    'COMPRAR R\$ ${valorTotal.toStringAsFixed(2).toString().replaceAll('.', ',')}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
