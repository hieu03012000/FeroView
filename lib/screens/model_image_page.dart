import 'package:fero/models/image_collection.dart';
import 'package:fero/screens/image_in_collection_page.dart';
import 'package:fero/services/image_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/image_collection_list_view_model.dart';
import 'package:fero/viewmodels/image_collection_view_model.dart';
import 'package:fero/viewmodels/image_list_view_model.dart';
import 'package:fero/viewmodels/model_image_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ModelImagePage extends StatefulWidget {
  final String modelId;
  const ModelImagePage({Key key, this.modelId}) : super(key: key);

  @override
  _ModelImagePageState createState() => _ModelImagePageState();
}

class _ModelImagePageState extends State<ModelImagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   backgroundColor: kPrimaryColor,
        //   onPressed: () async => {
        //     await Provider.of<ImageCollectionListViewModel>(context, listen: false)
        //         .getImageCollectionList()
        //   },
        // ),
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Gallery',
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: FutureBuilder<ImageCollectionListViewModel>(
                      future: Provider.of<ImageCollectionListViewModel>(context,
                              listen: false)
                          .getImageCollectionList(),
                      builder: (context, data) {
                        if (data.connectionState == ConnectionState.waiting) {
                          return Column(
                            children: <Widget>[
                              SizedBox(
                                height: 150,
                              ),
                              Center(child: CircularProgressIndicator()),
                            ],
                          );
                        } else {
                          if (data.error == null) {
                            return Consumer<ImageCollectionListViewModel>(
                              builder: (ctx, data, child) => ListView.builder(
                                itemCount: data.imageCollections.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildImageCollectList(
                                      (context), data.imageCollections[index]);
                                },
                              ),
                            );
                          } else {
                            return Text('Error');
                          }
                        }
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCollectList(
      BuildContext context, ImageCollectionViewModel collection) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(-2, 5),
              blurRadius: 10,
              color: kPrimaryColor.withOpacity(0.5),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: kPrimaryColor,
            // width: 2,
          ),
        ),
        child: FlatButton(
          padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: kBackgroundColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                                create: (_) => ImageListViewModel()),
                          ],
                          child: FutureBuilder(
                            builder: (context, snapshot) {
                              return ImageInCollectionPage(
                                collectionId: collection.id,
                              );
                            },
                          ))),
            );
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  collection.name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Icon(
                Icons.navigate_next,
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
