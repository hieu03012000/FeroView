import 'package:fero/screens/update_measure_page.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/body_attribut_list_view_model.dart';
import 'package:fero/viewmodels/body_part_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeasureTemplatePage extends StatefulWidget {
  final String modelId;
  MeasureTemplatePage({Key key, this.modelId}) : super(key: key);

  @override
  _MeasureTemplatePageState createState() => _MeasureTemplatePageState();
}

class _MeasureTemplatePageState extends State<MeasureTemplatePage> {
  List<String> bodyList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Text('Measure template'),
            ),
            body: FutureBuilder<BodyPartListViewModel>(
              future: Provider.of<BodyPartListViewModel>(context, listen: false)
                  .getBodyPartList(),
              builder: (ctx, prevData) {
                if (prevData.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else {
                  if (prevData.error == null) {
                    return Consumer<BodyPartListViewModel>(
                      builder: (ctx, data, child) => Center(
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 30),
                              itemCount: data.bodyParts.length,
                              itemBuilder: (context, index) {
                                return CompButton(
                                  temp: data.bodyParts[index].name,
                                  bodyPartId: data.bodyParts[index].id,
                                  modelId: widget.modelId,
                                );
                              })),
                    );
                  } else {
                    return Text('Error');
                  }
                }
              },
            )));
  }
}

class CompButton extends StatelessWidget {
  final String temp;
  final String modelId;
  final int bodyPartId;
  const CompButton({Key key, this.temp, this.modelId, this.bodyPartId}) : super(key: key);

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
              color: kPrimaryColor.withOpacity(0.5),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: kPrimaryColor,
            // width: 2,
          ),
        ),
        child: FlatButton(
          padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Color(0xFFF0F0F0),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => BodyAttributeListViewModel()),
                  ],
                  child: UpdateMeasurePage(
                    bodyPartId: bodyPartId,
                    modelId: modelId,
                    template: temp,
                  )),
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
