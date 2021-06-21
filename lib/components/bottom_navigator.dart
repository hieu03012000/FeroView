import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fero/screens/ModelProfilePage.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter/material.dart';

CurvedNavigationBar buildNavigationBar(BuildContext context) {
  return CurvedNavigationBar(
    backgroundColor: kBackgroundColor,
    color: kTextColor,
    index: 2,
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
      if(index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ModelProfilePage(
                modelId: 'MD0021',
              )),
        )
      }
    },
  );
}