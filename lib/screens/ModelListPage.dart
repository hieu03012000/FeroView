import 'package:fero/models/ModelList.dart';
import 'package:fero/screens/ModelDetailPage.dart';
import 'package:flutter/material.dart';

class ModelListPage extends StatefulWidget {
  const ModelListPage({Key key}) : super(key: key);

  @override
  _ModelListPageState createState() => _ModelListPageState();
}

class _ModelListPageState extends State<ModelListPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: getModelList(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return  ListModel(list: snapshot.data);
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

class ListModel extends StatelessWidget {
  final List<ModelList> list;
  const ListModel({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModelDetailPage(modelId: list[index].id)),
              );
            },
            child: Container(
              child: Column(
                children: [
                Card(
                  margin: EdgeInsets.all(12),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Image.asset(list[index].avatar),
                      Image.network(
                        "https://znews-photo.zadn.vn/w1920/Uploaded/ihvjohb/2019_12_08/52684425_762234710836343_8290759092989853696_o.jpg",
                        width: 400.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      ListTile(
                        title: Text( '   ' +
                          list[index].name,
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('          ' + castGender(list[index].gender),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 15
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('          ' + castAge(list[index].dateOfBirth),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 15
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('          ' + list[index].gifted,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 15
                          ),
                        ),
                      ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: list[index].modelStyle.length,
                          itemBuilder: (context, int) {
                            return GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 30.0),
                                child: Text(
                                    list[index].modelStyle[int].styleName
                                ),
                              ),
                            );
                          }),
                      Padding(
                          padding: EdgeInsets.all(10.0)
                      )
                    ],
                  ),
                ),]
              ),
            ),
          );
        }
    );
  }
}



