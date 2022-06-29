import 'package:get_it/get_it.dart';
import 'package:movies_app/services/network_service.dart';

class DependencyInjection{
  final getIt = GetIt.instance;

  void setup() {
    getIt.registerSingleton<NetworkService>(NetworkService());

  }
}