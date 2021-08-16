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

  //Adicionando com add
  DocumentReference ref = await db
      .collection("noticias")
      .add({"titulo": "Acabou o corona!", "descricao": "Texto de exemplo..."});

  print("item salvo: " + ref.id);
  
  // Atualizando com set
  db.collection("noticias").doc("xpLfMNCJl7rYGejCyyjP").set({
    "titulo": "Acabou o corona! alterado",
    "descricao": "Texto de exemplo..."
  });
  */

  /* //Removendo com delete
  db.collection("users").doc("003").delete();
  */

  /* //Recuperando os itens um a um
  DocumentSnapshot snapshotOne = await db.collection("users").doc("001").get();

  print("Dados: " + snapshotOne.data().toString());

  DocumentSnapshot snapshotTwo = await db.collection("users").doc("002").get();

  Map data = snapshotTwo.data() as Map;
  print("Nome: " + data["nome"] + "\nIdade: " + data["idade"]);
  */

  /* //Recuperando todos os dados do Firebase manualmente
  QuerySnapshot querySnapshot = await db.collection("users").get();

  // print("dados usuários RAW: " + querySnapshot.docs.toString());
  for (QueryDocumentSnapshot item in querySnapshot.docs) {
    Map data = item.data() as Map;
    print("Dados Usuários: " + data["nome"] + " - " + data["idade"]);
  }
  */

  //Recuperando todos os dados do Firebase automaticamente
  db.collection("users").snapshots().listen((snapshot) {
    for (QueryDocumentSnapshot item in snapshot.docs) {
      Map data = item.data() as Map;
      print("Dados Usuários: " + data["nome"] + " - " + data["idade"]);
    }
  });

  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
