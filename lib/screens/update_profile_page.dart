import 'package:fero/utils/constants.dart';
import 'package:fero/screens/model_profile_page.dart';
import 'package:fero/viewmodels/model_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateModelProfilePage extends StatefulWidget {
  final String modelId;
  const UpdateModelProfilePage({Key key, this.modelId}) : super(key: key);

  @override
  _UpdateModelProfilePageState createState() => _UpdateModelProfilePageState();
}

class _UpdateModelProfilePageState extends State<UpdateModelProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: kPrimaryColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Update profile',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(CupertinoIcons.moon_stars, color: Color(0xFFF54E5E),),
        //       onPressed: () => {}
        //   )
        // ],
      ),
      body: Center(
        child: FutureBuilder<ModelViewModel>(
          future: Provider.of<ModelViewModel>(context, listen: false)
              .getModel(widget.modelId),
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
                return Consumer<ModelViewModel>(
                    builder: (ctx, data, child) => ModelUpdate(
                          modelDetail: data,
                        ));
              } else {
                return Text('Error');
              }
            }
          },
        ),
      ),
    );
  }
}

class ModelUpdate extends StatefulWidget {
  final ModelViewModel modelDetail;
  const ModelUpdate({Key key, this.modelDetail}) : super(key: key);

  @override
  _ModelUpdateState createState() => _ModelUpdateState();
}

class _ModelUpdateState extends State<ModelUpdate> {
  DateTime _date;

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1190, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              surface: kPrimaryColor,
              onSurface: Colors.black,
              primaryVariant: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        widget.modelDetail.dateOfBirth = newDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _date = DateTime.parse(widget.modelDetail.dateOfBirth);
    return Container(
        width: 300,
        child: ListView(
          children: [
            TextFormField(
              cursorColor: kPrimaryColor,
              initialValue: widget.modelDetail.name,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Name',
                // suffixIcon: Icon(
                //   Icons.check_circle,
                // ),
              ),
              onChanged: (text) {
                widget.modelDetail.name = text;
              },
            ),
            TextFormField(
              cursorColor: kPrimaryColor,
              initialValue: widget.modelDetail.genderStr,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Gender',
                // suffixIcon: Icon(
                //   Icons.check_circle,
                // ),
              ),
              onChanged: (text) {
                widget.modelDetail.gender = 1;
              },
            ),
            TextFormField(
              cursorColor: kPrimaryColor,
              initialValue: widget.modelDetail.dateOfBirth,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Date of birth',
                // suffixIcon: Icon(
                //   Icons.check_circle,
                // ),
              ),
              // onChanged: (text) {
              //
              //   widget.modelDetail.dateOfBirth = text;
              // },
            ),
            ElevatedButton.icon(
              onPressed: _selectDate,
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
                minimumSize: Size(10, 50),
                onPrimary: kPrimaryColor,
              ),
              icon: Icon(
                Icons.calendar_today,
              ),
              label: Text(''),
            ),
            TextFormField(
              cursorColor: kPrimaryColor,
              initialValue: widget.modelDetail.phone,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Phone number',
                // suffixIcon: Icon(
                //   Icons.check_circle,
                // ),
              ),
              onChanged: (text) {
                widget.modelDetail.phone = text;
              },
            ),
            TextFormField(
              cursorColor: kPrimaryColor,
              initialValue: widget.modelDetail.subAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Address',
                // suffixIcon: Icon(
                //   Icons.check_circle,
                // ),
              ),
              onChanged: (text) {
                widget.modelDetail.subAddress = text;
              },
            ),
            TextFormField(
              cursorColor: kPrimaryColor,
              initialValue: widget.modelDetail.gifted,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Gifted',
                // suffixIcon: Icon(
                //   Icons.check_circle,
                // ),
              ),
              onChanged: (text) {
                widget.modelDetail.gifted = text;
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Text('UPDATE'),
              onPressed: () async {
                Map<String, dynamic> params = Map<String, dynamic>();
                params['id'] = widget.modelDetail.id;
                params['name'] = widget.modelDetail.name;
                params['gender'] = 1.toString();
                params['dateOfBirth'] = widget.modelDetail.dateOfBirth;
                params['subAddress'] = widget.modelDetail.subAddress;
                params['phone'] = widget.modelDetail.phone;
                params['gifted'] = widget.modelDetail.gifted;
                await Provider.of<ModelViewModel>(context, listen: false)
                    .updateProfileModel(params);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        ChangeNotifierProvider<ModelViewModel>.value(
                            value: widget.modelDetail,
                            child: ModelProfilePage(
                                modelId: widget.modelDetail.id))));
              },
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                elevation: 0,
                minimumSize: Size(10, 50),
              ),
            ),
          ],
        ));
  }
}
