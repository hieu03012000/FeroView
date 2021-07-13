import 'package:fero/models/model.dart';
import 'package:fero/services/model_service.dart';
import 'package:fero/viewmodels/model_view_model.dart';
import 'package:flutter/widgets.dart';

class ModelListViewModel with ChangeNotifier {
  List<ModelViewModel> models = List<ModelViewModel>();

  void topHeadlines() async {
    List<Model> list = await ModelService().getModelList();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();

    this.models = list.map((model) => ModelViewModel(model: model)).toList();
  }
}
