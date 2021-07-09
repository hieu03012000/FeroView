import 'package:fero/screens/casting_detail_page.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Casting extends StatefulWidget {
  const Casting({Key key}) : super(key: key);
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
            height: 270, // constrain height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: listCasting.castings.length,
              itemBuilder: (context, index) {
                return CastingView(list: listCasting.castings[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class CastingView extends StatelessWidget {
  final CastingViewModel list;
  const CastingView({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (list.openTimeDateTime.isBefore(DateTime.now()) &&
            list.closeTimeDateTime.isAfter(DateTime.now()))
        ? GestureDetector(
            onTap: () {
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
                                return CastingDetailPage(
                                  casting: list,
                                );
                              },
                            ))),
              );
            },
            child: Container(
              width: 170,
              margin: EdgeInsets.only(
                  left: kDefaultPadding / 2,
                  right: kDefaultPadding / 2,
                  bottom: kDefaultPadding),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: kPrimaryColor,
                    // width: 2,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-2, 5),
                      blurRadius: 10,
                      color: kPrimaryColor.withOpacity(0.3),
                    )
                  ]),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(kDefaultPadding / 2),
                            topRight: Radius.circular(kDefaultPadding),
                            // bottomRight: Radius.circular(kDefaultPadding / 2),
                            bottomLeft: Radius.circular(kDefaultPadding),
                          )),
                      width: 100,
                      height: 30,
                      child: Center(
                        child: Text(
                          list.salary.toString(),
                          style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(kDefaultPadding * 2),
                              bottom: Radius.circular(kDefaultPadding * 2),
                            )),
                        width: 170,
                        // height: 175,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                list.name,
                                style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Create by ${list.customerName}',
                                style: TextStyle(
                                    color: kTextColor.withOpacity(0.6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Open time: ",
                                style: TextStyle(
                                    color: kTextColor.withOpacity(0.8),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 12,
                                  ),
                                  Text(
                                    '  ${list.openDate} at ${list.openTime}',
                                    style: TextStyle(
                                        color: kTextColor.withOpacity(0.8),
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Close time: ",
                                style: TextStyle(
                                    color: kTextColor.withOpacity(0.8),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 12,
                                  ),
                                  Text(
                                    '  ${list.closeDate} at ${list.closeTime} ',
                                    style: TextStyle(
                                        color: kTextColor.withOpacity(0.8),
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Container(
                                    child: Text(
                                      list.getStatus ?? '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kBackgroundColor),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: list.getStatus == 'Opening'
                                            ? Colors.green
                                            : list.getStatus == 'Closed'
                                                ? kNumberColor
                                                : Colors.grey[800])),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : Container(
            child: null,
          );
  }
}
