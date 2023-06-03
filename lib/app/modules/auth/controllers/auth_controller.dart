import 'package:devx_ecommerce/app/service/base_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_snackbar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController with BaseController {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  /// REGISTER
  doRegister(String email, String password) async {
    bool isValidate = registerFormKey.currentState!.validate();
    isValidate ? showLoading() : hideLoading();
    try {
      if (isValidate) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        var authCredential = userCredential.user;
        if (authCredential!.uid.isNotEmpty) {
          registerFormKey.currentState!.save();

          hideLoading();

          MySharedPref.setUID(authCredential.uid);
          MySharedPref.setEmail(authCredential.email.toString());
          Get.back();
          CustomSnackBar.showCustomSnackBar(
              title: "Registration successfull", message: "Please Login now");
        }
      }
    } on FirebaseException catch (e) {
      hideLoading();
      if (e.code == "user-not-found") {
        CustomSnackBar.showCustomErrorSnackBar(
            title: "Error", message: "No user found");
      } else if (e.code == "wrong-password") {
        CustomSnackBar.showCustomErrorSnackBar(
            title: "Error", message: "Wrong password");
      }
    } catch (e) {
      hideLoading();
      handleError(e);
    }
  }

  /// LOGIN
  doLogin(String email, String password) async {
    bool isValidate = loginFormKey.currentState!.validate();
    isValidate ? showLoading() : hideLoading();
    try {
      if (isValidate) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.trim(), password: password);

        var authCredential = userCredential.user;

        if (authCredential!.uid.isNotEmpty) {
          loginFormKey.currentState!.save();

          hideLoading();

          MySharedPref.setUID(authCredential.uid);
          MySharedPref.setEmail(authCredential.email.toString());
          Get.offAllNamed(AppPages.NAV);
        }
      }
    } on FirebaseException catch (e) {
      hideLoading();
      if (e.code == "user-not-found") {
        CustomSnackBar.showCustomErrorSnackBar(
            title: "Error", message: "No user found");
      } else if (e.code == "wrong-password") {
        CustomSnackBar.showCustomErrorSnackBar(
            title: "Error", message: "Wrong password");
      }
    } catch (e) {
      hideLoading();
      handleError(e);
    }
  }

  /// Logout
  doLogout() async {
    await MySharedPref.removeUID();
    Get.offAllNamed(Routes.LOGIN);
  }

  /// Validator

  String? validateEmail(String email) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }
    return null;
  }
}
