import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProdutoDetalhePage extends StatefulWidget {
  const ProdutoDetalhePage({super.key});

  @override
  State<ProdutoDetalhePage> createState() => _ProdutoDetalhePageState();
}

class _ProdutoDetalhePageState extends State<ProdutoDetalhePage> {
  @override
  Widget build(BuildContext context) {
    ///Pegando argumentos
    final dynamic args = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args['nome_produto'],
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
    );
  }
}
