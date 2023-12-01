import 'package:flutter/material.dart';
import 'package:talkrr/utils/colors.dart';
import 'package:talkrr/ui/pages/register/register.dart';
import 'package:talkrr/utils/images.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          const Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Email ID",
                hintStyle: TextStyle(
                  fontSize: 18.0,
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
          const Expanded(
            child: TextField(
              obscureText: true,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(
                  fontSize: 18.0,
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
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          onPressed: () => {},
          child: const Text(
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
                          "New to Logistics",
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
                                  builder: (context) => const Register())),
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
