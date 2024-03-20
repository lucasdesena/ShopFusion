import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriaProdutosPage extends StatefulWidget {
  const CategoriaProdutosPage({super.key});

  @override
  State<CategoriaProdutosPage> createState() => _CategoriaProdutosPageState();
}

class _CategoriaProdutosPageState extends State<CategoriaProdutosPage> {
  late dynamic categoria;
  late String nomeCategoria;

  @override
  Widget build(BuildContext context) {
    ///Pegando argumentos
    final dynamic args = Get.arguments;

    ///Pegando o campo "nome_categoria"
    nomeCategoria = args['nome_categoria'];

    final Stream<QuerySnapshot> produtosStream = FirebaseFirestore.instance
        .collection('produtos')
        .where('categoria', isEqualTo: nomeCategoria)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          nomeCategoria,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: produtosStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Algo deu errado');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum produto\nnessa categoria',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                ),
              ),
            );
          }

          return GridView.builder(
            itemCount: snapshot.data!.size,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 200 / 300,
            ),
            itemBuilder: (context, index) {
              final produto = snapshot.data!.docs[index];
              return Card(
                elevation: 3,
                child: Column(
                  children: [
                    SizedBox(
                      height: 170,
                      width: 200,
                      child: Image.network(
                        produto['imagens_produto'][0],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        produto['nome_produto'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
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
              );
            },
          );
        },
      ),
    );
  }
}
