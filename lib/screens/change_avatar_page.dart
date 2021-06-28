import 'dart:io';

import 'package:fero/screens/main_screen.dart';
import 'package:fero/services/image_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatefulWidget{
  final String modelId;
  const CameraWidget({Key key, this.modelId}) : super(key: key);

  @override
  State createState() {
    return CameraWidgetState();
  }

}

class CameraWidgetState extends State<CameraWidget>{
  PickedFile imageFile;
  Future _showChoiceDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose option",style: TextStyle(color: kPrimaryColor),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 2,color: kPrimaryColor,),
              ListTile(
                onTap: (){
                  _openGallery(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.image,color: kPrimaryColor,),
              ),

              Divider(height: 2,color: kPrimaryColor,),
              ListTile(
                onTap: (){
                  _openCamera(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera,color: kPrimaryColor,),
              ),
            ],
          ),
        ),);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Change avatar"),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => {
                  _showChoiceDialog(context)
                },
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(160)),
                      border: Border.all(color: kPrimaryColor,)
                  ),
                  child:(imageFile==null) ?
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Choose Image",
                        style: TextStyle(
                            color: kBackgroundColor,
                            fontSize: 20,
                            fontStyle: FontStyle.italic
                        ),
                      ) ,
                    ),
                  ):
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(File(imageFile.path)),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: (){
                  uploadFireBase(imageFile.path, widget.modelId);
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                        MainScreen(page: 4),
                  )
                );
                  },
                color: kPrimaryColor,
                child: Text(
                  "Select Image",
                  style: TextStyle(
                      color: kBackgroundColor
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera ,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }
}

