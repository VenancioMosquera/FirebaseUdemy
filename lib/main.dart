import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_udemy/Home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore db = FirebaseFirestore.instance;
  /* //Adicionando e atualizando com set
  db
      .collection("users")
      .doc("002")
      .set({"nome": "Isabela Gerab", "idade": "23"});
  */
  /* //Adicionando com add
  DocumentReference ref = await db
      .collection("noticias")
      .add({"titulo": "Acabou o corona!", "descricao": "Texto de exemplo..."});

  print("item salvo: " + ref.id);
  */
  // Atualizando com set
  db.collection("noticias").doc("xpLfMNCJl7rYGejCyyjP").set({
    "titulo": "Acabou o corona! alterado",
    "descricao": "Texto de exemplo..."
  });

  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
