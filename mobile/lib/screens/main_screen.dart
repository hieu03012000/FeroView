import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fero/components/tab_navigator.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4", "Page5"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // PushNotificationService().init(context);
  }

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Page1") {
            _selectTab("Page1", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Page1"),
          _buildOffstageNavigator("Page2"),
          _buildOffstageNavigator("Page3"),
          _buildOffstageNavigator("Page4"),
          _buildOffstageNavigator("Page5"),
        ]),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: kPrimaryColor,
          index: _selectedIndex,
          items: <Widget>[
            SizedBox(
              height: 38,
              child: Column(
                children: [
                  Icon(
                    Icons.home,
                    color: kTextColor,
                  ),
                  Center(
                    child: Text(
                      'Home',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 38,
              child: Column(
                children: [
                  Icon(
                    Icons.schedule,
                    color: kTextColor,
                  ),
                  Center(
                    child: Text(
                      'Booking',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 38,
              child: Column(
                children: [
                  Icon(
                    Icons.list_alt,
                    color: kTextColor,
                  ),
                  Center(
                    child: Text(
                      'Request',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 38,
              child: Column(
                children: [
                  Icon(
                    Icons.image,
                    color: kTextColor,
                  ),
                  Center(
                    child: Text(
                      'Gallery',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 38,
              child: Column(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: kTextColor,
                  ),
                  Center(
                    child: Text(
                      'Account',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
          ],
          onTap: (index) {
            _selectTab(pageKeys[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
