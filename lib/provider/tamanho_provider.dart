import 'package:flutter_riverpod/flutter_riverpod.dart';

final tamanhoProvider = StateNotifierProvider<TamanhoNotifier, String>(
  (ref) => TamanhoNotifier(),
);

class TamanhoNotifier extends StateNotifier<String> {
  TamanhoNotifier() : super('');

  void setTamanhoSelecionado(String tamanho) {
    state = tamanho;
  }

  void resetTamanhoSelecionado() {
    state = '';
  }
}
