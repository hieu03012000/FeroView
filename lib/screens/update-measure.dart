
import 'package:flutter/material.dart';

class UpdateMeasurePage extends StatefulWidget {
  final String modelId, template;
  UpdateMeasurePage({Key key, this.modelId, this.template}) : super(key: key);

  @override
  _UpdateMeasurePageState createState() => _UpdateMeasurePageState();
}

class _UpdateMeasurePageState extends State<UpdateMeasurePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
       child: Scaffold(
         appBar: AppBar(
           title: Text(widget.template),
         ),
       ),
    );
  }
}