import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  late final FirebaseAuth _auth;

  FirebaseAuthService() {
    _auth = FirebaseAuth.instance;
  }

  FirebaseAuth get getAuth => _auth;
}
