import 'package:flutter/material.dart';

const MAIN_MARGIN = 25.0;
const MAIN_RADIUS = 10.0;
const ROOT = "http://scs-latakia.atconcept.tech";
const ROOT_API = "$ROOT/api";

const INPUT_DECORATION = InputDecoration(
  filled: true,
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(
      Radius.circular(MAIN_RADIUS),
    ),
  ),
  // focusedBorder: UnderlineInputBorder(
  //   borderSide: BorderSide(color: MyApp.mainscsAccent),
  // ),
  // enabledBorder: UnderlineInputBorder(
  //   borderSide: BorderSide(color: MyApp.mainscsAccent),
  // ),
  contentPadding: EdgeInsets.only(
    left: 5,
    right: 5,
  ),
);
