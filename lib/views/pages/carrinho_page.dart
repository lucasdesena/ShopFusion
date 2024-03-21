import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_fusion/provider/carrinho_provider.dart';

class CarrinhoPage extends ConsumerStatefulWidget {
  const CarrinhoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends ConsumerState<CarrinhoPage> {
  @override
  Widget build(BuildContext context) {
    final carrinho = ref.watch(carrinhoProvider);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: carrinho.length,
      itemBuilder: (context, index) {
        final item = carrinho.values.toList()[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.nomeProduto),
              Text(item.quantidade.toString())
            ],
          ),
        );
      },
    );
  }
}
