import 'package:get_it/get_it.dart';
import 'package:movies_app/services/network_service.dart';

import '../repositories/people_repo.dart';

class DependencyInjection {
  final getIt = GetIt.instance;

  void setup() {
    getIt.registerSingleton<NetworkService>(NetworkService());
    getIt.registerLazySingleton<PeopleRepository>(() => PeopleRepository());
  }
}
