import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/provider/carrinho_provider.dart';

class ProdutoDetalhePage extends ConsumerStatefulWidget {
  const ProdutoDetalhePage({super.key});

  @override
  ConsumerState<ProdutoDetalhePage> createState() => _ProdutoDetalhePageState();
}

class _ProdutoDetalhePageState extends ConsumerState<ProdutoDetalhePage> {
  int _imagemIndex = 0;
  @override
  Widget build(BuildContext context) {
    ///Pegando argumentos
    final dynamic args = Get.arguments;

    ///Pegando parametros
    final dynamic parameters = Get.parameters;

    ///Pegando provider
    final providerCarrinho = ref.read(carrinhoProvider.notifier);
    final item = ref.watch(carrinhoProvider);
    final isInCarrinho = item.containsKey(args['id_produto']);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args['nome_produto'],
          style: const TextStyle(
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
                      child: Image.network(
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
                              child:
                                  Image.network(args['imagens_produto'][index]),
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
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'R\$ ${args['preço_produto'].toStringAsFixed(2).toString().replaceAll('.', ',')}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Descrição do produto',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                        Text(
                          'Ver mais',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    children: [
                      Text(
                        args['descrição'],
                        style: const TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    title: const Text(
                      'Variação do produto',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                                onPressed: () {},
                                child: Text(args['medidas'][index]),
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
                        child: Image.network(
                          args['imagem_loja'],
                          width: 60,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;

                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    title: Text(
                      args['razão_social'],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Ver perfil',
                      style: TextStyle(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade900,
                    padding: const EdgeInsets.all(6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: isInCarrinho
                      ? null
                      : () {
                          providerCarrinho.addProdutoNoCarrinho(
                            args['nome_produto'],
                            args['id_produto'],
                            args['imagens_produto'],
                            args['preço_produto'],
                            args['id_vendedor'],
                            'xl',
                            1,
                            args['quantidade_produto'],
                          );

                          debugPrint(providerCarrinho
                              .getCarrinhoItens.values.first.nomeProduto);
                        },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  label: Text(
                    isInCarrinho ? 'NO CARRINHO' : 'ADICIONAR',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      letterSpacing: 5,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.deepPurple,
              ),
            ),
            IconButton(
              onPressed: () {},
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
}
