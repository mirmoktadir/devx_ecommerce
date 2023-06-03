import 'package:devx_ecommerce/app/components/my_buttons.dart';
import 'package:devx_ecommerce/app/routes/app_pages.dart';
import 'package:devx_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/auth_controller.dart';

class LoginOptionView extends GetView<AuthController> {
  const LoginOptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: DefaultPadding.kHorizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            SizedBox(
              width: double.infinity,
              height: 300.h,
              child: Lottie.asset(
                'animations/ecommerce.json',
                height: 140.h,
                repeat: true,
                reverse: true,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 60.h),
            Text(
              "Ready to explore?",
              style: theme.textTheme.headlineMedium,
            ),
            SizedBox(height: 40.h),
            Center(
              child: SizedBox(
                  width: 100.w * 2.5,
                  child: PrimaryButtonWithIcon(
                    title: "Continue with Email",
                    onPressed: () => Get.offNamed(Routes.LOGIN),
                    iconData: Icons.email_outlined,
                  )),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () => {Get.toNamed((Routes.REGISTER))},
                    child: Text(
                      'Register',
                      style: theme.textTheme.bodyLarge,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
