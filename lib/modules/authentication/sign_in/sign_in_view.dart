import 'package:event_app_c17_mon_7pm/core/gen/assets.gen.dart';
import 'package:event_app_c17_mon_7pm/core/l10n/app_localizations.dart';
import 'package:event_app_c17_mon_7pm/core/routes/pages_route_name.dart';
import 'package:event_app_c17_mon_7pm/core/theme/color_pallete.dart';
import 'package:event_app_c17_mon_7pm/core/utils/firebase_auth_utils.dart';
import 'package:event_app_c17_mon_7pm/core/widgets/custom_elevated_button.dart';
import 'package:event_app_c17_mon_7pm/core/widgets/custom_text_form_filed.dart';
import 'package:event_app_c17_mon_7pm/modules/app_settings_provider/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);

    final theme = Theme.of(context);
    var provider = Provider.of<AppSettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Assets.images.eventlyLogo.image(
          width: 150,
          height: 30,
          color: theme.primaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text(
                "Login to your account",
                textAlign: TextAlign.start,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 24),
              CustomTextFormFiled(
                controller: _emailController,
                hintText: appLocalization.email,
                prefixIcon: Assets.icons.sms.svg(),
              ),
              const SizedBox(height: 16),
              CustomTextFormFiled(
                controller: _passwordController,
                isPassword: true,
                hintText: appLocalization.password,
                maxLines: 1,
                prefixIcon: Assets.icons.lock.svg(),
              ),
              const SizedBox(height: 16),
              Bounceable(
                onTap: () {
                  Navigator.pushNamed(context, PagesRouteName.forgetPassword);
                },
                child: Text(
                  appLocalization.forgetPassword,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: ColorPallete.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationColor: ColorPallete.primaryColor,
                    decorationThickness: 2,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              CustomElevatedButton(
                buttonText: appLocalization.login,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    EasyLoading.show();
                    FirebaseAuthUtils.signInWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    ).then((value) {
                      EasyLoading.dismiss();
                      if (value) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          PagesRouteName.layout,
                          (route) => false,
                        );
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: appLocalization.do_not_have_account,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color:
                            provider.isDark()
                                ? Colors.white
                                : ColorPallete.mainTextColor,
                      ),
                    ),
                    WidgetSpan(
                      child: Bounceable(
                        onTap: () {
                          Navigator.pushNamed(context, PagesRouteName.signUp);
                        },
                        child: Text(
                          appLocalization.create_account,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorPallete.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorPallete.primaryColor,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      indent: 40,
                      endIndent: 40,
                      color: ColorPallete.primaryColor,
                    ),
                  ),
                  Text(
                    appLocalization.or,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorPallete.primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      indent: 40,
                      endIndent: 40,
                      color: ColorPallete.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomElevatedButton(
                backgroundColor:
                    appSettingsProvider.isDark()
                        ? Color(0xFF001440)
                        : Colors.white,
                borderColor:
                    appSettingsProvider.isDark()
                        ? Color(0xFF002D8F)
                        : Color(0xFFF0F0F0),
                customChild: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.icons.googleIcn.svg(),
                    Text(
                      appLocalization.login_with_google,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color:
                            appSettingsProvider.isDark()
                                ? Colors.white
                                : theme.primaryColor,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  FirebaseAuthUtils.loginWithGoogle(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
