import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fero/screens/home_page.dart';
import 'package:fero/screens/model_image_page.dart';
import 'package:fero/screens/model_profile_page.dart';
import 'package:fero/screens/model_schedule_page.dart';
import 'package:fero/services/google_sign_in.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/model_view_model.dart';
import 'package:fero/viewmodels/task_list_view_model.dart';
import 'package:fero/viewmodels/image_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final int page;
  const MainScreen({Key key, this.page}) : super(key: key);
  
  @override
  _MainScreenState createState() => _MainScreenState(this.page);
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex;

  _MainScreenState(int page){
  this.pageIndex = page;
  }

  List<Widget> pageList = <Widget>[
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskListViewModel()),
        ],
        child: ModelSchedulePage(
          modelId: 'MD0021',
        )),
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
          ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
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
