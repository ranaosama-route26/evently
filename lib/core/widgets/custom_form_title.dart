import 'package:flutter/material.dart';

import 'custom_text_form_filed.dart';

class CustomFormTitle extends StatelessWidget {
  const CustomFormTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          "Title",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomTextFormFiled(hintText: "Enter Event Title"),
      ],
    );
  }
}
