import 'package:fero/constants.dart';
import 'package:fero/models/ModelDetail.dart';
import 'package:fero/models/ModelList.dart';
import 'package:fero/screens/ModelListPage.dart';
import 'package:flutter/material.dart';

class ModelDetailPage extends StatefulWidget {
  final String modelId;
  const ModelDetailPage({Key key, this.modelId}) : super(key: key);

  @override
  _ModelDetailPageState createState() => _ModelDetailPageState();
}


class _ModelDetailPageState extends State<ModelDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModelListPage()),
              );
            },
          ),
          title: Text('Model'),
          actions: [
            Icon(Icons.favorite),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ),
            Icon(Icons.more_vert),
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: getModelDetail(widget.modelId),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return  DetailModel(modelDetail: snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class DetailModel extends StatelessWidget {
  final ModelDetail modelDetail;
  const DetailModel({Key key, this.modelDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          Container(
            height: 200,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage (
                    "https://znews-photo.zadn.vn/w1920/Uploaded/ihvjohb/2019_12_08/52684425_762234710836343_8290759092989853696_o.jpg"
                ),
                fit: BoxFit.cover
              )
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              modelDetail.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              castAge(modelDetail.dateOfBirth),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          ),
          Container(
            width: 300,
            decoration:BoxDecoration(
            ),
              padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text(
                    'Gender: ' + castGender(modelDetail.gender),
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                    'Phone: ' + modelDetail.phone,
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                    'Address: ' + modelDetail.subAddress,
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                    'Gifted: ' + modelDetail.gifted,
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30, ),
          Padding(
            padding: EdgeInsets.all(10),
            child:
              ElevatedButton.icon(
                onPressed: () {
                  // Perform some action
                },
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    minimumSize: Size(180, 50)
                ),
                icon: Icon(Icons.add, size: 18),
                label: Text("ADD TO LIST"),
              ),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     // Perform some action
              //   },
              //   style: ElevatedButton.styleFrom(
              //       primary: Color(0xFFF54E5E),
              //       minimumSize: Size(180, 50)
              //   ),
              //   icon: Icon(Icons.favorite, size: 18),
              //   label: Text("FAVORITE"),
              // ),
          )
        ],
      )
    );
  }
}

