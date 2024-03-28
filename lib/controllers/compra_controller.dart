import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_fusion/models/carrinho_model.dart';

class CompraController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxBool _loading = false.obs;

  bool get loading => _loading.value;

  final RxBool _pedidoRealizado = false.obs;

  bool get pedidoRealizado => _pedidoRealizado.value;

  Future<String> finalizarcompra(
      Map<String, CarrinhoModel> itensCarrinho) async {
    String mensagemErro = '';
    _loading.value = true;

    try {
      DocumentSnapshot userDoc = await _firestore
          .collection('compradores')
          .doc(_auth.currentUser!.uid)
          .get();
      itensCarrinho.forEach((key, item) async {
        // Obtém uma referência para um novo documento dentro da coleção 'pedidos'
        DocumentReference novoPedidoRef =
            _firestore.collection('pedidos').doc();

        // Obtém o ID gerado automaticamente para esse novo documento
        String idGerado = novoPedidoRef.id;

        await novoPedidoRef.set({
          'id_pedido': idGerado,
          'id_produto': item.idProduto,
          'nome_produto': item.nomeProduto,
          'quantidade_requisitada': item.quantidade,
          'preço': item.quantidade * item.preco,
          'nome': (userDoc.data() as Map<String, dynamic>)['nome'],
          'email': (userDoc.data() as Map<String, dynamic>)['email'],
          'imagem_perfil':
              (userDoc.data() as Map<String, dynamic>)['imagem_perfil'],
          'id_comprador': _auth.currentUser!.uid,
          'id_vendedor': item.idVendedor,
          'tamanho_produto': item.tamanhoProduto,
          'imagens_produto': item.imagensProduto,
          'quantidade_disponivel': item.quantidadeProduto,
          'aceito': false,
          'data_pedido': DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
        });
      });

      _pedidoRealizado.value = true;
    } catch (error) {
      mensagemErro = 'Houve um erro ao tentar finalizar a compra!';
    }

    _loading.value = false;
    return mensagemErro;
  }
}
