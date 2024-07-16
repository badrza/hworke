import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class BirdServiceImp {}

void init() {
  getIt.registerSingleton<BirdServiceImp>(BirdServiceImp());
}

BirdServiceImp getBirdService() {
  return getIt<BirdServiceImp>();
}
