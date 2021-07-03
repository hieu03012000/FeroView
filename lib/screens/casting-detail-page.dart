import 'package:fero/services/apply-casting-service.dart';
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.casting.name + ' Casting'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor,
                  offset: Offset(0, 5),
                  blurRadius: 10,
                )
              ]),
          child: Column(
            children: <Widget>[
              Text(widget.casting.name),
              Text(widget.casting.openTime),
              Text(widget.casting.closeTime),
              Text(widget.casting.customerName),
              Text(widget.casting.description),
              Text(widget.casting.salary.toString()),
              SizedBox(
                height: 20,
              ),
              ActionButton(
                open: widget.casting.openTimeDateTime,
                close: widget.casting.closeTimeDateTime,
                castingId: widget.casting.id,
                casting: widget.casting,
              )
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
  const ActionButton({Key key, this.open, this.close, this.castingId, this.casting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime currentDateTime = DateTime.now();
    if (open.isBefore(currentDateTime) && close.isAfter(currentDateTime)) {
      return FutureBuilder(
        future: ApplyCastingSrevice().isApply(castingId),
        builder: (context, snapshot) {
          if (snapshot.data.toString() == 'true') {
            return Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await ApplyCastingSrevice()
                        .deleteApplyCasting(this.castingId);
                  _reloadPage(context, this.casting);

                  },
                  child: Text('Cancel'),
                )
              ],
            );
          } else {
            return Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await ApplyCastingSrevice()
                        .createApplyCasting(this.castingId);
                  _reloadPage(context, this.casting);

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
                            casting: casting,
                          );
                        },
                      ))),
        );
}
