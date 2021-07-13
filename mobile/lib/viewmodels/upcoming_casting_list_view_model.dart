import 'package:fero/models/casting.dart';
import 'package:fero/services/casting_service.dart';
import 'package:fero/utils/common.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:flutter/widgets.dart';

class UpcomingCastingListViewModel with ChangeNotifier {
  List<CastingViewModel> castings = List<CastingViewModel>();

  void topHeadlines() async {
    List<Casting> list = [];
    list = await CastingService().searchCastingList('', '', '');
    notifyListeners();
    this.castings = list
        .where((item) => parseDatetime(item.openTime).isAfter(DateTime.now()))
        .map((casting) => CastingViewModel(casting: casting))
        .toList();
    this.castings.sort((a, b) => a.openDate.compareTo(b.openDate));
  }
}
