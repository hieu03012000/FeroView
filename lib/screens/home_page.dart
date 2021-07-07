import 'package:fero/components/casting_list_view.dart';
import 'package:fero/screens/notification_page.dart';
import 'package:fero/screens/search_casting_page.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //Total height and width of the screen
    return SafeArea(
      child: Scaffold(
          body: Column(children: <Widget>[
        HeaderWithSearchBox(size: size),
        TitleWithButton(
          text: "Upcoming Casting",
        ),
        Casting(),
        TitleWithButton(
          text: "Notification",
        ),
        Expanded(
            child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
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
        )),
      ])),
    );
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
          top: kDefaultPadding / 3,
          bottom: kDefaultPadding / 2),
      width: size.width * 0.9,
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
            onPressed: () {
              if (text == 'Notification') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationPage(),
                    ));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                    create: (_) => CastingListViewModel()),
                              ],
                              child: FutureBuilder(
                                builder: (context, snapshot) {
                                  return SearchCastingPage(
                                    name: '',
                                    min: '',
                                    max: '',
                                  );
                                },
                              ))),
                );
              }
            },
            child: Text(
              'More',
              style: TextStyle(color: kTextColor),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
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
                    child: SizedBox(
                      width: 300,
                      child: FutureBuilder(
                        future: FlutterSession().get('modelName'),
                        builder: (context, snapshot) {
                          return Text(
                            'Hi ' + snapshot.data.toString() + '!',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                          );
                        },
                      ),
                    )),
                Spacer(),
                // Image.asset(name)
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _showDialog(context);
              },
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
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search),
                    SizedBox(
                      height: 5,
                      width: 20,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  TextEditingController nameController, minController, maxController;
  nameController = TextEditingController()..text = '';
  minController = TextEditingController()..text = '';
  maxController = TextEditingController()..text = '';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Search"),
        content: Builder(
          builder: (context) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.
            // var height = MediaQuery.of(context).size.height;
            // var width = MediaQuery.of(context).size.width;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 180,
              width: 350,
              child: ListView(
                children: [
                  TextFormField(
                    cursorColor: kPrimaryColor,
                    controller: nameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.drive_file_rename_outline),
                      labelText: 'Name',
                    ),
                  ),
                  TextFormField(
                    cursorColor: kPrimaryColor,
                    controller: minController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(Icons.drive_file_rename_outline),
                      labelText: 'Min salary',
                    ),
                  ),
                  TextFormField(
                    cursorColor: kPrimaryColor,
                    controller: maxController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(Icons.drive_file_rename_outline),
                      labelText: 'Max salary',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text(
              'Search',
              style: TextStyle(color: kPrimaryColor),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (_) => CastingListViewModel()),
                            ],
                            child: FutureBuilder(
                              builder: (context, snapshot) {
                                return SearchCastingPage(
                                  name: nameController.text.toString(),
                                  min: minController.text.toString(),
                                  max: maxController.text.toString(),
                                );
                              },
                            ))),
              );
              // Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
