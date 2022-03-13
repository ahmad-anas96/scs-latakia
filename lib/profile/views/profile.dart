import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/auth/models/user_model.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/profile/views/edit_bottom_sheet.dart';
import 'package:scs_latakia_app/profile/views/my_qr_code.dart';
import 'package:scs_latakia_app/profile/views/password_bottom_sheet.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/utils/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider? _auth = Provider.of<AuthProvider?>(context);
    UserModel _user = AuthProvider.loginData!.user;

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(MAIN_MARGIN / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)?.personalInfo}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width / 2,
                        color: Theme.of(context).colorScheme.secondary,
                        margin: const EdgeInsets.symmetric(
                            vertical: MAIN_MARGIN / 4),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${AppLocalizations.of(context)?.name}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        _user.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: imageWithLoader(_user.imagePath, null),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)?.email}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          _user.email,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => const QrCodeWidget(),
                      );
                    },
                    icon: Icon(Icons.qr_code_rounded,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              const Divider(),
              Text(
                "${AppLocalizations.of(context)?.mobile}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                _user.mobile,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: MAIN_MARGIN / 2),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(MAIN_MARGIN / 2),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)?.bio}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width / 2,
                      color: Theme.of(context).colorScheme.secondary,
                      margin:
                          const EdgeInsets.symmetric(vertical: MAIN_MARGIN / 4),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _user.bio ?? '-',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              if ((_user.linkedin ?? '').isNotEmpty)
                IconButton(
                  onPressed: () async {
                    try {
                      await launch("${_user.linkedin}");
                    } catch (e) {
                      log("$e");
                    }
                  },
                  icon: Image.asset(
                    "assets/images/linkedin.png",
                    height: 25,
                    width: 25,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: MAIN_MARGIN / 2),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(MAIN_MARGIN / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const EditProfileBottomSheet(),
                  );
                },
                style: TextButtonTheme.of(context).style?.copyWith(
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                icon: const Icon(Icons.edit_rounded),
                label: Text("${AppLocalizations.of(context)?.editInfo}"),
              ),
              const Divider(),
              TextButton.icon(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => const PasswordBottomSheet(),
                ),
                style: TextButtonTheme.of(context).style?.copyWith(
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                icon: const Icon(Icons.security_rounded),
                label: Text("${AppLocalizations.of(context)?.changePassword}"),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _auth?.setLoginData(null),
            child: Padding(
              padding: const EdgeInsets.all(MAIN_MARGIN),
              child: Row(
                children: [
                  const Icon(
                    Icons.power_settings_new_rounded,
                    size: 25,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: MAIN_MARGIN / 2),
                  Text(
                    "${AppLocalizations.of(context)?.logout}",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.grey,
                          height: 1.3,
                        ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
