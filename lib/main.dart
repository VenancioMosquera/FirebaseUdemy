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
  String password = "123456";

  /* // Criando usuário no firebase
  auth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((firebaseUser) {
    print("Novo usuário: Sucesso! E-mail: " + firebaseUser.user!.email!);
  }).catchError((err) {
    print("Erro: " + err);
  });
  */

  User? currentUser = auth.currentUser;

  if (currentUser != null) {
    print("Usuário atual logado!\nEmail: " + currentUser.email!);
  } else {
    print("Usuário Deslogado!");
  }

  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
