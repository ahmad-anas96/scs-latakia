import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/auth/models/login_request_model.dart';
import 'package:scs_latakia_app/auth/models/login_response_model.dart';
import 'package:scs_latakia_app/auth/services/auth_service.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/utils/loading.dart';
import 'package:scs_latakia_app/utils/snack.dart';
import 'package:scs_latakia_app/utils/validators.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({Key? key}) : super(key: key);

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            "Welcome back",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 25.0,
            ),
          ),
          const SizedBox(height: MAIN_MARGIN / 4),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width / 2,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: MAIN_MARGIN),
          Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || !isEmailValid(value)) {
                      return "enter a valid email please";
                    }
                    return null;
                  },
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: INPUT_DECORATION.copyWith(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.alternate_email_outlined),
                  ),
                ),
                const SizedBox(height: MAIN_MARGIN),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password must be 8 char at least";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: INPUT_DECORATION.copyWith(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.security_rounded),
                  ),
                ),
                const SizedBox(height: MAIN_MARGIN),
                ElevatedButton(
                  onPressed: () {
                    if (!_formkey.currentState!.validate()) {
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (context) => Loading(
                        action: () async {
                          LoginRequestModel body = LoginRequestModel(
                              email: _emailController.text.trim(),
                              password: _passwordController.text);
                          LoginResponseModel? response =
                              await AuthService.login(body);

                          Navigator.pop(context);
                          Navigator.pop(context);

                          if (response == null) {
                            showSnackbar(context, "try again");
                          } else if (response.data.user.isActive == false) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return const AlertDialog(
                                  title: Text("Verify account"),
                                  content: Text(
                                      "An email sent to your email with verification link, please check your inbox to verify"),
                                );
                              },
                            );
                          } else {
                            AuthProvider? auth = Provider.of<AuthProvider?>(
                              context,
                              listen: false,
                            );
                            auth?.setLoginData(response.data);
                          }
                        },
                      ),
                    );
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
