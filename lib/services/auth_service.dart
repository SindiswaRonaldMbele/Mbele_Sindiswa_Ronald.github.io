import 'package:firebase_auth/firebase_auth.dart';

import '../core/constants/admin_config.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get authState => auth.authStateChanges();

  bool isAdmin(User? user) => user?.email == AdminConfig.adminEmail;

  Future<void> signInWithGoogle() async {
    final provider = GoogleAuthProvider();
    provider.setCustomParameters({
      'prompt': 'select_account',
    });

    await auth.signInWithPopup(provider);
  }

  Future<void> signOut() => auth.signOut();
}