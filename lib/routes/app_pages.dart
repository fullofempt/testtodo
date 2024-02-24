import 'package:get/get.dart';
import 'package:testtodo/screens/home_bindings.dart';

import '../screens/home.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => Home(),
      binding: HomeBinding(),
    ),
  ];
}
