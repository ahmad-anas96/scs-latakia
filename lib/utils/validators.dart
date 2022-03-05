import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';

bool isEmailValid(String? input) =>
    EmailValidator.validate(input?.trim() ?? "");

bool isPhoneValid(String? input) =>
    RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
        .hasMatch(input?.trim() ?? "");

String formatDateTime(DateTime dateTime) =>
    DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

String getDate(DateTime dateTime) => formatDateTime(dateTime).split(' ')[0];

String getTime(DateTime dateTime) => formatDateTime(dateTime).split(' ')[1];
