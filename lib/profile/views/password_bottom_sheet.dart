import 'package:flutter/material.dart';
import 'package:scs_latakia_app/auth/services/auth_service.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/utils/loading.dart';
import 'package:scs_latakia_app/utils/snack.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordBottomSheet extends StatefulWidget {
  const PasswordBottomSheet({Key? key}) : super(key: key);

  @override
  State<PasswordBottomSheet> createState() => _PasswordBottomSheetState();
}

class _PasswordBottomSheetState extends State<PasswordBottomSheet> {
  GlobalKey<FormState>? _formKey;
  final TextEditingController? _oldController = TextEditingController();
  final TextEditingController? _newController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MAIN_MARGIN),
      margin: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AppLocalizations.of(context)?.changePassword}",
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
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  obscureText: true,
                  controller: _oldController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "${AppLocalizations.of(context)?.passwordError}";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: INPUT_DECORATION.copyWith(
                    hintText: "${AppLocalizations.of(context)?.currentPassword}",
                    prefixIcon: const Icon(Icons.security_rounded),
                  ),
                ),
                const SizedBox(height: MAIN_MARGIN),
                TextFormField(
                  obscureText: true,
                  controller: _newController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "${AppLocalizations.of(context)?.passwordError}";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: INPUT_DECORATION.copyWith(
                    hintText: "${AppLocalizations.of(context)?.newPassword}",
                    prefixIcon: const Icon(Icons.security_rounded),
                  ),
                ),
                const SizedBox(height: MAIN_MARGIN),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (!_formKey!.currentState!.validate()) {
                return;
              }
              showDialog(
                context: context,
                builder: (context) => Loading(
                  action: () async {
                    bool info = await AuthService.changePassword(
                      AuthProvider.loginData!.user.id,
                      _oldController?.text ?? '',
                      _newController?.text ?? '',
                    );

                    Navigator.pop(context);
                    if (info) {
                      Navigator.pop(context);
                      showSnackbar(context, "${AppLocalizations.of(context)?.passwordChanged}");
                    }
                  },
                ),
              );
            },
            child: Text("${AppLocalizations.of(context)?.save}"),
          ),
        ],
      ),
    );
  }
}
