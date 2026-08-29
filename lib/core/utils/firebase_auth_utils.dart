import 'package:event_app_c17_mon_7pm/core/routes/pages_route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toastification/toastification.dart';

abstract class FirebaseAuthUtils {
  static Future<bool> signInWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        toastification.show(
          title: Text('invalid-credential'),
          type: ToastificationType.error,
          autoCloseDuration: Duration(seconds: 5),
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        toastification.show(
          title: Text('Wrong password provided for that user.'),
          type: ToastificationType.error,
          autoCloseDuration: Duration(seconds: 5),
        );
        print('Wrong password provided for that user.');
      }
      return Future.value(false);
    }
  }

  static Future<bool> signUpWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastification.show(
          title: Text('The password provided is too weak.'),
          type: ToastificationType.error,
          autoCloseDuration: Duration(seconds: 5),
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        toastification.show(
          title: Text('The account already exists for that email.'),
          type: ToastificationType.error,
          autoCloseDuration: Duration(seconds: 5),
        );
        print('The account already exists for that email.');
      }
      return Future.value(false);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: dotenv.env["CLIENT_SERVER_ID"],
      );
      final GoogleSignInAccount result = await _googleSignIn.authenticate();
      final googleAuth = result.authentication;
      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (e) {
      print("Google login failed $e");
      return null;
    }
  }

  static Future<void> loginWithGoogle(BuildContext context) async {
    try {
      await signInWithGoogle();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login is Successful")));
      Navigator.of(context).pushReplacementNamed(PagesRouteName.layout);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed $e")));
    }
  }
}
