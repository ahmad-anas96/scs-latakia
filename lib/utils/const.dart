// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';

const MAIN_MARGIN = 25.0;
const MAIN_RADIUS = 10.0;
const ROOT = "https://scs-latakia.atconcept.tech";
const ROOT_API = "$ROOT/api";
const ROOT_UPLOADS = "$ROOT/uploads";

Map<String, String>? getHeaders() => {
      'Authorization': 'Bearer ${AuthProvider.loginData?.accessToken}',
    };

Future<String> getVersionCode() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.buildNumber;
}

const INPUT_DECORATION = InputDecoration(
  filled: true,
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(
      Radius.circular(MAIN_RADIUS),
    ),
  ),
  contentPadding: EdgeInsets.only(
    left: 5,
    right: 5,
  ),
);
