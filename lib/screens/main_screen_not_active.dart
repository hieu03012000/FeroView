import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fero/components/tab_navigator.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreenNotActive extends StatefulWidget {
  @override
  _MainScreenNotActiveState createState() => _MainScreenNotActiveState();
}

class _MainScreenNotActiveState extends State<MainScreenNotActive> {
  String _currentPage = "Page5";
  List<String> pageKeys = ["Page4", "Page5"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 1;

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
          if (_currentPage != "Page5") {
            _selectTab("Page5", 2);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
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
