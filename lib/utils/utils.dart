import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_snackbars/enums/animate_from.dart';
import 'package:smart_snackbars/smart_snackbars.dart';

bool isRequired(input) {
  RegExp requiredRegExp = RegExp(r"(.|\s)*\S(.|\s)*");
  return requiredRegExp.hasMatch(input);
}

bool validateMobileNumber(mobileNumber) {
  RegExp mobileNumberRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  return mobileNumberRegExp.hasMatch(mobileNumber);
}

bool validateEmailAddress(emailAddress) {
  RegExp emailAddressRegExp = RegExp(
      r'(^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$)');
  return emailAddressRegExp.hasMatch(emailAddress);
}

bool validateFullName(fullName) {
  //RegExp fullNameRegExp = RegExp(r"(^[A-Za-z,.'-]{2,} +[A-Za-z,.'-]{2,}$)");
  RegExp fullNameRegExp = RegExp(r"(^[A-Za-z\s]{3,}$)");
  return fullNameRegExp.hasMatch(fullName);
}

bool validateAddress(address) {
  RegExp fullNameRegExp = RegExp(r"(.|\s)*\S(.|\s)*");
  return fullNameRegExp.hasMatch(address);
}

bool validateLandmark(landmark) {
  RegExp fullNameRegExp = RegExp(r"(.|\s)*\S(.|\s)*");
  return fullNameRegExp.hasMatch(landmark);
}

bool validateAnnotation(annotation) {
  RegExp fullNameRegExp = RegExp(r"(.|\s)*\S(.|\s)*");
  return fullNameRegExp.hasMatch(annotation);
}

bool validateComment(comment) {
  RegExp fullNameRegExp = RegExp(r"(.|\s)*\S(.|\s)*");
  return fullNameRegExp.hasMatch(comment);
}

bool validateOTP(otp) {
  RegExp otpRegExp = RegExp(r'(^([0-9]{4})$)');
  return otpRegExp.hasMatch(otp);
}

bool validatePassword(password) {
  RegExp passwordRegExp = RegExp(r'(^\S{6,}$)');
  return passwordRegExp.hasMatch(password);
}

bool validateCouponCode(couponCode) {
  RegExp couponCodeRegExp = RegExp(r'(^[A-Za-z0-9]+$)');
  return couponCodeRegExp.hasMatch(couponCode);
}

Future removeAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("AUTH_TOKEN");
}

Future setAuthToken(String AUTH_TOKEN) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("AUTH_TOKEN", AUTH_TOKEN);
}

showSnackBar(BuildContext context, errorMsg) {
  SmartSnackBars.showTemplatedSnackbar(
    context: context,
    backgroundColor: Colors.red,
    elevation: 5.0,
    animateFrom: AnimateFrom.fromTop,
    animationCurve: Curves.fastEaseInToSlowEaseOut,
    leading: Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
      ),
      child: const Icon(
        Icons.close,
        color: Colors.white,
      ),
    ),
    subTitleWidget: Text(
      errorMsg,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
  );
}

showSuccessSnackBar(BuildContext context, successMsg) {
  SmartSnackBars.showTemplatedSnackbar(
    context: context,
    backgroundColor: Colors.green,
    elevation: 5.0,
    animateFrom: AnimateFrom.fromTop,
    animationCurve: Curves.fastEaseInToSlowEaseOut,
    leading: Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
      ),
      child: const Icon(
        Icons.check,
        color: Colors.white,
      ),
    ),
    subTitleWidget: Text(
      successMsg,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      maxLines: 2,
    ),
  );
}
