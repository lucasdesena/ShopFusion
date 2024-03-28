import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/models/categoria_model.dart';

class CategoriaController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<CategoriaModel> categorias = <CategoriaModel>[].obs;

  @override
  void onInit() {
    _obterCategorias();
    super.onInit();
  }

  ///Método para pegar as categorias existentes no Firebase firestore
  void _obterCategorias() {
    _firestore
        .collection('categorias')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      categorias.assignAll(querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return CategoriaModel(
          imagemCategoria: data['imagem'],
          nomeCategoria: data['nome_categoria'],
        );
      }).toList());
    });
  }
}
