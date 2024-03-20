import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/config/pages_routes.dart';

class BoxProdutoModel extends StatelessWidget {
  final dynamic produto;
  const BoxProdutoModel({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.produtoDetalheRoute, arguments: produto);
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
                        child: Image.network(
                          produto['imagens_produto'][0],
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            produto['nome_produto'],
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
                            'R\$ ${produto['preço_produto'].toStringAsFixed(2).toString().replaceAll('.', ',')}',
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
          )
        ],
      ),
    );
  }
}
