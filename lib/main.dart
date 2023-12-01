import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:talkrr/ui/pages/login/login.dart';
import 'package:talkrr/ui/pages/register/register.dart';
import 'package:talkrr/ui/pages/splash/splash.dart';
import 'package:talkrr/ui/pages/tabs/tabs.dart';
import 'package:talkrr/utils/colors.dart';
import 'core/redux/reducers/index.dart';
import 'core/redux/stores/account_state.dart';
import 'core/redux/stores/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
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
        home: const Splash(),
        routes: {
          "/tabs": (context) => const Tabs(),
          "/login": (context) => const Login(),
          "/register": (context) => const Register(),
        },
      ),
    );
  }
}
