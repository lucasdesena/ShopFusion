import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_fusion/models/carrinho_model.dart';

final carrinhoProvider =
    StateNotifierProvider<CarrinhoNotifier, Map<String, CarrinhoModel>>(
  (ref) => CarrinhoNotifier(),
);

class CarrinhoNotifier extends StateNotifier<Map<String, CarrinhoModel>> {
  CarrinhoNotifier() : super({});

  void addProdutoNoCarrinho(
    String nomeProduto,
    String idProduto,
    List imagensProduto,
    double preco,
    String idVendedor,
    String tamanhoProduto,
    int quantidade,
    int quantidadeProduto,
  ) {
    if (state.containsKey(idProduto)) {
      state = {
        ...state,
        idProduto: CarrinhoModel(
          nomeProduto: state[idProduto]!.nomeProduto,
          idProduto: state[idProduto]!.idProduto,
          imagensProduto: state[idProduto]!.imagensProduto,
          preco: state[idProduto]!.preco,
          idVendedor: state[idProduto]!.idVendedor,
          tamanhoProduto: state[idProduto]!.tamanhoProduto,
          quantidade: state[idProduto]!.quantidade + 1,
          quantidadeProduto: state[idProduto]!.quantidadeProduto,
        ),
      };
    } else {
      state = {
        ...state,
        idProduto: CarrinhoModel(
          nomeProduto: nomeProduto,
          idProduto: idProduto,
          imagensProduto: imagensProduto,
          preco: preco,
          idVendedor: idVendedor,
          tamanhoProduto: tamanhoProduto,
          quantidade: quantidade,
          quantidadeProduto: quantidadeProduto,
        )
      };
    }
  }

  void aumentarQtdItem(String idProduto) {
    if (state.containsKey(idProduto)) {
      state[idProduto]!.quantidade++;

      ///Notifica que o estado mudou
      state = {...state};
    }
  }

  void diminuirQtdItem(String idProduto) {
    if (state.containsKey(idProduto) && state[idProduto]!.quantidade > 0) {
      state[idProduto]!.quantidade--;

      ///Notifica que o estado mudou
      state = {...state};
    }
  }

  void limparProdutosCarrinho() {
    state.clear();

    ///Notifica que o estado mudou
    state = {...state};
  }

  void removerProduto(String idProduto) {
    state.remove(idProduto);

    ///Notifica que o estado mudou
    state = {...state};
  }

  double calcularValortotal() {
    double valortotal = 0.0;
    state.forEach((idProduto, carrinho) {
      valortotal += carrinho.quantidade * carrinho.preco;
    });

    return valortotal;
  }

  Map<String, CarrinhoModel> get getCarrinhoItens => state;
}
