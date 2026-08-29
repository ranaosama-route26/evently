// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgetPassword => 'نسيت كلمة المرور';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get do_not_have_account => 'ليس لديك حساب؟ ';

  @override
  String get create_account => 'إنشاء حساب جديد';

  @override
  String get login_with_google => 'تسجيل الدخول باستخدام جوجل';

  @override
  String get or => 'أو';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get name => 'الاسم';

  @override
  String get already_have_account => 'هل لديك حساب بالفعل؟';
}
