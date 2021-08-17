import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_udemy/Home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;

  //Criando usuário com e-mail e senha
  String email = "venancio@gmail.com";
  String password = "12345";
  /* 
  // Criando usuário no firebase
  try {
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser) {
      print("Novo usuário: Sucesso! E-mail: " + firebaseUser.user!.email!);
    }).catchError((error) {
      print("Erro: " + error);
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {}
  */

  /* try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  } catch (e) {} */

  await auth.signOut();

  auth.authStateChanges().listen((User? user) {
    if (user == null) {
      print("Usuário Deslogado!");
    } else {
      print("Usuário atual logado!\nEmail: " + user.email!);
    }
  });

  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
