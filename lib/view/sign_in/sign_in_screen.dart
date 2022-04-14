import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/constant/app_colors.dart';
import 'package:login_flutter_app/constant/routes.dart';
import 'package:login_flutter_app/controller/sign_in_controller.dart';
import 'package:login_flutter_app/helper/helper.dart';
import 'package:login_flutter_app/view/app_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());

  final _key = GlobalKey<FormState>();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            // const TopCustomDesign(),
            Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'MEMBERSHIP SIGN-IN',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    emptyVerticalBox(),
                    AppTextField(
                      label: 'Email',
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter your email';
                        } else if (!EmailValidator.validate(val)) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                      controller: signInController.emailController,
                    ),
                    emptyVerticalBox(height: 10),
                    Card(
                      elevation: 0.0,
                      color: Colors.grey.shade100,
                      child: ListTile(
                        title: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            } else {
                              return null;
                            }
                          },
                          controller: signInController.passwordController,
                          obscureText: passwordVisible,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    emptyVerticalBox(),
                    GetX<SignInController>(
                      init: SignInController(),
                      builder: (controller) {
                        return MaterialButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              await controller.signIn();
                            }
                          },
                          color: AppColors.primaryColor,
                          child: Center(
                            child: Text(
                              controller.isLoading.value
                                  ? 'Loading...'
                                  : 'SIGN IN',
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    emptyVerticalBox(),
                    _buildSignUp(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUp() {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.signUpRoute),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Not Registered?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            TextSpan(
              text: ' Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
