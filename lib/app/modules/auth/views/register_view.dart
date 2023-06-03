import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/auth_text_field.dart';
import '../../../components/my_buttons.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  RegisterView({Key? key}) : super(key: key);
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            reverse: true,
            child: Form(
              key: controller.registerFormKey,
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
                    "Create your account",
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
                          await controller.doRegister(
                              mailController.text.trim(),
                              passwordController.text.trim());
                        },
                        title: 'Register',
                      ),
                    ),
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
