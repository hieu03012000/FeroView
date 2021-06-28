import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  Future<FirebaseUser> handleSignInEmail(String email, String password) async { 
    var result =
        await _auth.signInWithEmailAndPassword(email: email, password: password);
    var user = result.user;

    return user;
  }
}