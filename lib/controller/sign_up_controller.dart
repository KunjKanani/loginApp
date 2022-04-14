import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
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

      var bytes = utf8.encode(passwordController.text); // data being hashed

      var digest = sha1.convert(bytes);

      // String result = "";
      String result = await ApiService.to.signUpUser({
        'name': nameController.text,
        'email': emailController.text,
        'password': digest.toString(),
      });
      // log('RES: $result');

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
