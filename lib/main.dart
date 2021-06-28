import 'dart:io';

import 'package:fero/screens/login_page.dart';
import 'package:fero/screens/main_screen.dart';
import 'package:fero/services/google_sign_in.dart';
import 'package:fero/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final _user = FirebaseAuth.instance.currentUser();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      home: _user == null?
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => GoogleSignInProvider(),
          ),
        ],
        child: LoginPage(),
      ):
      MainScreen(page: 2,)
    );
  }
}
