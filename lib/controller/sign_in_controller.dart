import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_flutter_app/constant/routes.dart';
import 'package:login_flutter_app/service/api_service.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;

  Future signIn() async {
    if (!isLoading.value) {
      isLoading.value = true;
      String result = await ApiService.to.signInUser({
        'email': emailController.text,
        'password': passwordController.text,
      });

      if (result == 'success') {
        GetStorage box = GetStorage();
        Get.snackbar(
          'Welcome User!',
          result,
          duration: const Duration(milliseconds: 1500),
        );
        await box.write('email', emailController.text);
        await Future.delayed(const Duration(milliseconds: 1500), () {});
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.homePageRoute);
      } else {
        isLoading.value = false;
        Get.snackbar('ERROR!', result);
      }
    }
  }
}
