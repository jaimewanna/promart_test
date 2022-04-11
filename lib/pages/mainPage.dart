// ignore_for_file: file_names, prefer_const_constructors_in_immutables, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:promart_test/pages/addProductPage.dart';
import 'package:promart_test/pages/loginPage.dart';
import 'package:promart_test/providers/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Lista de Productos"),
            backgroundColor: getPrimaryColor(),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('logged', false);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                },
              )
            ]),
        floatingActionButton: FloatingActionButton(
            backgroundColor: getPrimaryColor(),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProductage()));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: SizedBox(
          height: MediaQuery.of(context).size.height - 214,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('productos').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Cargando...');
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  return ListView(children: getExpenseItems(snapshot));
                }
                return const Text("loading...");
              }),
        ));
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.documents
        .map((doc) => ListTile(
              title: Text(doc["nombre"]),
              subtitle: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(doc["descripcion"]),
                  Text(doc["imagen"],
                      style: const TextStyle(color: Colors.blueAccent)),
                ],
              ),
              trailing: doc["favorito"] == true
                  ? GestureDetector(
                      onTap: () {
                        print(doc.documentID);
                        addUser(doc.documentID, false);
                      },
                      child: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        print(doc.documentID);
                        addUser(doc.documentID, true);
                      },
                      child: const Icon(Icons.star_border)),
            ))
        .toList();
  }

  Future<void> addUser(uid, valor) {
    CollectionReference products = Firestore.instance.collection('productos');

    return products.document(uid).updateData({"favorito": valor}).then(
      (value) {
        setState(() {});
      },
    ).catchError((error) => print("Failed to update user: $error"));
  }
}
