import 'package:flutter/material.dart';
import 'package:talkrr/utils/colors.dart';
import 'package:talkrr/utils/images.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              decoration: InputDecoration(
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
          const Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              decoration: InputDecoration(
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
          const Expanded(
            child: TextField(
              obscureText: true,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              decoration: InputDecoration(
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
            ),
          )
        ],
      );
    }

    Widget _buildContinueBtn() {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          onPressed: () => {},
          elevation: 0.0,
          highlightElevation: 0.0,
          color: kButtonColor,
          disabledColor: kButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: const Text(
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
