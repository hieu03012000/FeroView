import 'package:fero/screens/intro_image_page.dart';
import 'package:fero/services/image_service.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/image_list_view_model.dart';
import 'package:fero/viewmodels/model_image_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ImageInCollectionPage extends StatefulWidget {
  final int collectionId;
  const ImageInCollectionPage({Key key, this.collectionId}) : super(key: key);

  @override
  _ImageInCollectionPageState createState() => _ImageInCollectionPageState();
}

class _ImageInCollectionPageState extends State<ImageInCollectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: kBackgroundColor,
          ),
          backgroundColor: kTextColor,
          onPressed: () async => {
            await ImageService().uploadImage(widget.collectionId),
            _reloadPage()
          },
        ),
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
                    child: FutureBuilder<ImageListViewModel>(
                      future: Provider.of<ImageListViewModel>(context,
                              listen: false)
                          .getImageList(widget.collectionId),
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
                            return Consumer<ImageListViewModel>(
                              builder: (ctx, data, child) =>
                                  StaggeredGridView.countBuilder(
                                      crossAxisCount: 2,
                                      itemCount: data.images.length,
                                      itemBuilder: (context, index) {
                                        return _buildImageList(
                                            (context), data.images[index], index);
                                      },
                                      staggeredTileBuilder: (index) {
                                        return new StaggeredTile.count(
                                            1, index.isEven ? 1.2 : 2);
                                      }),
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

  Widget _buildImageList(BuildContext context, ModelImageViewModel image, int index) {
    bool isSelect = false;
    Future _showDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Do you want to delete",
                style: TextStyle(color: kPrimaryColor),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await ImageService().deleteImage(image.fileName, image.id);
                    Navigator.of(context).pop();
                    _reloadPage();
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                  ),
                ),
              ],
            );
          });
    }

    return GestureDetector(
        onLongPress: () => {
              _showDialog(context),
            },
        onTap: () {
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
                            return IntroImagePage(
                              beginIndex: index,
                              collectionId: widget.collectionId,
                            );
                          },
                        ))),
          );
        },
        child: (!isSelect)
            ? Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-2, 5),
                        blurRadius: 10,
                        color: kTextColor.withOpacity(0.3),
                      )
                    ],
                    color: kTextColor,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                          image.fileName,
                        ),
                        
                        fit: BoxFit.cover)),
              )
            : Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-2, 5),
                      blurRadius: 10,
                      color: kPrimaryColor.withOpacity(0.3),
                    )
                  ],
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ));
  }

  Future _reloadPage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => ImageListViewModel()),
                  ],
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return ImageInCollectionPage(
                        collectionId: widget.collectionId,
                      );
                    },
                  ))),
    );
  }
}
