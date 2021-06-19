import 'package:fero/models/Images.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoadImage extends StatefulWidget  {
  const LoadImage({Key key}) : super(key: key);

  @override
  _LoadImageState createState() => _LoadImageState();
}

class _LoadImageState extends State<LoadImage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        child: Center(
          child: FutureBuilder(
            future: getAvatar("MD0021"),
          ),
        ),
      ),
    );
  }
}
