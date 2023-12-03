import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:talkrr/ui/pages/callpage/callpage.dart';
import 'package:talkrr/ui/pages/login/login.dart';
import 'package:talkrr/ui/pages/register/register.dart';
import 'package:talkrr/ui/pages/splash/splash.dart';
import 'package:talkrr/ui/pages/tabs/tabs.dart';
import 'package:talkrr/utils/colors.dart';
import 'core/redux/reducers/index.dart';
import 'core/redux/stores/account_state.dart';
import 'core/redux/stores/app_state.dart';
import 'dart:math';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_stat_video_call');
const InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
);

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  String callId = payload!.split(": ")[1].replaceAll("}", "");
  await Navigator.push(
    navigatorKey.currentState!.context,
    MaterialPageRoute<void>(builder: (context) => CallPage(callId)),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
  );
  final Store<AppState> store = Store<AppState>(
    rootReducers,
    initialState: AppState(
      AccountState(
        isLoggedIn: false,
        AUTH_TOKEN: "",
        userDetails: const {},
      ),
    ),
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final store;

  const MyApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );
    // FirebaseMessaging.instance.getToken().then((token) {
    //   if (kDebugMode) {
    //     print(token);
    //   }
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        // if (kDebugMode) {
        //   print("onMessage: " + message.data.toString());
        // }
        showLocalPushNotification(message.notification?.title,
            message.notification?.body, message.data.toString());
      }
    });

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kPrimaryColor,
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: appBarBackgroundColor,
            toolbarHeight: 90.0,
            titleTextStyle: TextStyle(
              color: appBarTitleColor,
              fontSize: 24.0,
              letterSpacing: 0.8,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            primary: kPrimaryColor,
            seedColor: kPrimaryColor,
          ),
          useMaterial3: false,
        ),
        home: Splash(navigatorKey),
        routes: {
          "/tabs": (context) => const Tabs(),
          "/login": (context) => const Login(),
          "/register": (context) => const Register(),
        },
      ),
    );
  }
}

dynamic showLocalPushNotification(
    String? title, String? body, String? payload) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    '2121173314',
    'Notification Channel',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      Random().nextInt(1000), title, body, platformChannelSpecifics,
      payload: payload);
}
