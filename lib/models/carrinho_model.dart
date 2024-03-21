class CarrinhoModel {
  final String nomeProduto;
  final String idProduto;
  final List imagensProduto;
  final double preco;
  final String idVendedor;
  final String tamanhoProduto;

  int quantidade;
  int quantidadeProduto;

  CarrinhoModel({
    required this.nomeProduto,
    required this.idProduto,
    required this.imagensProduto,
    required this.preco,
    required this.idVendedor,
    required this.tamanhoProduto,
    required this.quantidade,
    required this.quantidadeProduto,
  });
}
