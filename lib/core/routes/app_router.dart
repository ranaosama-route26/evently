import 'package:event_app_c17_mon_7pm/core/routes/pages_route_name.dart';
import 'package:event_app_c17_mon_7pm/model/event_data_model.dart';
import 'package:event_app_c17_mon_7pm/modules/add_event/add_event_view.dart';
import 'package:event_app_c17_mon_7pm/modules/authentication/forget_password/forget_password_view.dart';
import 'package:event_app_c17_mon_7pm/modules/authentication/sign_in/sign_in_view.dart';
import 'package:event_app_c17_mon_7pm/modules/authentication/sign_up/sign_up_view.dart';
import 'package:event_app_c17_mon_7pm/modules/edit_event/edit_event_screen.dart';
import 'package:event_app_c17_mon_7pm/modules/event_details/event_details.dart';
import 'package:event_app_c17_mon_7pm/modules/layout/layout_page.dart';
import 'package:event_app_c17_mon_7pm/modules/on_boarding/on_boarding_view.dart';
import 'package:event_app_c17_mon_7pm/modules/splash/splash_view.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRouteName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );

      case PagesRouteName.signIn:
        return MaterialPageRoute(
          builder: (context) => const SignInView(),
          settings: settings,
        );

      case PagesRouteName.signUp:
        return MaterialPageRoute(
          builder: (context) => SignUpView(),
          settings: settings,
        );

      case PagesRouteName.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordView(),
          settings: settings,
        );

      case PagesRouteName.onBoarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
          settings: settings,
        );

      case PagesRouteName.layout:
        return MaterialPageRoute(
          builder: (context) => const LayoutPage(),
          settings: settings,
        );

      case PagesRouteName.eventDetails:
        final event = settings.arguments as EventDataModel;
        return MaterialPageRoute(
          builder: (context) => EventDetailsScreen(eventDataModel: event),
          settings: settings,
        );

      case PagesRouteName.editEvent:
        final event = settings.arguments as EventDataModel;
        return MaterialPageRoute(
          builder: (context) => EditEventScreen(eventDataModel: event),
          settings: settings,
        );

      case PagesRouteName.addEvent:
        return MaterialPageRoute(
          builder: (context) => const AddEventView(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
    }
  }
}
