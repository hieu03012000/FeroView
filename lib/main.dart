import 'dart:io';

import 'package:fero/utils/constants.dart';
import 'package:fero/screens/Home.dart';
import 'package:fero/screens/LoadImage.dart';
import 'package:fero/screens/ModelListPage.dart';
import 'package:fero/screens/ModelProfilePage.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/model_list_view_model.dart';
import 'package:fero/viewmodels/model_view_model.dart';
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
          ChangeNotifierProvider(
            create: (_) => ModelViewModel(),
          ),
        ],
        child: Home(),
        // child: ModelProfilePage(
        //   modelId: 'MD0021',
        // ),
      ),
      // home: ImageUpload(),
      // home: ModelListPage(),
    );
  }
}
