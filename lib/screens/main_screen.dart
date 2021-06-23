import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fero/screens/Home.dart';
import 'package:fero/screens/ModelImagePage.dart';
import 'package:fero/screens/model_profile_page.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/model_view_model.dart';
import 'package:fero/viewmodels/image_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 2;
  List<Widget> pageList = <Widget>[
    Scaffold(),
    Scaffold(),
    MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) =>
              CastingListViewModel()), // add your providers like this.
    ], child: Home()),
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ImageListViewModel()),
        ],
        child: ModelImagePage(
          modelId: 'MD0021',
        )),
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ModelViewModel()),
        ],
        child: ModelProfilePage(
          modelId: 'MD0021',
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pageList[pageIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: kPrimaryColor,
          index: pageIndex,
          items: <Widget>[
            Icon(
              Icons.schedule,
              color: kBackgroundColor,
            ),
            Icon(
              Icons.list_alt,
              color: kBackgroundColor,
            ),
            Icon(
              Icons.home,
              color: kBackgroundColor,
            ),
            Icon(
              Icons.image,
              color: kBackgroundColor,
            ),
            Icon(
              Icons.account_circle,
              color: kBackgroundColor,
            ),
          ],
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
        ));
  }
}
