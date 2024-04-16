import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/provider/carrinho_provider.dart';
import 'package:shop_fusion/provider/tamanho_provider.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/views/pages/shared/box_elevated_button_style.dart';
import 'package:shop_fusion/views/pages/shared/box_image_network.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProdutoDetalhePage extends ConsumerStatefulWidget {
  const ProdutoDetalhePage({super.key});

  @override
  ConsumerState<ProdutoDetalhePage> createState() => _ProdutoDetalhePageState();
}

class _ProdutoDetalhePageState extends ConsumerState<ProdutoDetalhePage> {
  final UtilsServices utils = UtilsServices();
  int _imagemIndex = 0;

  ///Pegando argumentos
  final dynamic args = Get.arguments;

  ///Pegando parametros
  final dynamic parameters = Get.parameters;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///Limpando tamanho selecionado anteriormente
      ref.read(tamanhoProvider.notifier).resetTamanhoSelecionado();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Pegando provider
    final providerCarrinho = ref.read(carrinhoProvider.notifier);

    final item = ref.watch(carrinhoProvider);
    final isInCarrinho = item.containsKey(args['id_produto']);

    final tamanhoSelecionado = ref.watch(tamanhoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args['nome_produto'],
          style: GoogleFonts.lato(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: args['imagens_produto'][0] + parameters['tag'],
                      child: BoxImageNetwork(
                        args['imagens_produto'][_imagemIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: args['imagens_produto'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _imagemIndex = index;
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.deepPurple.shade900,
                                ),
                              ),
                              child: BoxImageNetwork(
                                  args['imagens_produto'][index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    args['nome_produto'],
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'R\$ ${args['preço_produto'].toStringAsFixed(2).toString().replaceAll('.', ',')}',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    childrenPadding: const EdgeInsets.all(10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Descrição do produto',
                          style: GoogleFonts.lato(color: Colors.deepPurple),
                        ),
                        Text(
                          'Ver mais',
                          style: GoogleFonts.lato(color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    children: [
                      Text(
                        args['descrição'],
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    title: Text(
                      'Variação do produto',
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: args['medidas'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlinedButton(
                                onPressed: () {
                                  final String tamanhoSelecionado =
                                      args['medidas'][index];

                                  ref
                                      .read(tamanhoProvider.notifier)
                                      .setTamanhoSelecionado(
                                          tamanhoSelecionado);
                                },
                                child: Text(
                                  args['medidas'][index],
                                  style: GoogleFonts.lato(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: BoxImageNetwork(
                          args['imagem_loja'],
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      args['razão_social'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Ver perfil',
                      style: GoogleFonts.lato(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  style: BoxElevatedButtonStyle.style(
                    const EdgeInsets.all(6),
                  ),
                  onPressed: isInCarrinho
                      ? null
                      : () {
                          if (tamanhoSelecionado.isNotEmpty) {
                            providerCarrinho.addProdutoNoCarrinho(
                              args['nome_produto'],
                              args['id_produto'],
                              args['imagens_produto'],
                              args['preço_produto'],
                              args['id_vendedor'],
                              tamanhoSelecionado,
                              1,
                              args['quantidade_produto'],
                            );
                          } else {
                            utils.showToast(
                                message:
                                    'Selecione uma variação do pedido antes de prosseguir',
                                tipo: TipoMensagem.erro);
                          }
                        },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  label: Text(
                    isInCarrinho ? 'NO CARRINHO' : 'ADICIONAR',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.white,
                      letterSpacing: 5,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(
                  Routes.chatRoute,

                  ///Passando argumento na rota
                  arguments: args,
                );
              },
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.deepPurple,
              ),
            ),
            IconButton(
              onPressed: () async {
                await _firestore
                    .collection('vendedores')
                    .where('id_vendedor', isEqualTo: args['id_vendedor'])
                    .get()
                    .then((QuerySnapshot snapshot) {
                  if (snapshot.docs.isNotEmpty) {
                    // Acessa o documento
                    var vendedor =
                        snapshot.docs.first.data() as Map<String, dynamic>;

                    ligarParaFornecedor(vendedor['telefone']);
                  }
                });
              },
              icon: const Icon(
                CupertinoIcons.phone,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void ligarParaFornecedor(String numeroTelefone) async {
    final String url = "tel:$numeroTelefone";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      utils.showToast(
        message: 'Não foi possível abrir o aplicativo de chamada telefônica.',
        tipo: TipoMensagem.erro,
      );
    }
  }
}
