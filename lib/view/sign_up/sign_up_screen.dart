import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/constant/app_colors.dart';
import 'package:login_flutter_app/constant/routes.dart';
import 'package:login_flutter_app/controller/sign_up_controller.dart';
import 'package:login_flutter_app/helper/helper.dart';
import 'package:login_flutter_app/view/app_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());

  bool passwordVisible = true;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'MEMBERSHIP SIGN-UP',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                emptyVerticalBox(),
                AppTextField(
                  label: 'Name',
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your name';
                    }

                    return null;
                  },
                  controller: signUpController.nameController,
                ),
                emptyVerticalBox(height: 10),
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
                  controller: signUpController.emailController,
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
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your password';
                        } else if (val.length < 6) {
                          return 'Password must be at least 6 characters';
                        } else if (val.length > 20) {
                          return 'Password must be less than 20 characters';
                        }
                        return null;
                      },
                      controller: signUpController.passwordController,
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
                GetX<SignUpController>(
                  builder: (controller) {
                    return MaterialButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          await controller.signUp();
                        }
                      },
                      color: AppColors.primaryColor,
                      child: Center(
                        child: Text(
                          controller.isLoading.value ? 'Loading...' : 'Sign Up',
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
                _buildSignIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignIn() {
    return InkWell(
      onTap: () => Get.offAllNamed(AppRoutes.signInRoute),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Already Registered?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            TextSpan(
              text: ' Sign In',
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
