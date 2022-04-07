// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:promart_test/pages/loginPage.dart';
import 'package:promart_test/pages/mainPage.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'main': (BuildContext context) => MainPage()
  };
}
