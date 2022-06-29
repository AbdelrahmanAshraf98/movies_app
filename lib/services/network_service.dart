import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movies_app/common/api_constants.dart';
class NetworkService{

  Future<http.Response> get(baseUrl,header){
    baseUrl += '?api_key=${ApiConstants.API_KEY}&language=en-US';
    log(baseUrl);
    return http.get(Uri.parse(baseUrl),headers: header);
  }

}