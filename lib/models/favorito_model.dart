class FavoritoModel {
  final String nomeProduto;
  final String idProduto;
  final List imagensProduto;
  final double preco;
  final String idVendedor;

  int quantidade;
  int quantidadeProduto;

  FavoritoModel({
    required this.nomeProduto,
    required this.idProduto,
    required this.imagensProduto,
    required this.preco,
    required this.idVendedor,
    required this.quantidade,
    required this.quantidadeProduto,
  });
}
