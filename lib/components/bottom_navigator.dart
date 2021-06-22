import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fero/screens/Home.dart';
import 'package:fero/screens/model_profile_page.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/model_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

CurvedNavigationBar buildNavigationBar(BuildContext context, int pageIndex) {
  return CurvedNavigationBar(
    backgroundColor: kBackgroundColor,
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
    onTap: (index) => {
      if (index == 2)
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return MultiProvider(providers: [
              ChangeNotifierProvider(
                  create: (_) =>
                      CastingListViewModel()), // add your providers like this.
            ], child: Home());
          }))
        },
      if (index == 4)
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => ModelViewModel()),
                ],
                child: ModelProfilePage(
                  modelId: 'MD0021',
                ));
          }))
        }
    },
  );
}
