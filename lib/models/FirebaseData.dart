import 'package:firebase_auth/firebase_auth.dart';

class FirebaseData {
  static FirebaseUser currentUser;
  Future<FirebaseUser> getCurrentUser() async {
    return currentUser = await FirebaseAuth.instance.currentUser();
  }

  static void signOut() {
    currentUser = null;
  }
}
