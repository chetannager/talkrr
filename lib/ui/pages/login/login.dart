import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:talkrr/core/providers/api.dart';
import 'package:talkrr/utils/colors.dart';
import 'package:talkrr/ui/pages/register/register.dart';
import 'package:talkrr/utils/images.dart';
import 'package:talkrr/core/redux/actions/account_actions.dart';
import 'package:talkrr/core/redux/stores/app_state.dart';
import 'package:talkrr/utils/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final api _api = api();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isProcessing = false;

  Future<void> authentication() async {
    setState(() {
      isProcessing = true;
    });
    await _api
        .authentication(usernameController.text, passwordController.text)
        .then((dynamic response) async {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        Map<String, dynamic> RESPONSE = data['RESPONSE'];
        if (kDebugMode) {
          print(RESPONSE);
        }
        if (RESPONSE["isVerified"] && RESPONSE["isLoggedIn"]) {
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
            child: TextFormField(
              controller: usernameController,
              enabled: !isProcessing,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: "Email ID",
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: kInputColor,
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  //return 'Please enter email address!';
                }
                return null;
              },
            ),
          )
        ],
      );
    }

    Widget _buildPasswordTextField() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: const Icon(
              Icons.lock_outline_sharp,
              color: kInputColor,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextFormField(
              controller: passwordController,
              enabled: !isProcessing,
              obscureText: true,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: kInputColor,
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password!';
                }
                return null;
              },
            ),
          )
        ],
      );
    }

    Widget _buildLoginBtn() {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          elevation: 0.0,
          highlightElevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          color: kButtonColor,
          disabledColor: kButtonColor,
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          onPressed: isProcessing
              ? null
              : () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    authentication();
                  }
                },
          child: isProcessing
              ? const SpinKitThreeBounce(
                  duration: Duration(milliseconds: 800),
                  color: Colors.white,
                  size: 20.0,
                )
              : const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      );
    }

    Widget _buildGoogleLoginBtn() {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () => {},
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          color: const Color.fromRGBO(245, 245, 245, 1),
          child: Row(
            children: [
              const SizedBox(
                width: 40.0,
              ),
              Image.asset(
                "assets/images/google.webp",
                width: 30.0,
              ),
              const SizedBox(
                width: 45.0,
              ),
              const Text(
                "Login with Google",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromRGBO(30, 41, 68, 1),
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
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
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(Images.LOGIN),
                ),
              ),
              Expanded(
                flex: 6,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent.shade700,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      _buildEmailTextField(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTextField(),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          // onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ForgotPassword())),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 17.0,
                              color: kLinkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      _buildLoginBtn()
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          indent: 10.0,
                          thickness: 0.5,
                          color: dividerColor,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 70.0,
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          indent: 10.0,
                          thickness: 0.5,
                          color: dividerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildGoogleLoginBtn(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "New to Talkrr",
                          style: TextStyle(
                            fontSize: 17.0,
                            color: kTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          ),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 16.5,
                              color: kLinkColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
