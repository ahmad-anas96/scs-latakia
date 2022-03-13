import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/auth/models/login_response_model.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/auth/views/auth_screen.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/home/views/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _splash = true;

  @override
  Widget build(BuildContext context) {
    AuthProvider? _auth = Provider.of<AuthProvider?>(context);

    if (!_splash) {
      if (_auth?.isLoggedIn() == true) {
        return const HomeScreen();
      } else {
        return const AuthScreen();
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/scs-header.jpg',
            height: 190.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Expanded(child: Container()),
          Container(
            padding: const EdgeInsets.all(MAIN_MARGIN),
            child: AnimatedTextKit(
                isRepeatingAnimation: false,
                onFinished: () => _checkAuthAndPages(),
                animatedTexts: [
                  TyperAnimatedText(
                    "${AppLocalizations.of(context)?.title}",
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'NextAr',
                      color: Theme.of(context).primaryColor,
                    ),
                    speed: const Duration(milliseconds: 50),
                  ),
                ]),
          ),
          Expanded(child: Container()),
          const Text('powered by'),
          Text(
            'atConcept',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: MAIN_MARGIN)
        ],
      ),
    );
  }

  Future<void> _checkAuthAndPages() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? login = _prefs.getString("login");
    if (login != null && login.isNotEmpty) {
      AuthProvider? _auth = Provider.of<AuthProvider?>(context, listen: false);
      _auth?.setLoginData(LoginData.fromRawJson(login));
    }
    setState(() {
      _splash = false;
    });
  }
}
