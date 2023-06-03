import 'package:cached_network_image/cached_network_image.dart';
import 'package:devx_ecommerce/app/components/my_buttons.dart';
import 'package:devx_ecommerce/app/modules/home/controllers/home_controller.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../utils/constants.dart';

class ProductDetailView extends GetView<HomeController> {
  const ProductDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              IconlyLight.arrow_left_2,
              size: 30,
              color: theme.primaryColor,
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 280.h,
              // width: double.infinity,
              color: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: Get.arguments[0],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: DefaultPadding.kHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(Get.arguments[1], style: theme.textTheme.headlineSmall),
                  SizedBox(height: 20.h),
                  Text("\$ ${Get.arguments[2]}",
                      style: theme.textTheme.headlineSmall),
                  SizedBox(height: 20.h),
                  Text("About", style: theme.textTheme.headlineSmall),
                  SizedBox(height: 10.h),
                  ExpandableText(
                    Get.arguments[3],
                    style: theme.textTheme.bodyLarge,
                    expandText: "show more",
                    collapseText: "show less",
                    linkColor: theme.primaryColor,
                    animation: true,
                    collapseOnTextTap: true,
                    textAlign: TextAlign.start,
                    maxLines: 4,
                  ),
                  SizedBox(height: 35.h),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButtonWithIcon(
                      title: ("Add to cart"),
                      onPressed: () async {
                        await controller.addToCart(
                          Get.arguments[1],
                          int.parse(Get.arguments[2]),
                          Get.arguments[0],
                        );
                      },
                      iconData: Icons.shopping_cart,
                    ),
                  ),
                  SizedBox(height: 60.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
