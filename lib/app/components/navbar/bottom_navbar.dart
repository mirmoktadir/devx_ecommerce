import 'package:devx_ecommerce/app/modules/home/views/home_view.dart';
import 'package:devx_ecommerce/config/theme/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';

import '../../modules/Cart/views/cart_view.dart';

class BottomNavbar extends StatelessWidget {
  BottomNavbar({Key? key}) : super(key: key);

  List navigation = [
    HomeView(),
    const CartView(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    void _onTap(int index) {
      _selectedIndex = index;

      (context as Element).markNeedsBuild();
    }

    return Scaffold(
      body: navigation[_selectedIndex],
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.h,
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: theme.colorScheme.secondary.withOpacity(1),
                spreadRadius: 0,
                blurRadius: 20),
          ],
        ),

        // padding: const EdgeInsets.only(bottom: 18),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _onTap(0);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedIndex == 0
                              ? theme.primaryColor
                              : Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            _selectedIndex == 0
                                ? IconlyBold.home
                                : IconlyLight.home,
                            color: _selectedIndex == 0
                                ? Colors.white
                                : theme.primaryColor.withOpacity(1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: _selectedIndex == 0
                                ? theme.primaryColor
                                : theme.primaryColor.withOpacity(1),
                            fontSize: MyFonts.body2TextSize),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 40.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        splashFactory: NoSplash.splashFactory,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        _onTap(1);
                      },
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedIndex == 1
                              ? theme.primaryColor
                              : Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            Iconsax.shopping_cart,
                            size: 20,
                            color: _selectedIndex == 1
                                ? Colors.white
                                : theme.primaryColor.withOpacity(1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Cart",
                    style: TextStyle(
                        color: _selectedIndex == 1
                            ? theme.primaryColor
                            : theme.primaryColor.withOpacity(1),
                        fontSize: MyFonts.body2TextSize),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
