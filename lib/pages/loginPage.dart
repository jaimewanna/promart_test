// ignore_for_file: file_names, prefer_const_constructors_in_immutables
import 'package:promart_test/providers/globals.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  OutlineInputBorder borde = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(color: getPrimaryColor(), width: 5),
  );

  @override
  Widget build(BuildContext context) {
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: getPrimaryColor(),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text(
          "Login",
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
          }
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: getTextColor()),
        ),
        backgroundColor: getPrimaryColor(),
        automaticallyImplyLeading: false,
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
                      controller: email,
                      decoration: InputDecoration(
                        labelText: "Ingrese su Email",
                        fillColor: Colors.white,
                        border: borde,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: "Ingrese su Contraseña",
                        fillColor: Colors.white,
                        border: borde,
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    loginButon,
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
}
