import 'dart:developer';

import 'package:movies_app/common/api_constants.dart';
import 'package:movies_app/services/network_service.dart';
import 'package:get_it/get_it.dart';

class PeopleRepository {
  NetworkService networkService = GetIt.instance<NetworkService>();

  Future<List<Object>> getPopularPeople() async {
    String url = ApiConstants.BASE_URL +
        ApiConstants.PERSON_PREFIX +
        ApiConstants.POPULAR_PREFIX;
    var response = await networkService.get(url, ApiConstants.headers);
    log(response.statusCode.toString());
    log(response.body.toString());
    return [];
  }
}
