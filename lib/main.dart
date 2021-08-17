import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_udemy/Home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore db = FirebaseFirestore.instance;

  QuerySnapshot querySnaphot = await db
      .collection("users")
      //.where("nome", isEqualTo: "Venancio")
      //.where("idade", isEqualTo: "25")
      .orderBy("idade", descending: true)
      .limit(2)
      .get();

  for (DocumentSnapshot item in querySnaphot.docs) {
    var data = item.data() as Map;
    print("Dados usuários: " + data["nome"] + " - " + data["idade"]);
  }

  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
