
import 'dart:io';

class ApiConstants{
  static const String API_KEY='41ddedb44b521fc7a061dc3e45facf2f';
  static const String BASE_URL='https://api.themoviedb.org/3';
  static const String PERSON_PREFIX='/person';
  static const String POPULAR_PREFIX='/popular';

  static Map<String, String> headers= {
    HttpHeaders.authorizationHeader: 'Bearer $API_KEY',
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json'
  };
}