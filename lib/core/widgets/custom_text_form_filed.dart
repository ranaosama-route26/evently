import 'package:event_app_c17_mon_7pm/modules/app_settings_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

import '/core/gen/assets.gen.dart';
import '/core/theme/color_pallete.dart';

class CustomTextFormFiled extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool isPassword;
  final int? maxLines;

  const CustomTextFormFiled({
    super.key,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.maxLines = 1,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var provider = Provider.of<AppSettingsProvider>(context);
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      cursorColor: ColorPallete.borderColor,
      validator: widget.validator,
      obscureText: widget.isPassword ? _isPasswordVisible : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: provider.isDark() ? Color(0xFF001440) : Colors.white,
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: provider.isDark() ? Color(0xFFD6D6D6) : Color(0xFF686868),
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color:
                provider.isDark()
                    ? Color(0xFF002D8F)
                    : ColorPallete.borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color:
                provider.isDark()
                    ? Color(0xFF002D8F)
                    : ColorPallete.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color:
                provider.isDark()
                    ? Color(0xFF002D8F)
                    : ColorPallete.borderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorPallete.errorBorderColor),
        ),
        prefixIcon:
            widget.prefixIcon == null
                ? null
                : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: widget.prefixIcon,
                ),
        suffixIcon:
            widget.isPassword
                ? Bounceable(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color:
                        provider.isDark()
                            ? Colors.white
                            : ColorPallete.borderColor,
                  ),
                )
                : widget.suffixIcon,
      ),
    );
  }
}
