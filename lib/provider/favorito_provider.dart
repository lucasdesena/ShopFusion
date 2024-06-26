import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_fusion/models/favorito_model.dart';

final favoritoProvider =
    StateNotifierProvider<FavoritoNotifier, Map<String, FavoritoModel>>(
        (ref) => FavoritoNotifier());

class FavoritoNotifier extends StateNotifier<Map<String, FavoritoModel>> {
  FavoritoNotifier() : super({});

  void adicionarProdutoFavoritos(
    String nomeProduto,
    String idProduto,
    List imagensProduto,
    double preco,
    String idVendedor,
    int quantidade,
    int quantidadeProduto,
  ) {
    state[idProduto] = FavoritoModel(
      nomeProduto: nomeProduto,
      idProduto: idProduto,
      imagensProduto: imagensProduto,
      preco: preco,
      idVendedor: idVendedor,
      quantidade: quantidade,
      quantidadeProduto: quantidadeProduto,
    );

    ///Notifica que o estado mudou
    state = {...state};
  }

  void limparProdutosFavoritos() {
    state.clear();

    ///Notifica que o estado mudou
    state = {...state};
  }

  void removerProduto(String idProduto) {
    state.remove(idProduto);

    ///Notifica que o estado mudou
    state = {...state};
  }

  Map<String, FavoritoModel> get getFavoritoItem => state;
}
