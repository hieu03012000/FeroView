import 'dart:io';

import 'package:fero/screens/login_page.dart';
import 'package:fero/screens/main_screen.dart';
import 'package:fero/screens/main_screen_not_active.dart';
import 'package:fero/services/google_sign_in.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
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
        home: FutureBuilder(
          future: GoogleSignInProvider().checkLogin(),
          builder: (context, snapshot) {
            if (snapshot.data.toString() == '1') {
              return MainScreenNotActive(page: 1,);
            }
            if (snapshot.data.toString() == '2') {
              return MainScreen(page: 2,);
            }
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => GoogleSignInProvider(),
                  ),
                ],
                child: LoginPage(),
              );
          },
        )

        // MainScreen(page: 2,)
        );
  }
}
