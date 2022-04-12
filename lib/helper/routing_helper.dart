import 'package:get/get.dart';
import 'package:login_flutter_app/constant/routes.dart';
import 'package:login_flutter_app/view/homepage/homepage_screen.dart';
import 'package:login_flutter_app/view/sign_in/sign_in_screen.dart';
import 'package:login_flutter_app/view/sign_up/sign_up_screen.dart';

class RoutingHelper {
  static final List<GetPage> getPages = [
    /// Homepage
    GetPage(
      name: AppRoutes.homePageRoute,
      page: () => const Homepage(),
    ),

    ///SignIn Route
    GetPage(
      name: AppRoutes.signInRoute,
      page: () => const SignInScreen(),
    ),

    ///SignUp Route
    GetPage(
      name: AppRoutes.signUpRoute,
      page: () => const SignUpScreen(),
    ),
  ];
}
