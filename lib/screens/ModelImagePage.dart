import 'package:fero/components/bottom_navigator.dart';
import 'package:fero/utils/constants.dart';
import 'package:fero/viewmodels/image_list_view_model.dart';
import 'package:fero/viewmodels/model_image_view_model.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: kSecondaryColor,
      body: ListView.builder(
        itemCount: listImage.images.length,
        itemBuilder: (context, index) {
          return _buildImageList(context, listImage.images[index]);
        },
      ),
      bottomNavigationBar: buildNavigationBar(context, 3),
    );
  }

  Widget _buildImageList(BuildContext context, ModelImageViewModel image) {
    return GestureDetector(
      onLongPress: () => {},
      child: Image.network(
        image.fileName
      ),
    );
  }
}


