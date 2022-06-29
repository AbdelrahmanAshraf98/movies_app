import 'package:flutter/cupertino.dart';
import 'package:movies_app/models/PopularPeopleResponseData.dart';
import 'package:movies_app/models/failure_model.dart';
import 'package:movies_app/repositories/people_repo.dart';
import 'package:get_it/get_it.dart';

class PeopleViewModel extends ChangeNotifier {
  PeopleRepository repo = GetIt.instance<PeopleRepository>();
  late PopularPeopleResponseData peopleData;
  late Failure failure;
  bool loading = false;

  Future<bool> getPopularPeople() async {
    loading = true;
    notifyListeners();
    var responseData = await repo.getPopularPeople();
    responseData.fold(
      (l) {
        failure = l;
      },
      (r) {
        peopleData = r;
      },
    );
    loading = false;
    notifyListeners();
    return true;
  }
}
