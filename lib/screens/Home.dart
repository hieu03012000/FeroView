import 'package:fero/constants.dart';
import 'package:fero/models/CastingList.dart';
import 'package:fero/screens/ModelProfilePage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: buildAppBar(),
      body: Center(
        child: FutureBuilder(
          future: getCastingList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Body(castingList: snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      )
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
  const Body({Key key, this.castingList}) : super(key: key);
  final List<CastingList> castingList;
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
      ListCasting(list: castingList),
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

class ListCasting extends StatelessWidget {
  const ListCasting({Key key, this.list}) : super(key: key);

  final List<CastingList> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 280, // constrain height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _buildCarousel(context, list[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, CastingList list) {
    Size size = MediaQuery.of(context).size;
    String imageUri =
        "https://cocainemodels.de/wp-content/uploads/2020/08/berlin-casting-models-rolltreppe-einladung-neue-gesichter-15-jahre-16-jahre-teenager-agentur.jpg";
    return Container(
      width: 220,
      margin: EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
          bottom: kDefaultPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
          boxShadow: [
            BoxShadow(
              offset: Offset(-2, 5),
              blurRadius: 10,
              color: kPrimaryColor.withOpacity(0.3),
            )
          ]),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(kDefaultPadding / 2),
            child: Image.network(
              imageUri,
              height: 220.0,
              // width: 100.0,
            ),
          ),
          Positioned(
              top: 180,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(kDefaultPadding * 2),
                      bottom: Radius.circular(kDefaultPadding / 2),
                    )),
                width: 220,
                height: 80,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      list.name,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Open time: ",
                          style: TextStyle(
                              color: kTextColor.withOpacity(0.8), fontSize: 12),
                        ),
                        Text(
                          list.openTime != null
                              ? formatDate(list.openTime)
                              : "",
                          style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.8),
                              fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Close time: ",
                          style: TextStyle(
                              color: kTextColor.withOpacity(0.8), fontSize: 12),
                        ),
                        Text(
                          list.openTime != null
                              ? formatDate(list.closeTime)
                              : "",
                          style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.8),
                              fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
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
                Text(
                  'Hi ' + modelName + '!',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
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

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage('assets/images/cover.jpg'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModelProfilePage(
                          modelId: 'MD0021',
                        )),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
