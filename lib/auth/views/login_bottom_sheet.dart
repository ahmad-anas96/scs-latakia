import 'package:flutter/material.dart';
import 'package:scs_latakia_app/const.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MAIN_MARGIN + MediaQuery.of(context).viewInsets.bottom,
        top: MAIN_MARGIN,
        left: MAIN_MARGIN,
        right: MAIN_MARGIN,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "مرحبا",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 25.0,
              // fontWeight: FontWeight.w600,
            ),
            // style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: MAIN_MARGIN / 4,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width / 2,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(
            height: MAIN_MARGIN,
          ),
          Form(
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: INPUT_DECORATION.copyWith(
                    hintText: 'الايميل',
                    prefixIcon: const Icon(Icons.alternate_email_outlined),
                  ),
                ),
                const SizedBox(
                  height: MAIN_MARGIN,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: INPUT_DECORATION.copyWith(
                    hintText: 'كلمة المرور',
                    prefixIcon: const Icon(Icons.security_rounded),
                  ),
                ),
                const SizedBox(
                  height: MAIN_MARGIN,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "تسجيل",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
