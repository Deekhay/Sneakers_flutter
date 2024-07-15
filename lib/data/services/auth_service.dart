import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoe_project/data/repository/authRepository.dart';

class AuthService implements Authrepository {
  Future<void> signInEmail(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
