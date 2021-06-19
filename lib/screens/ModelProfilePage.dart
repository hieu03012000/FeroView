import 'package:fero/constants.dart';
import 'package:fero/models/ModelDetail.dart';
import 'package:fero/screens/UpdateModelProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelProfilePage extends StatefulWidget {
  final String modelId;
  const ModelProfilePage({Key key, this.modelId}) : super(key: key);

  @override
  _ModelProfilePageState createState() => _ModelProfilePageState();
}

class _ModelProfilePageState extends State<ModelProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center (
          child: Text(
            'Profile',
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
        ),
        leading: BackButton(
            color: kPrimaryColor,
          ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.ac_unit, color: Colors.white,),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: getModelDetail(widget.modelId),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              // return  ModelButtons(modelDetail: snapshot.data);
              return  ModelButtons(modelDetail: snapshot.data,);
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

class ModelButtons extends StatelessWidget {
  final ModelDetail modelDetail;
  const ModelButtons({Key key, this.modelDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(height: 20,),
        Stack(
          children: [
            Container(
              height: 160,
              margin: EdgeInsets.only(left: 120, right: 120),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image:  DecorationImage(
                  image: NetworkImage (
                      modelDetail.avatar
                  ),
                  fit: BoxFit.cover
                )
              ),
            ),
            Positioned(
              bottom: 5,
              right: 125,
              child: GestureDetector(
                onTap: () {},
                child: ClipOval (
                    child: Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        child: ClipOval(
                            child: Container (
                              padding: EdgeInsets.all(8),
                              color: kPrimaryColor,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 25,
                              ),
                            ))
                    )
                ),
              )
            ),
          ],
        ),
        Container(
          width: 50,
          child: Column(
            children: [
              SizedBox(height: 50,),

              Center(
                child: Text(
                  modelDetail.name,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Center(
                child: Text(
                  modelDetail.username,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: FlatButton(
                  padding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: Color(0xFFF0F0F0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateModelProfilePage(modelId: modelDetail.id)),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.supervised_user_circle_sharp,
                      ),
                      SizedBox(width: 30,),
                      Expanded(
                        child: Text(
                          'My account',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

