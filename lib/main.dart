import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/auth/views/auth_screen.dart';
import 'package:scs_latakia_app/const.dart';
import 'package:scs_latakia_app/home/view_models/courses_view_model.dart';
import 'package:scs_latakia_app/home/views/home_screen.dart';
import 'package:scs_latakia_app/l10n/l10n.dart';
import 'package:scs_latakia_app/splash/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scs_latakia_app/utils/locale_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const MaterialColor mainscs =
      MaterialColor(_mainscsPrimaryValue, <int, Color>{
    50: Color(0xFFE4E7EC),
    100: Color(0xFFBBC3CF),
    200: Color(0xFF8E9CB0),
    300: Color(0xFF607490),
    400: Color(0xFF3E5678),
    500: Color(_mainscsPrimaryValue),
    600: Color(0xFF193258),
    700: Color(0xFF142B4E),
    800: Color(0xFF112444),
    900: Color(0xFF091733),
  });
  static const int _mainscsPrimaryValue = 0xFF1C3860;

  static const MaterialColor mainscsAccent =
      MaterialColor(_mainscsAccentValue, <int, Color>{
    100: Color(0xFF6E95FF),
    200: Color(_mainscsAccentValue),
    400: Color(0xFF084BFF),
    700: Color(0xFF0041ED),
  });
  static const int _mainscsAccentValue = 0xFF3B70FF;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CoursesViewModel()),
      ],
      builder: (context, child) {
        var locale = Provider.of<LocaleProvider>(context);

        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: locale.locale,
          supportedLocales: L10n.all,
          theme: ThemeData(
            primaryColor: mainscs,
            fontFamily: 'NextAr',
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 20.0,
                color: mainscs.shade500,
              ),
              headline3: TextStyle(
                fontSize: 18.0,
                color: Colors.black.withOpacity(0.9),
              ),
              bodyText2: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
              button: const TextStyle(
                fontSize: 18.0,
                height: 1.2,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MAIN_RADIUS),
                ),
                minimumSize: const Size.fromHeight(50),
                primary: mainscs.shade500,
                onPrimary: Colors.white,
              ),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (_) => SplashScreen(),
            '/home': (_) => HomeScreen(),
            '/auth': (_) => AuthScreen(),
          },
        );
      },
    );
  }
}
