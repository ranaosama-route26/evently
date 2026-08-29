import 'package:event_app_c17_mon_7pm/core/gen/assets.gen.dart';
import 'package:event_app_c17_mon_7pm/core/l10n/app_localizations.dart';
import 'package:event_app_c17_mon_7pm/core/routes/pages_route_name.dart';
import 'package:event_app_c17_mon_7pm/core/theme/color_pallete.dart';
import 'package:event_app_c17_mon_7pm/core/utils/firebase_auth_utils.dart';
import 'package:event_app_c17_mon_7pm/core/widgets/custom_elevated_button.dart';
import 'package:event_app_c17_mon_7pm/core/widgets/custom_text_form_filed.dart';
import 'package:event_app_c17_mon_7pm/modules/app_settings_provider/app_settings_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalization = AppLocalizations.of(context)!;
    final appSettingsProvider = Provider.of<AppSettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Assets.images.eventlyLogo.image(
          width: 150,
          height: 30,
          color: theme.primaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Create your account",
                textAlign: TextAlign.start,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 24),
              CustomTextFormFiled(
                controller: _nameController,
                hintText: appLocalization.name,
                prefixIcon: Assets.icons.userIcn.svg(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "plz enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormFiled(
                controller: _emailController,
                hintText: appLocalization.email,
                prefixIcon: Assets.icons.sms.svg(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "plz enter your email address";
                  }

                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if (!emailRegex.hasMatch(value.trim())) {
                    return "Please enter a valid email address";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormFiled(
                controller: _passwordController,
                isPassword: true,
                hintText: appLocalization.password,
                prefixIcon: Assets.icons.lock.svg(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "plz enter your password";
                  }

                  final passwordRegex = RegExp(
                    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$',
                  );

                  if (!passwordRegex.hasMatch(value)) {
                    return "Password must be at least 8 characters,\ninclude uppercase, lowercase, number and special character";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormFiled(
                isPassword: true,
                hintText: appLocalization.password,
                prefixIcon: Assets.icons.lock.svg(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "plz enter your password";
                  }

                  if (value != _passwordController.text) {
                    return "password does not match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 55),
              CustomElevatedButton(
                buttonText: appLocalization.create_account,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    /// calling api to create account
                    EasyLoading.show();
                    FirebaseAuthUtils.signUpWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    ).then((value) {
                      EasyLoading.dismiss();
                      if (value) {
                        Navigator.pop(context);
                        toastification.show(
                          type: ToastificationType.success,
                          title: Text("Account Created Successfully"),
                          autoCloseDuration: Duration(seconds: 5),
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
                      text: appLocalization.already_have_account,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorPallete.mainTextColor,
                      ),
                    ),
                    WidgetSpan(
                      child: Bounceable(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          appLocalization.login,
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
