import 'package:flutter/material.dart';
import 'package:scs_latakia_app/auth/views/login_bottom_sheet.dart';
import 'package:scs_latakia_app/auth/views/register_bottom_sheet.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: const AssetImage("assets/images/scs0.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(MAIN_MARGIN),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Image.asset('assets/images/scs-logo.jpg')),
                Expanded(child: Container()),
                const SizedBox(
                  height: MAIN_MARGIN,
                ),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return const RegisterBottomSheet();
                      }),
                  child: Text(
                    "${AppLocalizations.of(context)?.newUser}",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(
                  height: MAIN_MARGIN,
                ),
                ElevatedButton(
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const LoginBottomSheet()),
                  child: Text("${AppLocalizations.of(context)?.login}"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
