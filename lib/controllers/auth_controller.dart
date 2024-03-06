import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxBool _loading = false.obs;

  bool get loading => _loading.value;

  ///Método para selecionar uma imagem da galeria para o perfil
  Future<({Uint8List? imagem, String? mensagemErro})> escolherImagemPerfil(
      ImageSource localImagem) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: localImagem);

    if (file != null) {
      return (imagem: await file.readAsBytes(), mensagemErro: null);
    } else {
      return (imagem: null, mensagemErro: 'Nenhuma imagem foi escolhida');
    }
  }

  ///Método para fazer o upload da imagem para o Storage do firebase
  Future<String> _carregarImagemStorage(Uint8List? imagem) async {
    Reference ref =
        _storage.ref().child('imagem_perfil').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(imagem!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadURL = await snapshot.ref.getDownloadURL();

    return downloadURL;
  }

  ///Método para criar um novo usuário no Firebase auth e depois criar uma conta de comprador no firestore
  Future<String> criarNovoUsuario({
    required String email,
    required String nome,
    required String senha,
    required Uint8List imagem,
  }) async {
    String mensagemErro = '';
    _loading.value = true;

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: senha);

      String downloadURL = await _carregarImagemStorage(imagem);

      await _firestore
          .collection('compradores')
          .doc(userCredential.user!.uid)
          .set({
        'nome': nome,
        'imagem_perfil': downloadURL,
        'email': email,
        'uid': userCredential.user!.uid,
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        mensagemErro = 'A senha é muito fraca.';
      } else if (error.code == 'email-already-in-use') {
        mensagemErro = 'Este email já está cadastrado.';
      }
    }
    _loading.value = false;

    return mensagemErro;
  }

  ///Método para efetuar a autenticação do usuário no firebase
  Future<String> loginUsuario(String email, String senha) async {
    String mensagemErro = '';
    _loading.value = true;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-disabled') {
        mensagemErro = 'Usuário desabilitado. Contate o administrador.';
      } else if (error.code == 'user-not-found') {
        mensagemErro = 'Email não encontrado. Cadastre-se!';
      } else if (error.code == 'wrong-password') {
        mensagemErro = 'Senha incorreta. Tente novamente!';
      } else if (error.code == 'invalid-credential') {
        ///Caso a proteção contra enumeração de e-mails esteja ativada
        ///Firebase -> Authentication -> Settings -> Ações do usuário
        mensagemErro = 'Email ou senha incorreto(s). Tente novamente!';
      } else {
        mensagemErro = 'Ops! Aconteceu algum erro inesperado.';
      }
    }
    _loading.value = false;
    return mensagemErro;
  }

  ///Método para efetuar o logout do usuário no firebase
  Future<String> logoutUsuario() async {
    String mensagemErro = '';
    _loading.value = true;

    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (_) {
      mensagemErro = 'Ops! Aconteceu algum erro inesperado.';
    }
    _loading.value = false;
    return mensagemErro;
  }
}
