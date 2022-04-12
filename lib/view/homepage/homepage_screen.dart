import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_flutter_app/constant/app_colors.dart';
import 'package:login_flutter_app/constant/routes.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'You are registered successfully.',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MaterialButton(
              onPressed: () async {
                GetStorage storage = GetStorage();
                await storage.write('email', '');
                Get.offAllNamed(AppRoutes.signInRoute);
              },
              child: const Text(
                'LOGOUT',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
