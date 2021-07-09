import 'package:fero/models/casting.dart';
import 'package:fero/services/casting_service.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:flutter/widgets.dart';

class CastingListViewModel with ChangeNotifier {
  List<CastingViewModel> castings = List<CastingViewModel>();

  void topHeadlines() async {
    List<Casting> list = [];
    list = await CastingService().searchCastingList('', '', '');
    notifyListeners();
    this.castings =
        list.map((casting) => CastingViewModel(casting: casting)).toList();
  }

  Future<CastingListViewModel> searchCastingList(
      String name, String min, String max) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Casting> list =
          await CastingService().searchCastingList(name, min, max);
      notifyListeners();
      this.castings =
          list.map((casting) => CastingViewModel(casting: casting)).toList();
    });
  }

  Future<CastingListViewModel> modelApplyCasting() async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Casting> list = await CastingService().modelApplyCasting();
      notifyListeners();
      this.castings =
          list.map((casting) => CastingViewModel(casting: casting)).toList();
    });
  }

  Future<CastingListViewModel> castingByIds(List<int> castings) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Casting> list = await CastingService().getCastingByIds(castings);
      notifyListeners();
      this.castings =
          list.map((casting) => CastingViewModel(casting: casting)).toList();
    });
  }

  
  Future<CastingListViewModel> imcomingCasting() async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Casting> list = await CastingService().getIncomingCasting();
      notifyListeners();
      this.castings = list.map((casting) => CastingViewModel(casting: casting)).toList();
    });
  }
}
