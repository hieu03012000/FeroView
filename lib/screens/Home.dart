import 'package:fero/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
        color: Colors.white,
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //Total height and width of the screen
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      HeaderWithSearchBox(size: size),
      TitleWithButton(text: "Upcoming Casting",),
      SingleChildScrollView(

        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            RecommendCasting(
              imageUri: "https://znews-photo.zadn.vn/w1920/Uploaded/ihvjohb/2019_12_08/52684425_762234710836343_8290759092989853696_o.jpg",
              castingName: 'CASTING NAME',
              cusName: 'Customer Name',
              date: '22/6/2021 14:00',
            ),
            RecommendCasting(
              imageUri: "https://znews-photo.zadn.vn/w1920/Uploaded/ihvjohb/2019_12_08/52684425_762234710836343_8290759092989853696_o.jpg",
              castingName: 'CASTING NAME',
              cusName: 'Customer Name',
              date: '22/6/2021 14:00',
            ),
            RecommendCasting(
              imageUri: "https://znews-photo.zadn.vn/w1920/Uploaded/ihvjohb/2019_12_08/52684425_762234710836343_8290759092989853696_o.jpg",
              castingName: 'CASTING NAME',
              cusName: 'Customer Name',
              date: '22/6/2021 14:00',
            ),
            RecommendCasting(
              imageUri: "https://znews-photo.zadn.vn/w1920/Uploaded/ihvjohb/2019_12_08/52684425_762234710836343_8290759092989853696_o.jpg",
              castingName: 'CASTING NAME',
              cusName: 'Customer Name',
              date: '22/6/2021 14:00',
            ),
          ],
        ),
      ),
      TitleWithButton(text: "Notification",),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                RecommendNotification(
                  title: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  date: 'Today, 12:00',
                ),
                RecommendNotification(
                  title: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  date: 'Today, 12:00',
                ),
                RecommendNotification(
                  title: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  date: 'Today, 12:00',
                ),
                RecommendNotification(
                  title: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
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
  const RecommendNotification({Key key, this.title, this.date}) : super(key: key);

  final String title, date;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor)
      ),
      padding: EdgeInsets.all(kDefaultPadding / 4),
      margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5),
      width: size.width * 0.7,
      height: size.height * 0.1,
      child: Container(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "$title\n",
                  style: Theme.of(context).textTheme.button),
              TextSpan(
                text: date,
                style: TextStyle(
                    color: kPrimaryColor.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RecommendCasting extends StatelessWidget {
  const RecommendCasting({Key key, this.imageUri, this.castingName, this.cusName, this.date}) : super(key: key);

  final String imageUri, castingName, cusName, date;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(

        margin: EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding * 2.5),
        width: size.width * 0.4,
        child: Column(
          children: <Widget>[
            Container(
              child: Image(
                image: NetworkImage(
                    imageUri),

              ),
            ),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    )
                  ]
              ),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$castingName\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "By ".toUpperCase() + "$cusName\n",
                          style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5)),
                        ),
                        TextSpan(
                          text: date,
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(''),
                ],
              ),
            ),
          ],
        ));
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
        TitleWithCustomUnderline(text: text,),
        Spacer(),
        FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
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
