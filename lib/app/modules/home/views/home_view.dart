import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:devx_ecommerce/app/components/empty_widget.dart';
import 'package:devx_ecommerce/app/modules/home/bindings/home_binding.dart';
import 'package:devx_ecommerce/app/modules/home/views/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/theme/my_fonts.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  final TextEditingController searchController = TextEditingController();
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'All Products',
            style: TextStyle(color: theme.primaryColor),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  await authController.doLogout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ))
          ],
          backgroundColor: Colors.transparent,
        ),
        body: Obx(() => controller.isError.value == true
            ? EmptyWidget(
                onPressed: () async => await controller.fetchProducts())
            : Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _carouselSlider(context, theme),
                      _itemList(theme, () {}),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              )),
      ),
    );
  }

  Widget _carouselSlider(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: controller.imgList.length,
          carouselController: _controller,
          itemBuilder: (context, index, __) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(controller.imgList[index].toString()),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              controller.current = index;
              (context as Element).markNeedsBuild();
            },
            height: 168.h,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(seconds: 3),
            autoPlayCurve: Curves.easeInOutBack,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            initialPage: 2,
            pageSnapping: true,
            viewportFraction: .9,
            enlargeFactor: .3,
            autoPlayInterval: const Duration(
              seconds: 4,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 6.0,
                height: 6.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : theme.primaryColor)
                        .withOpacity(
                            controller.current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _itemList(ThemeData theme, VoidCallback function) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All products",
          style: TextStyle(
            fontSize: MyFonts.headline6TextSize,
            color: theme.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        GridView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                Get.to(() => const ProductDetailView(),
                    binding: HomeBinding(),
                    arguments: [
                      controller.products[index]["image"].toString(),
                      controller.products[index]["title"].toString(),
                      controller.products[index]["price"].toString(),
                      controller.products[index]["description"].toString(),
                    ]);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 165.h,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          width: 1,
                          color: theme.primaryColor.withOpacity(.3),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: controller.products[index]["image"],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const SizedBox(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120.w,
                            child: Text(
                              controller.products[index]["title"],
                              style: theme.textTheme.headlineSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "\$ ${controller.products[index]["price"]}",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 15,
            childAspectRatio: 1 / 1.3,
          ),
        ),
      ],
    );
  }
}
