import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fero/screens/home_page.dart';
import 'package:fero/screens/model-apply-casting-page.dart';
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
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final int page;
  const MainScreen({Key key, this.page}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState(this.page);
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex;

  _MainScreenState(int page) {
    this.pageIndex = page;
  }

  List<Widget> pageList = <Widget>[
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskListViewModel()),
        ],
        child: FutureBuilder(
          future: FlutterSession().get('modelId'),
          builder: (context, snapshot) {
            return ModelSchedulePage(
              modelId: snapshot.data.toString(),
            );
          },
        )),
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CastingListViewModel()),
        ],
        child: FutureBuilder(
          builder: (context, snapshot) {
            return ModelApplyCastingPage();
          },
        )),
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => CastingListViewModel()),
    ], child: Home()),
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ImageListViewModel()),
        ],
        child: FutureBuilder(
          future: FlutterSession().get('modelId'),
          builder: (context, snapshot) {
            return ModelImagePage(
              modelId: snapshot.data.toString(),
            );
          },
        )),
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ModelViewModel()),
          ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ],
        child: FutureBuilder(
          future: FlutterSession().get('modelId'),
          builder: (context, snapshot) {
            return ModelProfilePage(
              modelId: snapshot.data.toString(),
            );
          },
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
