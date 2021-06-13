import 'dart:io';

import 'package:fero/screens/ModelListPage.dart';
import 'package:fero/screens/ModelProfilePage.dart';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFF54E5E),
        primarySwatch: Colors.blue,
      ),
      home: ModelProfilePage(modelId: 'MD0021',),
      // home: ModelListPage(),
    );
  }
}

