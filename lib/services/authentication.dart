import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  static User? user;

  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser == null) return null;
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final UserCredential loggedInUser =  await FirebaseAuth.instance.signInWithCredential(credential);
    user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({'username': user!.displayName});
    return loggedInUser;
  }

  static Future<void> signOut() async {
    user = null;
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
