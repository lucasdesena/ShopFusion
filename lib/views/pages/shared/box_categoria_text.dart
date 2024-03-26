import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/config/pages_routes.dart';

class BoxCategoriaText extends StatefulWidget {
  const BoxCategoriaText({super.key});

  @override
  State<BoxCategoriaText> createState() => _BoxCategoriaTextState();
}

class _BoxCategoriaTextState extends State<BoxCategoriaText> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoriaStream =
        FirebaseFirestore.instance.collection('categorias').snapshots();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categorias',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 20,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: categoriaStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final categoria = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ActionChip(
                              onPressed: () {},
                              backgroundColor: Colors.deepPurple.shade900,
                              label: Text(
                                categoria['nome_categoria'].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.categoriaRoute);
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
