import 'package:flutter_riverpod/flutter_riverpod.dart';

final tamanhoProvider = StateNotifierProvider<TamanhoNotifier, String>(
  (ref) {
    return TamanhoNotifier();
  },
);

class TamanhoNotifier extends StateNotifier<String> {
  TamanhoNotifier() : super('');

  void setTamanhoSelecionado(String tamanho) {
    state = tamanho;
  }
}
