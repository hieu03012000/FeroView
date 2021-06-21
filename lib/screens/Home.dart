import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fero/components/bottom_navigator.dart';
import 'package:fero/components/casting_list_view.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/screens/ModelProfilePage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Body()),
      bottomNavigationBar: buildNavigationBar(context, 2),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      // leading: IconButton(
      //   icon: const Icon(Icons.menu),
      //   onPressed: () {},
      //
      //   color: Colors.white,
      // ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);
  // final List<CastingList> castingList;
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //Total height and width of the screen
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      HeaderWithSearchBox(size: size),
      TitleWithButton(
        text: "Upcoming Casting",
      ),
      Casting(),
      TitleWithButton(
        text: "Notification",
      ),
      Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              RecommendNotification(
                title:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                date: 'Today, 12:00',
              ),
              RecommendNotification(
                title:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                date: 'Today, 12:00',
              ),
              RecommendNotification(
                title:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                date: 'Today, 12:00',
              ),
              RecommendNotification(
                title:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                date: 'Today, 12:00',
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}

class RecommendNotification extends StatelessWidget {
  const RecommendNotification({Key key, this.title, this.date})
      : super(key: key);

  final String title, date;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: kPrimaryColor)),
      padding: EdgeInsets.all(kDefaultPadding / 4),
      margin: EdgeInsets.only(
          left: kDefaultPadding * 1.5,
          right: kDefaultPadding * 1.5,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5),
      width: size.width * 0.7,
      height: size.height * 0.1,
      child: Container(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "$title\n", style: Theme.of(context).textTheme.button),
              TextSpan(
                text: date,
                style: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleWithButton extends StatelessWidget {
  const TitleWithButton({Key key, this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(children: <Widget>[
        TitleWithCustomUnderline(
          text: text,
        ),
        Spacer(),
        FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: kPrimaryColor,
            onPressed: () {},
            child: Text(
              'More',
              style: TextStyle(color: Colors.white),
            ))
      ]),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(right: kDefaultPadding / 4),
                height: 7,
                color: kPrimaryColor.withOpacity(0.2),
              ))
        ],
      ),
    );
  }
}

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({Key key, @required this.size}) : super(key: key);

  final Size size;
  final String modelName = 'Model Name';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Hi ' + modelName + '!',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                  ),
                ),
                Spacer(),
                // Image.asset(name)
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: kPrimaryColor.withOpacity(0.23))
                    ]),
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: kPrimaryColor.withOpacity(0.5),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: const Icon(Icons.search)),
                ),
              )),
        ],
      ),
    );
  }
}
