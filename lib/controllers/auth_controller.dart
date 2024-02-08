import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> criarNovoUsuario({
    required String email,
    required String nome,
    required String senha,
  }) async {
    String res = 'Algo de errado aconteceu';

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: senha);

      await _firestore
          .collection('compradores')
          .doc(userCredential.user!.uid)
          .set({
        'nome': nome,
        'email': email,
        'uid': userCredential.user!.uid,
      });

      res = 'sucess';
    } catch (error) {
      res = error.toString();
    }

    return res;
  }
}
