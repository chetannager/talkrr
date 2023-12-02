import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:talkrr/core/providers/api.dart';
import 'package:talkrr/utils/colors.dart';
import 'package:talkrr/utils/images.dart';
import 'package:talkrr/core/redux/actions/account_actions.dart';
import 'package:talkrr/core/redux/stores/app_state.dart';
import 'package:talkrr/utils/utils.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final api _api = api();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isProcessing = false;

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode fullnameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  Future<void> register() async {
    setState(() {
      isProcessing = true;
    });
    await _api
        .register(usernameController.text, fullnameController.text,
            passwordController.text)
        .then((dynamic response) async {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        Map<String, dynamic> RESPONSE = data['RESPONSE'];
        if (kDebugMode) {
          print(RESPONSE);
        }
        if (!RESPONSE["isVerified"] &&
            RESPONSE["isLoggedIn"] &&
            RESPONSE["isRegistered"]) {
          final store = StoreProvider.of<AppState>(context);
          store.dispatch(SetLoggedInAction(RESPONSE["token"]));
          Navigator.pushNamedAndRemoveUntil(
              context, "/tabs", (Route<dynamic> route) => false);
        }
      } else if (response.statusCode == 400) {
        final Map<String, dynamic> data = json.decode(response.body);
        Map<String, dynamic> RESPONSE = data['RESPONSE'];
        if (kDebugMode) {
          print(RESPONSE);
        }
        showSnackBar(context, RESPONSE["error_message"]);
      } else {
        showSnackBar(context, "Something went wrong. Please try again later.");
      }
      setState(() {
        isProcessing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildEmailTextField() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: const Icon(
              Icons.alternate_email_sharp,
              color: kInputColor,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextField(
              enabled: !isProcessing,
              cursorColor: Colors.white,
              controller: usernameController,
              focusNode: usernameFocusNode,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: "Email ID",
                hintStyle: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w500,
                  color: kInputColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
              ),
              onSubmitted: (value) {
                if (!validateEmailAddress(value)) {
                  usernameFocusNode.requestFocus();
                } else if (!isRequired(fullnameController.text)) {
                  fullnameFocusNode.requestFocus();
                } else if (!isRequired(passwordController.text)) {
                  passwordFocusNode.requestFocus();
                }
              },
            ),
          )
        ],
      );
    }

    Widget _buildNameTextField() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: const Icon(
              Icons.person_outline,
              color: kInputColor,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextField(
              enabled: !isProcessing,
              cursorColor: Colors.white,
              controller: fullnameController,
              focusNode: fullnameFocusNode,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: "Full Name",
                hintStyle: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w500,
                  color: kInputColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
              ),
              onSubmitted: (value) {
                if (!validateEmailAddress(usernameController.text)) {
                  usernameFocusNode.requestFocus();
                } else if (!isRequired(value)) {
                  fullnameFocusNode.requestFocus();
                } else if (!isRequired(passwordController.text)) {
                  passwordFocusNode.requestFocus();
                }
              },
            ),
          )
        ],
      );
    }

    Widget buildPasswordTextField() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: const Icon(
              Icons.lock_outlined,
              color: kInputColor,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextField(
              enabled: !isProcessing,
              cursorColor: Colors.white,
              controller: passwordController,
              focusNode: passwordFocusNode,
              obscureText: true,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w500,
                  color: kInputColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
              ),
              onSubmitted: (value) {
                if (!validateEmailAddress(usernameController.text)) {
                  usernameFocusNode.requestFocus();
                } else if (!isRequired(fullnameController.text)) {
                  fullnameFocusNode.requestFocus();
                } else if (!isRequired(value)) {
                  passwordFocusNode.requestFocus();
                }
              },
            ),
          )
        ],
      );
    }

    Widget _buildContinueBtn() {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          onPressed: isProcessing
              ? null
              : () {
                  if (!validateEmailAddress(usernameController.text)) {
                    usernameFocusNode.requestFocus();
                  } else if (!isRequired(fullnameController.text)) {
                    fullnameFocusNode.requestFocus();
                  } else if (!isRequired(passwordController.text)) {
                    passwordFocusNode.requestFocus();
                  } else {
                    register();
                  }
                },
          elevation: 0.0,
          highlightElevation: 0.0,
          color: kButtonColor,
          disabledColor: kButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: isProcessing
              ? const SpinKitThreeBounce(
                  duration: Duration(milliseconds: 800),
                  color: Colors.white,
                  size: 20.0,
                )
              : const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 30.0, left: 25.0, right: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: kBackButtonColor,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(Images.REGISTER),
                ),
              ),
              Expanded(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.blueAccent.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 36.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _buildEmailTextField(),
                    const SizedBox(
                      height: 25.0,
                    ),
                    _buildNameTextField(),
                    const SizedBox(
                      height: 25.0,
                    ),
                    buildPasswordTextField(),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        child: RichText(
                          text: const TextSpan(
                            text: "By signing up, you're agree to our ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: kTextColor,
                              fontWeight: FontWeight.w500,
                              height: 1.35,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms & Conditions",
                                style: TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w500,
                                  color: kLinkColor,
                                ),
                              ),
                              TextSpan(
                                text: " and ",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: kTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                  fontSize: 16.5,
                                  color: kLinkColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    _buildContinueBtn(),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Joined us before?",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w500,
                              color: kLinkColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
