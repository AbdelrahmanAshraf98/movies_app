import 'package:flutter/material.dart';
import 'package:movies_app/models/failure_model.dart';
import 'package:movies_app/repositories/people_repo.dart';
import 'package:get_it/get_it.dart';

import '../models/PopularPeopleDataResponse.dart';

class PeopleViewModel extends ChangeNotifier {
  PeopleRepository repo = GetIt.instance<PeopleRepository>();
  int page = 1;
  late int totalPage ;
  List<People> peoples = [];
  Failure failure = Failure('Error', 555);

  Future<bool> getPopularPeople() async {
    var responseData = await repo.getPopularPeople(page: page);
    responseData.fold(
      (l) {
        failure = l;
      },
      (r) {
        page = r.page!;
        peoples.addAll(r.people!);
        totalPage = r.totalPages!;
      },
    );
    notifyListeners();
    return true;
  }

}
