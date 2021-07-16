import 'package:fero/models/casting.dart';
import 'package:fero/services/apply_casting_service.dart';
import 'package:fero/services/casting_service.dart';
import 'package:fero/utils/common.dart';
import 'package:fero/viewmodels/casting_view_model.dart';
import 'package:flutter/widgets.dart';

class CastingListViewModel with ChangeNotifier {
  List<CastingViewModel> castings = List<CastingViewModel>();

  void topHeadlines() async {
    List<Casting> list = [];
    list = await CastingService().searchCastingList('', '', '');
    notifyListeners();
    this.castings = list
        .where((item) =>
            parseDatetime(item.openTime).isBefore(DateTime.now()) &&
            parseDatetime(item.closeTime).isAfter(DateTime.now()))
        .map((casting) => CastingViewModel(casting: casting))
        .toList();
    this.castings.sort((a, b) => a.openDate.compareTo(b.openDate));
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
      this.castings =
          list.map((casting) => CastingViewModel(casting: casting)).toList();
      this.castings.sort((a, b) => a.openDate.compareTo(b.openDate));
    });
  }

  Future<CastingListViewModel> applyCasting(int castingId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Casting> list = await ApplyCastingService().createApplyCasting(castingId);
      notifyListeners();
      this.castings =
          list.map((casting) => CastingViewModel(casting: casting)).toList();
      this.castings.sort((a, b) => a.openDate.compareTo(b.openDate));
    });
  }

  Future<CastingListViewModel> cancelCasting(int castingId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Casting> list = await ApplyCastingService().deleteApplyCasting(castingId);
      notifyListeners();
      this.castings =
          list.map((casting) => CastingViewModel(casting: casting)).toList();
      this.castings.sort((a, b) => a.openDate.compareTo(b.openDate));
    });
  }
}
