import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:devx_ecommerce/app/components/soft_button.dart';
import 'package:devx_ecommerce/app/modules/auth/views/login_option_view.dart';
import 'package:devx_ecommerce/utils/constants.dart';

import '../../../components/my_buttons.dart';
import '../../auth/bindings/auth_binding.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SizedBox(height: 80.w),
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.selectedPage,
              itemCount: controller.onBoardingPages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 135.w),
                    textContainer(index, theme),
                    SizedBox(height: 25.w),
                    imageContainer(index),
                  ],
                );
              },
            ),
            buttonContainer(context, theme),
            skipContainer(theme),
          ],
        ),
      ),
    );
  }

  Positioned skipContainer(ThemeData theme) {
    return Positioned(
      top: 30.h,
      left: -20.w,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.kAppIcon),
                ),
              ),
            ),
            SizedBox(
              width: 86.w,
              child: SoftButton(
                  title: 'skip',
                  onPressed: () {
                    Get.off(() => const LoginOptionView(),
                        binding: AuthBinding());
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Padding textContainer(int index, ThemeData theme) {
    return Padding(
      padding: DefaultPadding.kHorizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w * 3,
            child: Text(
              controller.onBoardingPages[index].title,
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w400,
                height: 1.6.sp,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 15.w),
          Text(
            controller.onBoardingPages[index].description,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: theme.hintColor,
              height: 1.4.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Expanded imageContainer(int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              controller.onBoardingPages[index].imageAsset,
            ),
            fit: BoxFit.cover,
          ),
          color: Colors.red,
          borderRadius: BorderRadius.circular(40.r),
        ),
      ),
    );
  }

  Positioned buttonContainer(BuildContext context, ThemeData theme) {
    return Positioned(
      bottom: 50.h,
      left: 40.w,
      right: 40.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.onBoardingPages.length,
              (index) => Obx(
                () {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    height: 4.w,
                    width: 15.w,
                    decoration: BoxDecoration(
                      color: controller.selectedPage.value == index
                          ? Colors.white
                          : theme.hintColor,
                      borderRadius: BorderRadius.circular(30),
                      shape: BoxShape.rectangle,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: 100.w * 2,
            child: PrimaryButton(
              title: 'Next',
              onPressed: () {
                if (controller.selectedPage > 1) {
                  Get.off(() => const LoginOptionView(),
                      binding: AuthBinding());
                  (context as Element).markNeedsBuild();
                } else {
                  controller.forwardAction();
                  (context as Element).markNeedsBuild();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
