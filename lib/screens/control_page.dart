import 'package:fero/screens/login_page.dart';
import 'package:fero/screens/main_screen.dart';
import 'package:fero/services/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return MainScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Some things error'),
            );
          } else {
            // return LoginPage();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiProvider(providers: [
                      ChangeNotifierProvider(
                          create: (_) => GoogleSignInProvider()),
                    ], child: LoginPage())));
          }
        },
      ),
    );
  }
}
