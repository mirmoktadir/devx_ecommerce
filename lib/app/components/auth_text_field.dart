import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/light_theme_colors.dart';
import '../modules/auth/controllers/auth_controller.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.textEditingController,
    required this.controller,
    required this.theme,
    required this.type,
  });

  final TextEditingController textEditingController;
  final AuthController controller;
  final ThemeData theme;
  final String type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: false,
      onSaved: (value) {
        textEditingController.text = value!;
      },
      validator: (value) {
        if (textEditingController.text.isEmpty) {
          return "$type is required!";
        }
        return type == "Email"
            ? controller.validateEmail(value!)
            : controller.validatePassword(value!);
      },
      keyboardType:
          type == "Email" ? TextInputType.emailAddress : TextInputType.text,
      textInputAction:
          type == "Email" ? TextInputAction.next : TextInputAction.done,
      cursorColor: LightThemeColors.primaryFontColor,
      decoration: InputDecoration(
        prefixIcon: Icon(
          type == "Email" ? Icons.mail_outline : Icons.key,
          color: theme.primaryColor,
        ),
        hintText: type == "Email" ? "Email Address" : "Password",
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            width: 1,
            color: theme.primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            width: 1,
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
