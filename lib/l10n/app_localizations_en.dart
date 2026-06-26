// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Evently';

  @override
  String get onBoardingTitle => 'Personalize Your Experience';

  @override
  String get onBoardingDes =>
      'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgetPassword => 'Forget Password?';

  @override
  String get login => 'Login';

  @override
  String get notHaveAccount => 'Don’t Have Account ? ';

  @override
  String get createAccount => 'Create Account';

  @override
  String get name => 'Name';

  @override
  String get rePassword => 'RePassword';

  @override
  String get haveAccount => 'Already Have Account ? ';
}
