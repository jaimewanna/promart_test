// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promart_test/pages/mainPage.dart';
import 'package:promart_test/providers/globals.dart';

class AddProductage extends StatefulWidget {
  AddProductage({Key? key}) : super(key: key);

  @override
  State<AddProductage> createState() => _AddProductageState();
}

class _AddProductageState extends State<AddProductage> {
  CollectionReference products = Firestore.instance.collection('productos');
  final _formKey = GlobalKey<FormState>();
  TextEditingController descripcion = TextEditingController();
  TextEditingController imagen = TextEditingController();
  TextEditingController nombre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: getPrimaryColor(),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text(
          "Añadir Producto",
          textAlign: TextAlign.center,
          style: TextStyle(color: getTextColor()),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
            addUser();
          }
        },
      ),
    );

    OutlineInputBorder borde = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: getPrimaryColor(), width: 5),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Añadir Producto',
          style: TextStyle(color: getTextColor()),
        ),
        backgroundColor: getPrimaryColor(),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              alignment: Alignment.center,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: nombre,
                      decoration: InputDecoration(
                        labelText: "Ingrese el nombre del producto",
                        fillColor: Colors.white,
                        border: borde,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: descripcion,
                      decoration: InputDecoration(
                        labelText: "Ingrese la descripcion",
                        fillColor: Colors.white,
                        border: borde,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: imagen,
                      decoration: InputDecoration(
                        labelText: "Ingrese el url de la imagen",
                        fillColor: Colors.white,
                        border: borde,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    addButon,
                    const SizedBox(
                      height: 30,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addUser() {
    return products
        .add({
          'nombre': nombre.text,
          'descripcion': descripcion.text,
          'imagen': imagen.text,
          'favorito': false
        })
        .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
              (Route<dynamic> route) => false,
            ))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
