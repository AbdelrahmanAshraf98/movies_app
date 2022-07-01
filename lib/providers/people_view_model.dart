import 'package:flutter/material.dart';
import 'package:movies_app/models/failure_model.dart';
import 'package:movies_app/repositories/people_repo.dart';
import 'package:get_it/get_it.dart';

import '../models/PopularPeopleDataResponse.dart';

class PeopleViewModel extends ChangeNotifier {
  PeopleRepository repo = GetIt.instance<PeopleRepository>();
  int page = 1;
  late int totalPage;
  List<People> peoples = [];
  Failure? failure;

  Future<bool> getPopularPeople({bool more = false}) async {
    var responseData = await repo.getPopularPeople(page: more ? page + 1 : 1);
    responseData.fold(
      (l) {
        failure = l;
        return false;
      },
      (r) {
        if (!more) {
          peoples = [];
        }
        page = r.page!;
        peoples.addAll(r.people!);
        totalPage = r.totalPages!;
      },
    );
    notifyListeners();
    return true;
  }
}
