import 'package:event_app_c17_mon_7pm/core/theme/color_pallete.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? buttonText;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? customChild;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    super.key,
    this.onPressed,
    this.buttonText,
    this.borderColor,
    this.backgroundColor,
    this.customChild,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: backgroundColor ?? theme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 9),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: borderColor ?? ColorPallete.primaryColor,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child:
                customChild ??
                Text(
                  buttonText ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
