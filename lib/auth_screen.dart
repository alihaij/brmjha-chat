import 'package:flutter/material.dart';
import 'auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _fireAuth = FirebaseAuth.instance;

  void _submitAuthForm(
    String email,
    String password,
    String user,
    bool isLogin,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential;
      if (isLogin) {
        userCredential = await _fireAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _fireAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (!isLogin) {
          FirebaseFirestore.instance
              .collection('user')
              .add(({'username': user, 'email': email}));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AuthForm(_submitAuthForm));
  }
}
