import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_fusion/views/pages/shared/box_produto_model.dart';

class BoxProdutosPrincipal extends StatelessWidget {
  const BoxProdutosPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> produtosStream =
        FirebaseFirestore.instance.collection('produtos').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: produtosStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Algo deu errado');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SizedBox(
          height: 100,
          child: PageView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final produto = snapshot.data!.docs[index];
              return BoxProdutoModel(
                produto: produto,
                tag: 'principal',
              );
            },
          ),
        );
      },
    );
  }
}
