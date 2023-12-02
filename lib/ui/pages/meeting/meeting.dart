import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:talkrr/core/providers/api.dart';
import 'package:talkrr/utils/constants.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:talkrr/core/redux/actions/account_actions.dart';
import 'package:talkrr/core/redux/stores/app_state.dart';
import 'package:talkrr/utils/utils.dart';

class Meeting extends StatefulWidget {
  const Meeting({super.key});

  @override
  State<Meeting> createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final api _api = api();
  bool isLoading = true;
  List users = [];

  Future<void> fetchAllUsers() async {
    dynamic store = StoreProvider.of<AppState>(context);
    String AUTH_TOKEN = store.state.account.AUTH_TOKEN;
    if (!JwtDecoder.isExpired(AUTH_TOKEN)) {
      _api.getAllUsers(AUTH_TOKEN).then((response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          if (responseBody["success"]) {
            Map<String, dynamic> RESPONSE = responseBody["RESPONSE"];
            if (kDebugMode) {
              print(RESPONSE);
            }
            setState(() {
              users = RESPONSE["users"];
              isLoading = false;
            });
          }
        } else if (response.statusCode == 401) {
          showSnackBar(
              context, "Unauthorized::Session expired. Please login again!");
          store.dispatch(LogoutAction());
        } else if (response.statusCode == 403) {
          showSnackBar(
              context, "Unauthorized::Session expired. Please login again!");
          store.dispatch(LogoutAction());
        }
      });
    } else {
      showSnackBar(
          context, "Unauthorized::Session expired. Please login again!");
      store.dispatch(LogoutAction());
    }
  }

  Future<void> createEngine() async {
    WidgetsFlutterBinding.ensureInitialized();
    await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
      Constants.zegoAppId,
      ZegoScenario.Default,
      appSign: Constants.zegoAppSign,
    ));
  }

  Future<void> createMeeting() async {
    createEngine();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 0), () => fetchAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Call",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => createMeeting(),
                  child: Column(
                    children: [
                      Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color.fromRGBO(0, 65, 85, 1),
                        ),
                        child: const Icon(
                          Icons.people_sharp,
                          size: 30.0,
                          color: Color.fromRGBO(193, 194, 195, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        "New Meeting",
                        style: TextStyle(
                          color: Color.fromRGBO(193, 194, 195, 1),
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color.fromRGBO(2, 129, 170, 1),
                      ),
                      child: const Icon(
                        Icons.link_sharp,
                        size: 30.0,
                        color: Color.fromRGBO(193, 194, 195, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      "Join",
                      style: TextStyle(
                        color: Color.fromRGBO(193, 194, 195, 1),
                        fontSize: 17.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color.fromRGBO(0, 65, 85, 1),
                      ),
                      child: const Icon(
                        Icons.calendar_month_sharp,
                        size: 30.0,
                        color: Color.fromRGBO(193, 194, 195, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      "Schedule",
                      style: TextStyle(
                        color: Color.fromRGBO(193, 194, 195, 1),
                        fontSize: 17.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Text(
              "Users",
              style: GoogleFonts.montserrat(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: isLoading
                  ? const SpinKitThreeBounce(
                      duration: Duration(milliseconds: 600),
                      color: Colors.white,
                      size: 20.0,
                    )
                  : users.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: users
                                .map(
                                  (user) => Column(
                                    children: [
                                      ListTile(
                                        key: Key(user["userId"]),
                                        leading: const CircleAvatar(),
                                        title: Text(
                                          user["userFullName"],
                                          style: GoogleFonts.montserrat(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w600,
                                            color: const Color.fromRGBO(
                                                193, 194, 195, 1),
                                          ),
                                        ),
                                        onTap: () => {},
                                      ),
                                      const Divider(
                                        indent: 75.0,
                                        color: Color.fromRGBO(193, 194, 195, 1),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      : Center(
                          child: Text(
                            "Users not found!",
                            style: GoogleFonts.montserrat(
                              fontSize: 17.0,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromRGBO(193, 194, 195, 1),
                            ),
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
