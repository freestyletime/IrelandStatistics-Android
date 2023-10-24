import 'package:get_it/get_it.dart';
import 'package:irelandstatistics/Services.dart';

GetIt locator = GetIt.I;

void initLocator() {
  locator.registerLazySingleton(() => Services());
}