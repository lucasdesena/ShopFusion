import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/controllers/compra_controller.dart';
import 'package:shop_fusion/provider/carrinho_provider.dart';
import 'package:shop_fusion/views/pages/shared/box_elevated_button_style.dart';
import 'package:shop_fusion/views/pages/shared/box_image_network.dart';

class CarrinhoPage extends ConsumerStatefulWidget {
  const CarrinhoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends ConsumerState<CarrinhoPage> {
  final _compraController = Get.find<CompraController>();

  @override
  Widget build(BuildContext context) {
    final providerCarrinho = ref.read(carrinhoProvider.notifier);
    final carrinho = ref.watch(carrinhoProvider);
    final valorTotal = ref.read(carrinhoProvider.notifier).calcularValortotal();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carrinho',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 5,
          ),
        ),
        actions: [
          carrinho.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    providerCarrinho.limparProdutosCarrinho();
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: carrinho.isNotEmpty
          ? ListView.builder(
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
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            providerCarrinho.diminuirQtdItem(
                                              item.idProduto,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          item.quantidade.toString(),
                                          style: GoogleFonts.lato(
                                            color: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            providerCarrinho.aumentarQtdItem(
                                              item.idProduto,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      providerCarrinho
                                          .removerProduto(item.idProduto);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Carrinho vazio',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                  Text(
                    'Nenhum item adicionado ao seu carrinho.\nVocê pode adicionar pela página do produto.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: carrinho.isNotEmpty
          ? SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Preço Total',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                        Text(
                          'R\$ ${valorTotal.toStringAsFixed(2).toString().replaceAll('.', ',')}',
                          style: GoogleFonts.lato(
                            color: Colors.deepPurple,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.pagamentoRoute)?.then((_) {
                          if (_compraController.pedidoRealizado) {
                            providerCarrinho.limparProdutosCarrinho();
                          }
                        });
                      },
                      style: BoxElevatedButtonStyle.style(
                        const EdgeInsets.all(14),
                      ),
                      child: Text(
                        'COMPRAR',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
