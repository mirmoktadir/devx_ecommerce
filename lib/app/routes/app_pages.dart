import 'package:devx_ecommerce/app/modules/auth/views/register_view.dart';
import 'package:devx_ecommerce/app/modules/home/views/product_detail_view.dart';
import 'package:get/get.dart';

import '../components/navbar/bottom_navbar.dart';
import '../components/navbar/navbar_binding.dart';
import '../modules/Cart/bindings/cart_binding.dart';
import '../modules/Cart/views/cart_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_option_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const NAV = Routes.NAV;
  static const HOME = Routes.HOME;
  static const ONBOARDING = Routes.ONBOARDING;

  static final routes = [
    /// NAV BAR
    GetPage(
      name: _Paths.NAV,
      page: () => BottomNavbar(),
      binding: NavbarBinding(),
    ),

    ///
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),

    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),

    GetPage(
      name: _Paths.LOGIN_OPTION,
      page: () => const LoginOptionView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
      binding: HomeBinding(),
    ),
  ];
}
