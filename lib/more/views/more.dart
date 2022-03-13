import 'package:flutter/material.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MorePageWidget extends StatelessWidget {
  const MorePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(MAIN_MARGIN / 2),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${AppLocalizations.of(context)?.contact}",
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
                margin: const EdgeInsets.symmetric(vertical: MAIN_MARGIN / 4),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)?.mobile}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "0933 976 000",
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
                      launch("tel:0933976000");
                    },
                    icon: Icon(
                      Icons.phone_android_rounded,
                      color: Theme.of(context).colorScheme.primaryVariant,
                    ),
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
                          "${AppLocalizations.of(context)?.phone}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "041 255 9950",
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
                      launch("tel:0412559950");
                    },
                    icon: Icon(
                      Icons.phone_rounded,
                      color: Theme.of(context).colorScheme.primaryVariant,
                    ),
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
                          "scs-lat@scs-net.org",
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
                      launch("mailto:scs-lat@scs-net.org");
                    },
                    icon: Icon(
                      Icons.mail_rounded,
                      color: Theme.of(context).colorScheme.primaryVariant,
                    ),
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
                          "${AppLocalizations.of(context)?.facebook}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "scs.latakia",
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
                      launch("https://www.facebook.com/scs.latakia");
                    },
                    icon: Icon(
                      Icons.facebook_rounded,
                      color: Theme.of(context).colorScheme.primaryVariant,
                    ),
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
                          "${AppLocalizations.of(context)?.address}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "${AppLocalizations.of(context)?.addressBody}",
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
                      launch("https://goo.gl/maps/LRPZqKQL9bnKbMBx8");
                    },
                    icon: Icon(
                      Icons.map_rounded,
                      color: Theme.of(context).colorScheme.primaryVariant,
                    ),
                  ),
                ],
              ),
            ]),
      ),
      const SizedBox(height: MAIN_MARGIN / 2),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(MAIN_MARGIN / 2),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Powered by",
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
                margin: const EdgeInsets.symmetric(vertical: MAIN_MARGIN / 4),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Developer",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "Ahmad Anas Alsaleh",
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
                      launch("https://linkedin.com/in/ahmad-alsaleh96");
                    },
                    icon: Image.asset(
                      "assets/images/linkedin.png",
                      height: 25,
                      width: 25,
                    ),
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
                          "Team",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "atConcept",
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
                      launch("https://atconcept.tech");
                    },
                    icon: Icon(
                      Icons.link_rounded,
                      color: Theme.of(context).colorScheme.primaryVariant,
                    ),
                  ),
                ],
              ),
            ]),
      ),
    ]);
  }
}
