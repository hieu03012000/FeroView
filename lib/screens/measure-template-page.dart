import 'package:fero/screens/main_screen.dart';
import 'package:fero/screens/update-measure.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/body-attribut-list-view-model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeasureTemplatePage extends StatefulWidget {
  final String modelId;
  final String template;
  MeasureTemplatePage({Key key, this.modelId, this.template}) : super(key: key);

  @override
  _MeasureTemplatePageState createState() => _MeasureTemplatePageState();
}

class _MeasureTemplatePageState extends State<MeasureTemplatePage> {
  List<String> bodyList = [];

  void loadData(String temp) {
    if (temp.endsWith('1')) bodyList = ['Body', 'Upper part', 'Bottom'];
    if (temp.endsWith('Upper part')) bodyList = ['Arm', 'Hand', 'Shoulder'];
    if (temp.endsWith('Bottom')) bodyList = ['Leg', 'Foot'];
  }

  @override
  Widget build(BuildContext context) {
    loadData(widget.template);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text('Measure template'),
          ),
          body: ListView.builder(
              padding: EdgeInsets.only(top: 30),
              itemCount: bodyList.length,
              itemBuilder: (context, index) {
                return CompButton(
                  temp: bodyList[index],
                  modelId: widget.modelId,
                );
              })),
    );
  }
}

class CompButton extends StatelessWidget {
  final String temp;
  final String modelId;
  const CompButton({Key key, this.temp, this.modelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Color(0xFFF0F0F0),
          onPressed: () {
            temp != 'Upper part' && temp != 'Bottom'
                ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (_) => BodyAttributeListViewModel()),
                        ],
                        child: UpdateMeasurePage(
                          modelId: modelId,
                          template: temp,
                        )),
                  ))
                : Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        MeasureTemplatePage(modelId: modelId, template: temp),
                  ));
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  temp,
                  style: TextStyle(fontSize: 16),
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
    );
  }
}
