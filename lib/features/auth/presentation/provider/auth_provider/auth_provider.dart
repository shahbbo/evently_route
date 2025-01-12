import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
  Future<User?> signUp1(String email, String password, String name) {
    return auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((UserCredential userCredential) async {
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();
      User? updatedUser = auth.currentUser;
      /*print('----------------------------------------------');
      print('----------------------------------------------');
      print('----------------------------------------------');
      print("User name: ${updatedUser?.displayName}");
      print("UID: ${updatedUser?.uid}");
      print('----------------------------------------------');
      print('----------------------------------------------');
      print('----------------------------------------------');*/
      return updatedUser;
    }).catchError((error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (error.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } else {
        print(error);
      }
      return null;
    });
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('----------------------------------------------');
        print('No user found for that email.');
        print('----------------------------------------------');
      } else if (e.code == 'wrong-password') {
        print('----------------------------------------------');
        print('Wrong password.');
        print('----------------------------------------------');
      }
    }
    return null;
  }

  final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
  ],);
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await auth.signInWithCredential(credential).then((value) {
        value.user!.updateDisplayName(googleUser.displayName);
        value.user!.reload();
        return value;
      });
      return userCredential.user;
    } catch (e) {
      print('An error occurred during Google Sign-In: $e');
    }
    return null;
  }
  String? name;
  String? email;
  String? uid;
  Future<void> getUserInfo() async {
    User? user = auth.currentUser;
    if (user != null) {
      name = user.displayName!;
      email = user.email!;
      uid = user.uid;
      print('----------------------------------------------');
      print('----------------------------------------------');
      print('----------------------------------------------');
      print('Name: $name');
      print('Email: $email');
      print('UID: $uid');
      print('----------------------------------------------');
      print('----------------------------------------------');
      print('----------------------------------------------');
    }
  }

// FirebaseUser user = FirebaseAuth.getInstance().getCurrentUser();
// UserProfileChangeRequest profileUpdates = new UserProfileChangeRequest.Builder()
//     .setDisplayName("Jane Q. User")
//     .build();
}
