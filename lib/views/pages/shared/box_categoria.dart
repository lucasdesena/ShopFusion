import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/controllers/categoria_controller.dart';
import 'package:shop_fusion/views/pages/shared/box_image_network.dart';

class BoxCategoria extends StatelessWidget {
  const BoxCategoria({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoriaController categoriaController =
        Get.find<CategoriaController>();
    return Obx(() {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categorias',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Mostrar Tudo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 6.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: categoriaController.categorias.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.width * 0.18,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.18 / 2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: BoxImageNetwork(
                        categoriaController.categorias[index].imagemCategoria,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      categoriaController.categorias[index].nomeCategoria
                          .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
