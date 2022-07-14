import 'package:cuteshrew/services/navigation_service.dart';
import 'package:cuteshrew/services/navigation_service_impl.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<NavigationService>(NavigationServiceImpl());
}
