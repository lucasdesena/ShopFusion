import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';

class UtilsServices {
  ///Retorna a Widget do icone dependendo do tipo recebido
  Widget _iconeToast(TipoMensagem tipo) {
    late Widget icon;

    switch (tipo) {
      case TipoMensagem.sucesso:
        icon = const Icon(
          Icons.check_circle,
          color: Color(0xFF4CAF50),
        );
        break;
      case TipoMensagem.info:
        icon = const Icon(
          Icons.error,
          color: Color(0xFFEFAE22),
        );
        break;
      case TipoMensagem.erro:
        icon = const Icon(
          Icons.cancel_rounded,
          color: Color(0xFFF44336),
        );
        break;
    }

    return icon;
  }

  ///Retorna a Cor de fundo da mensagem dependendo do tipo recebido
  Color _backgroundToast(TipoMensagem tipo) {
    late Color cor;

    switch (tipo) {
      case TipoMensagem.sucesso:
        cor = const Color(0xFFECF5E6);
        break;
      case TipoMensagem.info:
        cor = const Color(0XFFF5EFE6);
        break;
      case TipoMensagem.erro:
        cor = const Color(0XFFF5E6E6);
        break;
    }

    return cor;
  }

  ///Método para retornar um snackbar usando a biblioteca GetX
  void showToast({
    required String message,
    required TipoMensagem tipo,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: Container(),
      messageText: Center(
        child: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      icon: _iconeToast(tipo),
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: _backgroundToast(tipo),
      isDismissible: true,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 10),
    );
  }
}
