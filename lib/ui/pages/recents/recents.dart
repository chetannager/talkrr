import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:talkrr/ui/pages/joinmeeting/joinmeeting.dart';
import 'package:talkrr/ui/pages/newmeeting/newmeeting.dart';
import 'package:talkrr/core/providers/api.dart';
import 'package:talkrr/core/redux/actions/account_actions.dart';
import 'package:talkrr/core/redux/stores/app_state.dart';
import 'package:talkrr/utils/utils.dart';

class Recents extends StatefulWidget {
  const Recents({super.key});

  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  final api _api = api();
  bool isLoading = true;
  List recentCalls = [];

  Future<void> getAllRecentCalls() async {
    dynamic store = StoreProvider.of<AppState>(context);
    String AUTH_TOKEN = store.state.account.AUTH_TOKEN;
    if (!JwtDecoder.isExpired(AUTH_TOKEN)) {
      _api.getAllCalls(AUTH_TOKEN).then((response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          Map<String, dynamic> RESPONSE = responseBody["RESPONSE"];
          if (kDebugMode) {
            print(RESPONSE);
          }
          setState(() {
            recentCalls = RESPONSE["recentCalls"];
            isLoading = false;
          });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 0), () => getAllRecentCalls());
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) => store.state,
      builder: (context, state) {
        dynamic account = state.account;
        Map<String, dynamic> userDetails = account.userDetails;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Talkrr",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewMeeting())),
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
                    const SizedBox(width: 80.0),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JoinMeeting())),
                      child: Column(
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
                    ),
                    // Column(
                    //   children: [
                    //     Container(
                    //       height: 80.0,
                    //       width: 80.0,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15.0),
                    //         color: const Color.fromRGBO(0, 65, 85, 1),
                    //       ),
                    //       child: const Icon(
                    //         Icons.calendar_month_sharp,
                    //         size: 30.0,
                    //         color: Color.fromRGBO(193, 194, 195, 1),
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       height: 15.0,
                    //     ),
                    //     const Text(
                    //       "Schedule",
                    //       style: TextStyle(
                    //         color: Color.fromRGBO(193, 194, 195, 1),
                    //         fontSize: 17.0,
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text(
                  "Recent Calls",
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
                      : recentCalls.isNotEmpty
                          ? SingleChildScrollView(
                              child: Column(
                                children: recentCalls
                                    .map(
                                      (call) => Column(
                                        children: [
                                          ListTile(
                                            key: Key(call["call_id"]),
                                            leading: ProfilePicture(
                                              name: call["sender_id"] !=
                                                      userDetails["userId"]
                                                  ? call["sender_full_name"]
                                                      .toString()
                                                  : call["receiver_id"] !=
                                                          userDetails["userId"]
                                                      ? call["receiver_full_name"]
                                                          .toString()
                                                      : "",
                                              radius: 25,
                                              fontsize: 28,
                                            ),
                                            title: Text(
                                              call["sender_id"] !=
                                                      userDetails["userId"]
                                                  ? call["sender_full_name"]
                                                      .toString()
                                                  : call["receiver_id"] !=
                                                          userDetails["userId"]
                                                      ? call["receiver_full_name"]
                                                          .toString()
                                                      : "",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                color: const Color.fromRGBO(
                                                    193, 194, 195, 1),
                                              ),
                                            ),
                                            subtitle: Text(
                                              call["call_at"].toString(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
                                                color: const Color.fromRGBO(
                                                    193, 194, 195, 1),
                                              ),
                                            ),
                                            trailing: Icon(
                                              call["sender_id"] ==
                                                      userDetails["userId"]
                                                  ? Icons.call_made_sharp
                                                  : call["receiver_id"] ==
                                                          userDetails["userId"]
                                                      ? Icons
                                                          .call_received_rounded
                                                      : Icons.call,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Divider(
                                            indent: 75.0,
                                            color: Color.fromRGBO(
                                                193, 194, 195, 1),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          : Center(
                              child: Text(
                                "No calls found!",
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
      },
    );
  }
}
