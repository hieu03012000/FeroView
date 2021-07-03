import 'package:fero/services/apply-casting-service.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  const ActionButton({Key key, this.open, this.close, this.castingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime currentDateTime = DateTime.now();
    if (open.isBefore(currentDateTime) && close.isAfter(currentDateTime)) {
      return Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              await ApplyCastingSrevice().createApplyCasting(castingId);
            },
            child: Text('Apply'),
          )
        ],
      );
    }
    return Container(
      child: null,
    );
  }
}
