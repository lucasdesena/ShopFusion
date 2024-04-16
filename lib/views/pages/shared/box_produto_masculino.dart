import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_fusion/views/pages/shared/box_error.dart';
import 'package:shop_fusion/views/pages/shared/box_produto_model.dart';

class BoxProdutoMasculino extends StatelessWidget {
  const BoxProdutoMasculino({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> produtosStream = FirebaseFirestore.instance
        .collection('produtos')
        .where('categoria', isEqualTo: 'Masculinos')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: produtosStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const BoxError();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'Nenhum produto masculino',
              style: GoogleFonts.poppins(
                fontSize: 16,
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
                tag: 'masculino',
              );
            },
          ),
        );
      },
    );
  }
}
