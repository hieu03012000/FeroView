import 'package:fero/models/ModelDetail.dart';
import 'package:fero/models/ModelList.dart';
import 'package:fero/models/UpdateModelProfile.dart';
import 'package:fero/screens/ModelProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          color: Color(0xFFF54E5E),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Update profile',
          style: TextStyle(
            color: Color(0xFFF54E5E),
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
        child: FutureBuilder(
          future: getModelDetail(widget.modelId),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              UpdateModel.fromUpdateModel(snapshot.data);
              return  ModelUpdate(modelDetail: UpdateModel.fromUpdateModel(snapshot.data));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
            },
          ),
        ),
    );
  }
}

class ModelUpdate extends StatefulWidget {
  final UpdateModel modelDetail;
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
              primary: Color(0xFFF54E5E),
              onPrimary: Colors.white,
              surface: Color(0xFFF54E5E),
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
            cursorColor: Color(0xFFF54E5E),
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
            cursorColor: Color(0xFFF54E5E),
            initialValue: castGender(widget.modelDetail.gender),
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
              cursorColor: Color(0xFFF54E5E),
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
                onPrimary: Color(0xFFF54E5E),
              ),
              icon: Icon(Icons.calendar_today,),
              label: Text(''),
            ),

          TextFormField(
            cursorColor: Color(0xFFF54E5E),
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
            cursorColor: Color(0xFFF54E5E),
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
            cursorColor: Color(0xFFF54E5E),
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
          SizedBox(height: 30,),
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
              await updateModelDetail(params);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModelProfilePage(modelId: widget.modelDetail.id)),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFF54E5E),
              elevation: 0,
              minimumSize: Size(10, 50),
            ),
          ),
        ],
      )
    );
  }
}

