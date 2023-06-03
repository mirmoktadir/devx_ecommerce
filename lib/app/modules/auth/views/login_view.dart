import 'package:devx_ecommerce/app/components/my_buttons.dart';
import 'package:devx_ecommerce/app/routes/app_pages.dart';
import 'package:devx_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/auth_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            reverse: true,
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.kSigninBg),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Let's Sign In",
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 270.w,
                    child: Text(
                      "Sign in now to access your exercises and saved music.",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  AuthTextField(
                      textEditingController: mailController,
                      controller: controller,
                      theme: theme,
                      type: "Email"),
                  const SizedBox(height: 25),
                  AuthTextField(
                      textEditingController: passwordController,
                      controller: controller,
                      theme: theme,
                      type: "Password"),
                  SizedBox(height: 50.h),
                  Center(
                    child: SizedBox(
                      width: 100.w * 2.5,
                      child: PrimaryButton(
                        onPressed: () async {
                          await controller.doLogin(
                              mailController.text, passwordController.text);
                        },
                        title: 'LOGIN',
                      ),
                    ),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
