import 'package:flutter/material.dart';
import 'package:scs_latakia_app/auth/models/login_response_model.dart';
import 'package:scs_latakia_app/auth/models/register_request_model.dart';
import 'package:scs_latakia_app/auth/services/auth_service.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/utils/loading.dart';
import 'package:scs_latakia_app/utils/snack.dart';
import 'package:scs_latakia_app/utils/validators.dart';

class RegisterBottomSheet extends StatefulWidget {
  const RegisterBottomSheet({Key? key}) : super(key: key);

  @override
  State<RegisterBottomSheet> createState() => _RegisterBottomSheetState();
}

class _RegisterBottomSheetState extends State<RegisterBottomSheet> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: MAIN_MARGIN + MediaQuery.of(context).viewInsets.bottom,
        top: MAIN_MARGIN,
        left: MAIN_MARGIN,
        right: MAIN_MARGIN,
      ),
      children: [
        Text(
          "New user",
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
                  if (value == null || value.isEmpty) {
                    return "your name please";
                  }
                  return null;
                },
                controller: _nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: INPUT_DECORATION.copyWith(
                  hintText: 'Name',
                  prefixIcon: const Icon(Icons.person_rounded),
                ),
              ),
              const SizedBox(height: MAIN_MARGIN),
              TextFormField(
                validator: (value) {
                  if (value == null || !isPhoneValid(value)) {
                    return "enter a valid phone number please";
                  }
                  return null;
                },
                controller: _mobileController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: INPUT_DECORATION.copyWith(
                    hintText: 'Phone number',
                    prefixIcon: const Icon(Icons.phone_android_rounded)),
              ),
              const SizedBox(height: MAIN_MARGIN),
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
                        RegisterRequestModel body = RegisterRequestModel(
                            name: _nameController.text.trim(),
                            mobile: _mobileController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text);
                        LoginResponseModel? response =
                            await AuthService.register(body);

                        Navigator.pop(context);
                        Navigator.pop(context);

                        if (response == null) {
                          showSnackbar(context, "try again");
                        } else {
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
                        }
                      },
                    ),
                  );
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
