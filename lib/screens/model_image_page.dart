import 'package:fero/services/image_service.dart';
import 'package:fero/utils/constants.dart';
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
    Provider.of<ImageListViewModel>(context, listen: false)
        .topHeadlines(widget.modelId);
  }

  @override
  Widget build(BuildContext context) {
    var listImage = Provider.of<ImageListViewModel>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
        onPressed: () =>
            {ImageService().uploadImage(widget.modelId), _reloadPage()},
      ),
      appBar: null,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Gallery',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: listImage.images.length,
                    itemBuilder: (context, index) {
                      return _buildImageList(
                          (context), listImage.images[index]);
                    },
                    staggeredTileBuilder: (index) {
                      return new StaggeredTile.count(1, index.isEven ? 1.2 : 2);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageList(BuildContext context, ModelImageViewModel image) {
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
              content: SingleChildScrollView(
                  child: ButtonBar(
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                  FlatButton(
                    onPressed: () {
                      ImageService().deleteImage(
                          image.fileName, image.id, widget.modelId);
                      _reloadPage();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              )),
            );
          });
    }

    return GestureDetector(
        onLongPress: () => {
              _showDialog(context),
              setState(() {
                isSelect = !isSelect;
              })
            },
        child: (!isSelect)
            ? Container(
                margin: EdgeInsets.only(top: 30, left: 15, right: 15),
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
                    image: DecorationImage(
                        image: NetworkImage(
                          image.fileName,
                        ),
                        fit: BoxFit.cover)),
              )
            : Container(
                margin: EdgeInsets.only(top: 30, left: 15, right: 15),
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
                  // image: DecorationImage(
                  //   image: NetworkImage(image.fileName,),
                  //       fit: BoxFit.cover
                  // )
                ),
              ));
  }

  void _reloadPage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ImageListViewModel()),
          ],
          child: ModelImagePage(
            modelId: widget.modelId,
          ));
    }));
  }
}
