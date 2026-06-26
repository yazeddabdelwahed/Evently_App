// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get title => 'إيفنتلي';

  @override
  String get onBoardingTitle => 'خصص تجربتك';

  @override
  String get onBoardingDes =>
      'اختر اللغة والمظهر المفضلين لديك لتبدأ تجربة مريحة ومصممة خصيصًا لتناسب أسلوبك.';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgetPassword => 'نسيت كلمة المرور؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get notHaveAccount => ' ليس لديك حساب؟';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get name => 'الاسم';

  @override
  String get rePassword => 'إعادة كلمة المرور';

  @override
  String get haveAccount => 'لديك حساب بالفعل؟';
}
