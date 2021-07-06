import 'package:fero/services/apply_casting_service.dart';
import 'package:fero/services/push_notification_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_list_view_model.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastingDetailPage extends StatefulWidget {
  final CastingViewModel casting;
  CastingDetailPage({Key key, this.casting}) : super(key: key);

  @override
  _CastingDetailPageState createState() => _CastingDetailPageState();
}

class _CastingDetailPageState extends State<CastingDetailPage> {
  @override
  void initState() {
    super.initState();
    // PushNotificationService().init();
    PushNotificationService().initLocal();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.casting.name + ' Casting'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      widget.casting.name,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          widget.casting.getStatus,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kBackgroundColor),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: widget.casting.getStatus == 'Opening'
                                ? Colors.green
                                : widget.casting.getStatus == 'Closed'
                                    ? kNumberColor
                                    : Colors.grey[800])),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 90,
                          child: Text(
                            'Open at:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.event_available,
                                    )),
                                Text(
                                  widget.casting.openDate,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.schedule,
                                    )),
                                Text(
                                  widget.casting.openTime,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 90,
                          child: Text(
                            'Close at:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.event_available,
                                    )),
                                Text(
                                  widget.casting.closeDate,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.schedule,
                                    )),
                                Text(
                                  widget.casting.closeTime,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            'Salary:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            child: Text(
                          widget.casting.salary,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kNumberColor),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            'Organised by:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            width: 160,
                            child: Text(
                              widget.casting.customerName,
                              style: TextStyle(fontSize: 16),
                            )),
                      ],
                    ),
                    const Divider(height: 40, thickness: 1),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            'Description:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        widget.casting.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              ActionButton(
                open: widget.casting.openTimeDateTime,
                close: widget.casting.closeTimeDateTime,
                castingId: widget.casting.id,
                casting: widget.casting,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final DateTime open, close;
  final int castingId;
  final CastingViewModel casting;
  const ActionButton(
      {Key key, this.open, this.close, this.castingId, this.casting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime currentDateTime = DateTime.now();
    if (open.isBefore(currentDateTime) && close.isAfter(currentDateTime)) {
      return FutureBuilder(
        future: ApplyCastingService().isApply(castingId),
        builder: (context, snapshot) {
          if (snapshot.data.toString() == 'true') {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    elevation: 0,
                    minimumSize: Size(10, 50),
                  ),
                  onPressed: () async {
                    await ApplyCastingService()
                        .deleteApplyCasting(this.castingId);
                    _reloadPage(context, this.casting);
                  },
                  child: Text('Cancel'),
                )
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    elevation: 0,
                    minimumSize: Size(10, 50),
                  ),
                  onPressed: () async {
                    await ApplyCastingService()
                        .createApplyCasting(this.castingId, this.close);
                    _reloadPage(context, this.casting);
                    PushNotificationService()
                        .showNotification(this.close, casting);
                  },
                  child: Text('Apply'),
                )
              ],
            );
          }
        },
      );
    }
    return Container(
      child: null,
    );
  }
}

void _reloadPage(BuildContext context, CastingViewModel casting) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => CastingListViewModel()),
                ],
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    return CastingDetailPage(
                      casting: casting,
                    );
                  },
                ))),
  );
}
