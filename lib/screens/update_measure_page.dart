import 'package:fero/screens/main_screen.dart';
import 'package:fero/screens/main_screen_not_active.dart';
import 'package:fero/services/push_notification_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/body_attribut_list_view_model.dart';
import 'package:fero/viewmodels/body_attribute_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

class UpdateMeasurePage extends StatefulWidget {
  final String modelId, template;
  UpdateMeasurePage({Key key, this.modelId, this.template}) : super(key: key);

  @override
  _UpdateMeasurePageState createState() => _UpdateMeasurePageState();
}

class _UpdateMeasurePageState extends State<UpdateMeasurePage> {
  List<String> bodyList = [];

  @override
  void initState() {
    super.initState();
    // PushNotificationService().init(context);
  }

  void loadData(String temp) {
    if (temp == 'Arm') bodyList = ['Length', 'Wrist', 'Arm', 'Elbow'];
    if (temp == 'Hand') bodyList = ['Length', 'Finger', 'Palm'];
    if (temp == 'Shoulder') bodyList = ['Wide'];
    if (temp == 'Leg') bodyList = ['Length', 'Thing', 'Calf', 'Knee'];
    if (temp == 'Foot') bodyList = ['Toe', 'Heel', 'Sole'];
  }

  @override
  Widget build(BuildContext context) {
    loadData(widget.template);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.template),
          ),
          body: widget.template != 'Body'
              ? ListView.builder(
                  padding: EdgeInsets.all(30),
                  itemCount: bodyList.length,
                  itemBuilder: (context, index) {
                    return MeasureTextBox(
                      name: bodyList[index],
                    );
                  },
                )
              : FutureBuilder(
                  future: Provider.of<BodyAttributeListViewModel>(context,
                          listen: false)
                      .getAttList(widget.modelId, widget.template),
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
                        return Consumer<BodyAttributeListViewModel>(
                            builder: (ctx, data, child) => Center(
                                  child: AttView(context: ctx, atts: data),
                                ));
                      } else {
                        return Text('Error');
                      }
                    }
                  },
                )),
    );
  }
}

class AttView extends StatefulWidget {
  final BuildContext context;
  final BodyAttributeListViewModel atts;
  final List<TextEditingController> list = [];
  AttView({Key key, this.context, this.atts}) : super(key: key);

  @override
  _AttViewState createState() => _AttViewState();
}

class _AttViewState extends State<AttView> {
  @override
  void dispose() {
    for (int i = 0; i < widget.atts.atts.length; i++) {
      widget.list.elementAt(i).dispose();
    }
    super.dispose();
  }

  void _loadData() {
    for (int i = 0; i < widget.atts.atts.length; i++) {
      TextEditingController controller = TextEditingController()
        ..text = widget.atts.atts.elementAt(i).value.toString();
      widget.list.add(controller);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              child: new ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(30),
            itemCount: widget.atts.atts.length,
            itemBuilder: (context, index) {
              return MeasureComponent(
                model: widget.atts.atts[index],
                controller: widget.list?.elementAt(index) ?? '',
              );
            },
          )
              // ),
              ),
          ElevatedButton(
            child: Text('UPDATE', style: TextStyle(color: kTextColor)),
            onPressed: () async {
              List<Map<String, dynamic>> params = [];
              for (int i = 0; i < widget.list.length; i++) {
                Map<String, dynamic> param = Map<String, dynamic>();
                param['id'] = widget.atts.atts.elementAt(i).id;
                param['value'] = double.parse(widget.list.elementAt(i).text);
                param['bodyAttTypeId'] =
                    widget.atts.atts.elementAt(i).bodyAttTypeId;
                param['bodyPartId'] = widget.atts.atts.elementAt(i).bodyPartId;
                params.add(param);
              }
              var provider = Provider.of<BodyAttributeListViewModel>(context,
                  listen: false);
              provider.updateAtt(params);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
              elevation: 0,
              minimumSize: Size(10, 50),
            ),
          ),
        ],
      ),
    );
  }
}

class MeasureComponent extends StatelessWidget {
  final ModelAttributeViewModel model;
  final TextEditingController controller;
  const MeasureComponent({Key key, this.model, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: kPrimaryColor,
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(Icons.drive_file_rename_outline),
        labelText: model.bodyPartName +
            ' (' +
            model.bodyAttName +
            ') ' +
            model.measure,
      ),
    );
  }
}

class MeasureTextBox extends StatelessWidget {
  final String name;
  const MeasureTextBox({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        icon: Icon(Icons.drive_file_rename_outline),
        labelText: name,
      ),
    );
  }
}
