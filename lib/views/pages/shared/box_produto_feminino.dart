import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_fusion/views/pages/shared/box_produto_model.dart';

class BoxProdutoFeminino extends StatelessWidget {
  const BoxProdutoFeminino({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> produtosStream = FirebaseFirestore.instance
        .collection('produtos')
        .where('categoria', isEqualTo: 'Femininos')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
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
              'Nenhum produto feminino',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                letterSpacing: 4,
              ),
            ),
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
                tag: 'feminino',
              );
            },
          ),
        );
      },
    );
  }
}
