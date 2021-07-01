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
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

class MainScreenNotActive extends StatefulWidget {
  final int page;
  const MainScreenNotActive({Key key, this.page}) : super(key: key);

  @override
  _MainScreenNotActiveState createState() => _MainScreenNotActiveState(this.page);
}

class _MainScreenNotActiveState extends State<MainScreenNotActive> {
  int pageIndex;

  _MainScreenNotActiveState(int page) {
    this.pageIndex = page;
  }

  List<Widget> pageList = <Widget>[
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
