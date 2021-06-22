import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Casting extends StatefulWidget {
  @override
  _CastingState createState() => _CastingState();
}

class _CastingState extends State<Casting> {
  @override
  void initState() {
    super.initState();
    Provider.of<CastingListViewModel>(context, listen: false).topHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    var listCasting = Provider.of<CastingListViewModel>(context);
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 280, // constrain height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildCarousel(context, listCasting.castings[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, CastingViewModel list) {
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
                          list.openTime != null ? list.openTime : "",
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
                          list.openTime != null ? list.closeTime : "",
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
