import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriaPage extends StatelessWidget {
  const CategoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoriasStream =
        FirebaseFirestore.instance.collection('categorias').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.category),
            SizedBox(height: 5),
            Text(
              'Categorias',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 5),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: categoriasStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Algo deu errado');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final categoria = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/categoriaProdutos',

                        ///Passando argumento na rota
                        arguments: {'categoria': categoria});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          categoria['imagem'],
                          width: 80,
                          height: 80,
                        ),
                        Text(
                          categoria['nome_categoria'],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
