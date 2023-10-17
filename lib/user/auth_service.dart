import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../logger.dart';
import 'user_service.dart';

class AuthService {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final Stream<User?> authStateChanges = FirebaseAuth.instance.userChanges();

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var userCred = await FirebaseAuth.instance.signInWithCredential(authCredential);
      Log.info("User ${userCred.user?.uid} signed in with Google");

      bool isNewUser = userCred.additionalUserInfo?.isNewUser ?? false;

      if (!isNewUser) return;

      UserService().createUser(userCred.user?.uid ?? "", userCred.user?.displayName ?? "", userCred.user?.email ?? "");

    } on FirebaseAuthException catch (ex) {
      // handle error
      Log.error(ex.toString());
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
