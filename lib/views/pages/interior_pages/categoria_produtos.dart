import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriaProdutos extends StatefulWidget {
  const CategoriaProdutos({super.key});

  @override
  State<CategoriaProdutos> createState() => _CategoriaProdutosState();
}

class _CategoriaProdutosState extends State<CategoriaProdutos> {
  late dynamic categoria;
  late String nomeCategoria;

  @override
  Widget build(BuildContext context) {
    ///Pegando argumentos
    dynamic args = ModalRoute.of(context)!.settings.arguments;

    ///Pegando a coleção "categoria"
    categoria = args['categoria'];

    ///Pegando o campo "nome_categoria"
    nomeCategoria = categoria['nome_categoria'];

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
                    Container(
                      height: 170,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            produto['imagens_url'][0],
                          ),
                        ),
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
