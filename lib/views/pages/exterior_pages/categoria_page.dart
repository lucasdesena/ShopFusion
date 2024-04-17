import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/views/pages/shared/box_error.dart';
import 'package:shop_fusion/views/pages/shared/box_image_network.dart';

class CategoriaPage extends StatelessWidget {
  const CategoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoriasStream =
        FirebaseFirestore.instance.collection('categorias').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.category),
            const SizedBox(height: 5),
            Text(
              'Categorias',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 5),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: categoriasStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const BoxError();
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
                    Get.toNamed(
                      Routes.categoriaProdutosRoute,

                      ///Passando argumento na rota
                      arguments: categoria,
                    );
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
                        BoxImageNetwork(
                          categoria['imagem'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          categoria['nome_categoria'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
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
