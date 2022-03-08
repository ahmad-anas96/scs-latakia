import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scs_latakia_app/auth/models/user_model.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/utils/const.dart';

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel _user = AuthProvider.loginData!.user;
    return Container(
      padding: const EdgeInsets.all(MAIN_MARGIN),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your QR Code",
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(MAIN_MARGIN / 2),
              child: QrImage(
                data: _user.id,
                version: QrVersions.auto,
                size: 200.0,
                embeddedImage: Image.asset('assets/images/scs-logo.jpg').image,
                foregroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
