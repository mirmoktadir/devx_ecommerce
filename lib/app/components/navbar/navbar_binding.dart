import 'package:devx_ecommerce/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../modules/Cart/controllers/cart_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<CartController>(
      () => CartController(),
    );
  }
}
