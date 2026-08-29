import 'package:event_app_c17_mon_7pm/core/theme/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 12.0
    ..maskType = EasyLoadingMaskType.black
    ..backgroundColor = Colors.white
    ..indicatorColor = ColorPallete.primaryColor
    ..textColor = ColorPallete.primaryColor
    ..userInteractions = false
    ..dismissOnTap = false;
}
