import 'package:devx_ecommerce/app/service/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../model/on_boarding_model.dart';

class OnboardingController extends GetxController with BaseController {
  var selectedPage = 0.obs;
  var pageController = PageController();
  forwardAction() =>
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  backwardAction() => pageController.previousPage(
      duration: 300.milliseconds, curve: Curves.ease);

  List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(
        imageAsset: AppImages.kBoard1,
        title: 'Find best product in good price',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed.'),
    OnBoardingModel(
        imageAsset: AppImages.kBoard2,
        title: 'Fast buy your product in just one click ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed.'),
    OnBoardingModel(
        imageAsset: AppImages.kBoard3,
        title: 'Find perfect choice for your personality ',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed.'),
  ];
}
