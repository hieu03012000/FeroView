import 'package:fero/screens/home_page.dart';
import 'package:fero/screens/model_apply_casting_page.dart';
import 'package:fero/screens/model_image_page.dart';
import 'package:fero/screens/model_profile_page.dart';
import 'package:fero/screens/model_schedule_page.dart';
import 'package:fero/services/google_sign_in.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/image_collection_list_view_model.dart';
import 'package:fero/viewmodels/image_collection_view_model.dart';
import 'package:fero/viewmodels/model_view_model.dart';
import 'package:fero/viewmodels/task_list_view_model.dart';
import 'package:fero/viewmodels/image_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Page1")
      child = Page1();
    else if (tabItem == "Page2")
      child = Page2();
    else if (tabItem == "Page3")
      child = Page3();
    else if (tabItem == "Page4")
      child = Page4();
    else if (tabItem == "Page5") child = Page5();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        ));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CastingListViewModel()),
        ],
        child: FutureBuilder(
          builder: (context, snapshot) {
            return ModelApplyCastingPage();
          },
        ));
  }
}

class Page3 extends StatefulWidget {
  const Page3({Key key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => CastingListViewModel()),
    ], child: Home());
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ImageCollectionListViewModel()),
        ],
        child: FutureBuilder(
          future: FlutterSession().get('modelId'),
          builder: (context, snapshot) {
            return ModelImagePage(
              modelId: snapshot.data.toString(),
            );
          },
        ));
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        ));
  }
}
