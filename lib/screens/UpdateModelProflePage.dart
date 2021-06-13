import 'package:fero/models/ModelDetail.dart';
import 'package:fero/models/ModelList.dart';
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
              return  ModelUpdate(modelDetail: snapshot.data);
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

class ModelUpdate extends StatelessWidget {
  final ModelDetail modelDetail;
  const ModelUpdate({Key key, this.modelDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        children: [
          TextFormField(
            cursorColor: Color(0xFFF54E5E),
            initialValue: modelDetail.name,
            decoration: InputDecoration(
              icon: Icon(Icons.drive_file_rename_outline),
              labelText: 'Name',
              // suffixIcon: Icon(
              //   Icons.check_circle,
              // ),
            ),
          ),
          TextFormField(
            cursorColor: Color(0xFFF54E5E),
            initialValue: castGender(modelDetail.gender),
            decoration: InputDecoration(
              icon: Icon(Icons.drive_file_rename_outline),
              labelText: 'Gender',
              // suffixIcon: Icon(
              //   Icons.check_circle,
              // ),
            ),
          ),
          TextFormField(
            cursorColor: Color(0xFFF54E5E),
            initialValue: modelDetail.dateOfBirth,
            decoration: InputDecoration(
              icon: Icon(Icons.drive_file_rename_outline),
              labelText: 'Date of birth',
              // suffixIcon: Icon(
              //   Icons.check_circle,
              // ),
            ),
          ),
          TextFormField(
            cursorColor: Color(0xFFF54E5E),
            initialValue: modelDetail.phone,
            decoration: InputDecoration(
              icon: Icon(Icons.drive_file_rename_outline),
              labelText: 'Phone number',
              // suffixIcon: Icon(
              //   Icons.check_circle,
              // ),
            ),
          ),
          TextFormField(
            cursorColor: Color(0xFFF54E5E),
            initialValue: modelDetail.subAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.drive_file_rename_outline),
              labelText: 'Address',
              // suffixIcon: Icon(
              //   Icons.check_circle,
              // ),
            ),
          ),
          TextFormField(
            cursorColor: Color(0xFFF54E5E),
            initialValue: modelDetail.gifted,
            decoration: InputDecoration(
              icon: Icon(Icons.drive_file_rename_outline),
              labelText: 'Gifted',
              // suffixIcon: Icon(
              //   Icons.check_circle,
              // ),
            ),
          ),
        ],
      )
    );
  }
}

