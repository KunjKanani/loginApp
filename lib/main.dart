import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_flutter_app/constant/routes.dart';
import 'package:login_flutter_app/helper/routing_helper.dart';
import 'package:login_flutter_app/service/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  String? email = box.read('email');

  runApp(
    MyApp(
      email: email,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.email}) : super(key: key);
  final String? email;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: email == null || email!.isEmpty
          ? AppRoutes.signInRoute
          : AppRoutes.homePageRoute,
      getPages: RoutingHelper.getPages,
      initialBinding: BindingsBuilder(
        () {
          Get.put(ApiService());
        },
      ),
    );
  }
}
