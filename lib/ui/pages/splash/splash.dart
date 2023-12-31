import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkrr/ui/pages/login/login.dart';
import 'package:talkrr/ui/pages/tabs/tabs.dart';
import 'package:talkrr/utils/images.dart';
import 'package:talkrr/core/redux/actions/account_actions.dart';
import 'package:talkrr/core/redux/stores/app_state.dart';
import 'package:talkrr/ui/pages/callpage/callpage.dart';

class Splash extends StatefulWidget {
  final GlobalKey navigatorKey;

  const Splash(this.navigatorKey, {super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? AUTH_TOKEN = prefs.getString("AUTH_TOKEN");
    Store store = StoreProvider.of<AppState>(context);
    if (AUTH_TOKEN == null) {
      store.dispatch(LogoutAction());
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      });
    } else {
      if (JwtDecoder.isExpired(AUTH_TOKEN)) {
        store.dispatch(LogoutAction());
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login()));
        });
      } else {
        store.dispatch(SetLoggedInAction(AUTH_TOKEN));
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Tabs()));
        });
      }
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print("onMessageOpenedApp: $message");
      }

      String callId = message.data["callId"];

      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Tabs()));
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.push(
          widget.navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => CallPage(
              callId,
            ),
          ),
        );
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Image.asset(
            Images.APPICON,
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
