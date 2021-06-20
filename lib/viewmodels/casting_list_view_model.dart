import 'package:fero/models/casting.dart';
import 'package:fero/services/casting_service.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:flutter/widgets.dart';

class CastingListViewModel with ChangeNotifier {
  List<CastingViewModel> castings = List<CastingViewModel>();

  void topHeadlines() async {
    List<Casting> list = await CastingService().getCastingList();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();

    this.castings =
        list.map((casting) => CastingViewModel(casting: casting)).toList();
  }
}
