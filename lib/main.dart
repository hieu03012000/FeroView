import 'dart:io';

import 'package:fero/screens/main_screen.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/screens/home_page.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
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
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      // home: ModelProfilePage(modelId: 'MD0021',),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CastingListViewModel(),
          ),
        ],
        child: MainScreen(page: 2,),
        // child: ModelProfilePage(
        //   modelId: 'MD0021',
        // ),
      ),
      // home: ImageUpload(),
      // home: ModelListPage(),
    );
  }
}
