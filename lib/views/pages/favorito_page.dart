import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_fusion/provider/favorito_provider.dart';
import 'package:shop_fusion/views/pages/shared/box_image_network.dart';

class FavoritoPage extends ConsumerStatefulWidget {
  const FavoritoPage({super.key});

  @override
  ConsumerState<FavoritoPage> createState() => _FavoritoPageState();
}

class _FavoritoPageState extends ConsumerState<FavoritoPage> {
  @override
  Widget build(BuildContext context) {
    ///Pegando provider
    final providerFavorito = ref.read(favoritoProvider.notifier);

    final listItens = ref.watch(favoritoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de desejos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        actions: [
          listItens.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    providerFavorito.limparProdutosFavoritos();
                  },
                  icon: const Icon(Icons.delete),
                )
              : Container(),
        ],
      ),
      body: listItens.isNotEmpty
          ? ListView.builder(
              itemCount: listItens.length,
              itemBuilder: (context, index) {
                final lista = listItens.values.toList()[index];

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
                            lista.imagensProduto[0],
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
                                lista.nomeProduto,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'R\$ ${lista.preco.toStringAsFixed(2).toString().replaceAll('.', ',')}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  providerFavorito
                                      .removerProduto(lista.idProduto);
                                },
                                icon: const Icon(Icons.cancel),
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
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lista de desejos vazia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                  Text(
                    'Nenhum item  adicionado a sua lista de desejos. \nVocê pode adicionar pela página princpal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
