import 'dart:io';

import 'package:fero/screens/main_screen.dart';
import 'package:fero/screens/model_profile_page.dart';
import 'package:fero/services/image_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/model_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CameraWidget extends StatefulWidget {
  final String modelId;
  const CameraWidget({Key key, this.modelId}) : super(key: key);

  @override
  State createState() {
    return CameraWidgetState();
  }
}

class CameraWidgetState extends State<CameraWidget> {
  @override
  void initState() {
    super.initState();
    // PushNotificationService().init(context);
  }

  PickedFile imageFile;
  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: kPrimaryColor),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 2,
                    color: kPrimaryColor,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.image,
                      color: kPrimaryColor,
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: kPrimaryColor,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: () => {_showChoiceDialog(context)},
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(160)),
                      border: Border.all(
                        color: kPrimaryColor,
                      )),
                  child: (imageFile == null)
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Choose Image",
                              style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(File(imageFile.path)),
                                fit: BoxFit.cover),
                          ),
                        ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  if (imageFile != null) {
                    uploadFireBase(imageFile.path, widget.modelId);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider(
                                        create: (_) => ModelViewModel()),
                                  ],
                                  child: FutureBuilder(
                                    builder: (context, snapshot) {
                                      return ModelProfilePage(
                                        modelId: widget.modelId,
                                      );
                                    },
                                  ))),
                    );
                  } else {
                    Fluttertoast.showToast(msg: 'Please choose image');
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => MainScreen(),
                  //     ));
                },
                color: kPrimaryColor,
                child: Text(
                  "Select Image",
                  style: TextStyle(color: kTextColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }
}
