import 'package:event_app_c17_mon_7pm/core/gen/assets.gen.dart';
import 'package:event_app_c17_mon_7pm/core/routes/pages_route_name.dart';
import 'package:event_app_c17_mon_7pm/core/theme/color_pallete.dart';
import 'package:event_app_c17_mon_7pm/core/widgets/custom_elevated_button.dart';
import 'package:event_app_c17_mon_7pm/modules/app_settings_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Assets.images.eventlyLogo.image(
          width: 150,
          height: 30,
          color: theme.primaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Assets.images.onBoardingImg.image(
              color:
                  appSettingsProvider.isDark()
                      ? Colors.white
                      : theme.primaryColor,
            ),
            SizedBox(height: 24),
            Text(
              "Personalize Your Experience",
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
              "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text("Language", style: theme.textTheme.titleMedium),
                Spacer(),
                Bounceable(
                  onTap: () {
                    appSettingsProvider.changeLanguage("en");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5.5,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "English",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Bounceable(
                  onTap: () {
                    appSettingsProvider.changeLanguage("ar");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5.5,
                    ),
                    decoration: BoxDecoration(
                      color:
                          appSettingsProvider.currentLanguage == "ar"
                              ? theme.primaryColor
                              : Color(0xFF001440),
                      border: Border.all(
                        color:
                            appSettingsProvider.currentLanguage == "ar"
                                ? Colors.transparent
                                : theme.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Arabic",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            appSettingsProvider.currentLanguage == "ar"
                                ? ColorPallete.primaryColor
                                : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("Theme", style: theme.textTheme.titleMedium),
                Spacer(),
                Bounceable(
                  onTap: () {
                    appSettingsProvider.changeTheme(ThemeMode.light);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5.5,
                    ),
                    decoration: BoxDecoration(
                      color:
                          appSettingsProvider.isDark()
                              ? Color(0xFF001440)
                              : theme.primaryColor,
                      border: Border.all(
                        color:
                            appSettingsProvider.isDark()
                                ? Color(0xFF002D8F)
                                : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Assets.icons.sunIcn.svg(),
                  ),
                ),
                SizedBox(width: 8),
                Bounceable(
                  onTap: () {
                    appSettingsProvider.changeTheme(ThemeMode.dark);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5.5,
                    ),
                    decoration: BoxDecoration(
                      color:
                          appSettingsProvider.isDark()
                              ? theme.primaryColor
                              : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Assets.icons.moonIcn.svg(),
                  ),
                ),
              ],
            ),
            Spacer(),
            CustomElevatedButton(
              buttonText: "Let's Start",
              onPressed: () {
                print("Hi");
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  PagesRouteName.signIn,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
