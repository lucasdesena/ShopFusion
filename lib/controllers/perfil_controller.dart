import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<({String email, String mensagemErro})> obterEmail() async {
    User? usuario = _auth.currentUser;
    String email = '';
    String mensagemErro = '';

    if (usuario != null) {
      try {
        DocumentSnapshot usuarioDoc = await FirebaseFirestore.instance
            .collection('compradores')
            .doc(usuario.uid)
            .get();

        email = usuarioDoc['email'];
      } catch (e) {
        mensagemErro = 'Houve um erro ao tentar obter o nome!';
      }
    } else {
      mensagemErro = 'O usuário não foi encontrado';
    }

    return (email: email, mensagemErro: mensagemErro);
  }

  Future<({String nome, String mensagemErro})> obterNome() async {
    User? usuario = _auth.currentUser;
    String nome = '';
    String mensagemErro = '';

    if (usuario != null) {
      try {
        DocumentSnapshot usuarioDoc = await FirebaseFirestore.instance
            .collection('compradores')
            .doc(usuario.uid)
            .get();

        nome = usuarioDoc['nome'];
      } catch (e) {
        mensagemErro = 'Houve um erro ao tentar obter o nome!';
      }
    } else {
      mensagemErro = 'O usuário não foi encontrado';
    }

    return (nome: nome, mensagemErro: mensagemErro);
  }

  Future<({String mensagemSucesso, String mensagemErro})> atualizarPerfil(
      String email, String nome, bool isEmailDif) async {
    User? usuario = _auth.currentUser;
    String mensagemErro = '';
    String mensagemSucesso = '';

    if (usuario != null) {
      try {
        if (isEmailDif) {
          await usuario.verifyBeforeUpdateEmail(email);
          await _firestore.collection('compradores').doc(usuario.uid).update({
            'email': email,
            'nome': nome,
          });
        } else {
          await _firestore.collection('compradores').doc(usuario.uid).update({
            'nome': nome,
          });
        }

        if (isEmailDif) {
          mensagemSucesso =
              'Um email foi enviado para confirmar a atualização dos seus dados de perfil.';
        } else {
          mensagemSucesso = 'Seu nome foi atualizado com sucesso!';
        }
      } catch (_) {
        mensagemErro = 'Houve um erro ao tentar atualizar os dados!';
      }
    } else {
      mensagemErro = 'O usuário não foi encontrado';
    }

    return (
      mensagemSucesso: mensagemSucesso,
      mensagemErro: mensagemErro,
    );
  }
}
