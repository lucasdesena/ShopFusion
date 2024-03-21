import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_fusion/models/carrinho_model.dart';

final carrinhoProvider =
    StateNotifierProvider<CarrinhoNotifier, Map<String, CarrinhoModel>>(
        (ref) => CarrinhoNotifier());

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

  Map<String, CarrinhoModel> get getCarrinhoItens => state;
}
