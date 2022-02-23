import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/auth/models/login_response_model.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/scs-header.jpg'),
            Expanded(child: Container()),
            Container(
              padding: const EdgeInsets.all(MAIN_MARGIN),
              child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  onFinished: () => _checkAuthAndPages(context),
                  animatedTexts: [
                    TyperAnimatedText(
                      "الجمعية العلمية السورية للمعلوماتية\nفرع اللاذقية",
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
            const SizedBox(
              height: MAIN_MARGIN,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _checkAuthAndPages(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? login = _prefs.getString("login");
    if (login != null && login.isNotEmpty) {
      AuthProvider? auth = Provider.of<AuthProvider?>(context, listen: false);
      auth?.setLoginData(LoginData.fromRawJson(login));
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false);
    }
  }
}
