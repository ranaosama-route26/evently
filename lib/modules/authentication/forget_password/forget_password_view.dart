import 'package:event_app_c17_mon_7pm/core/gen/assets.gen.dart';
import 'package:event_app_c17_mon_7pm/core/l10n/app_localizations.dart';
import 'package:event_app_c17_mon_7pm/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

/// 1- localization
/// 2- theme mode
/// 3- provider [state management]
///

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(appLocalization.forgetPassword)),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24,
          children: [
            Assets.images.forgetPasswordImg.image(color: theme.primaryColor),
            CustomElevatedButton(
              buttonText: appLocalization.resetPassword,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
