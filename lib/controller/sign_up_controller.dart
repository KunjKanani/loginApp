import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/constant/routes.dart';
import 'package:login_flutter_app/service/api_service.dart';

class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;

  Future signUp() async {
    if (!isLoading.value) {
      isLoading.value = true;
      String result = await ApiService.to.signUpUser({
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });
      log('RES: $result');

      if (result == 'success') {
        Get.snackbar(
          'Thank you for registering!',
          result,
          duration: const Duration(milliseconds: 1500),
        );
        await Future.delayed(const Duration(milliseconds: 1500), () {});
        Get.offNamed(AppRoutes.signInRoute);
      } else {
        Get.snackbar('ERROR!', result);
      }
      isLoading.value = false;
    }
  }
}
