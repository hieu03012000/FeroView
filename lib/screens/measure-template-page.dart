import 'package:fero/screens/main_screen.dart';
import 'package:fero/screens/update-measure.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeasureTemplatePage extends StatefulWidget {
  final String modelId;
  MeasureTemplatePage({Key key, this.modelId}) : super(key: key);

  @override
  _MeasureTemplatePageState createState() => _MeasureTemplatePageState();
}

class _MeasureTemplatePageState extends State<MeasureTemplatePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Measure template'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-2, 5),
                      blurRadius: 10,
                      color: kPrimaryColor.withOpacity(0.3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FlatButton(
                  padding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(0xFFF0F0F0),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => UpdateMeasurePage(modelId: widget.modelId,template: 'Body'),
                    ));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Body',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                      ),
                       SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-2, 5),
                      blurRadius: 10,
                      color: kPrimaryColor.withOpacity(0.3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FlatButton(
                  padding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(0xFFF0F0F0),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MainScreen(page: 2),
                    ));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Arm',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                      ),
                       SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
