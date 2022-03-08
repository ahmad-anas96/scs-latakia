import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/auth/models/user_model.dart';
import 'package:scs_latakia_app/auth/services/auth_service.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/utils/loading.dart';
import 'package:scs_latakia_app/utils/snack.dart';
import 'package:scs_latakia_app/utils/validators.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({Key? key}) : super(key: key);

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  GlobalKey<FormState>? _formKey;
  TextEditingController? _nameController;
  TextEditingController? _mobileController;
  TextEditingController? _bioController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    UserModel user = AuthProvider.loginData!.user;
    _nameController = TextEditingController(text: user.name);
    _mobileController = TextEditingController(text: user.mobile);
    _bioController = TextEditingController(text: user.bio);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider? _auth = Provider.of<AuthProvider?>(context);

    return Container(
      padding: const EdgeInsets.all(MAIN_MARGIN),
      margin: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Edit Information",
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
                  controller: _bioController,
                  maxLines: 3,
                  decoration: INPUT_DECORATION.copyWith(
                    hintText: 'Bio',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: MAIN_MARGIN / 2,
                      vertical: MAIN_MARGIN / 4,
                    ),
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
                    var body = UserModel(
                      id: AuthProvider.loginData!.user.id,
                      email: AuthProvider.loginData!.user.email,
                      role: AuthProvider.loginData!.user.role,
                      name: _nameController?.text ?? '',
                      mobile: _mobileController?.text ?? '',
                      bio: _bioController?.text ?? '',
                    );
                    var info = await AuthService.editProfile(body);
                    Navigator.pop(context);
                    if (info) {
                      Navigator.pop(context);
                      showSnackbar(context, "Profile edited successfully");
                      AuthProvider.loginData?.user.name = body.name;
                      AuthProvider.loginData?.user.mobile = body.mobile;
                      AuthProvider.loginData?.user.bio = body.bio;
                      _auth?.setLoginData(AuthProvider.loginData);
                    }
                  },
                ),
              );
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
