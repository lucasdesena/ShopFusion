import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/provider/favorito_provider.dart';

class BoxProdutoModel extends ConsumerStatefulWidget {
  final dynamic produto;
  final String tag;
  const BoxProdutoModel({super.key, required this.produto, required this.tag});

  @override
  ConsumerState<BoxProdutoModel> createState() => _BoxProdutoModelState();
}

class _BoxProdutoModelState extends ConsumerState<BoxProdutoModel> {
  @override
  Widget build(BuildContext context) {
    final providerFavorito = ref.read(favoritoProvider.notifier);
    ref.watch(favoritoProvider);

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.produtoDetalheRoute,
          arguments: widget.produto,
          parameters: {'tag': widget.tag},
        );
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Hero(
                          tag:
                              widget.produto['imagens_produto'][0] + widget.tag,
                          child: Image.network(
                            widget.produto['imagens_produto'][0],
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
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.produto['nome_produto'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'R\$ ${widget.produto['preço_produto'].toStringAsFixed(2).toString().replaceAll('.', ',')}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 15,
            child: IconButton(
              onPressed: () {
                providerFavorito.addProdutoNosFavoritos(
                  widget.produto['nome_produto'],
                  widget.produto['id_produto'],
                  widget.produto['imagens_produto'],
                  widget.produto['preço_produto'],
                  widget.produto['id_vendedor'],
                  1,
                  widget.produto['quantidade_produto'],
                );
              },
              icon: providerFavorito.getFavoritoItem
                      .containsKey(widget.produto['id_produto'])
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
