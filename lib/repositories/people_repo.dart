import 'dart:convert';
import 'dart:developer';

import 'package:movies_app/common/api_constants.dart';
import 'package:movies_app/services/network_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';

import '../models/PopularPeopleResponseData.dart';
import '../models/failure_model.dart';

class PeopleRepository {
  NetworkService networkService = GetIt.instance<NetworkService>();

  Future<Either<Failure,PopularPeopleResponseData>> getPopularPeople({int page = 1}) async {
    String url = ApiConstants.BASE_URL +
        ApiConstants.PERSON_PREFIX +
        ApiConstants.POPULAR_PREFIX+
        '?api_key=${ApiConstants.API_KEY}&language=en-US&page=$page';
    var response = await networkService.get(url, ApiConstants.headers);
    var decodedData = jsonDecode(response.body);
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      return Right(PopularPeopleResponseData.fromJson(decodedData));
    }
    return Left(Failure(decodedData['errors'],response.statusCode
    ));
  }
}
