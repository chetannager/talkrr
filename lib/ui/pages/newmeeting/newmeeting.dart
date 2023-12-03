import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:talkrr/core/providers/api.dart';
import 'package:talkrr/core/redux/actions/account_actions.dart';
import 'package:talkrr/core/redux/stores/app_state.dart';
import 'package:talkrr/utils/utils.dart';
import 'package:talkrr/ui/pages/callpage/callpage.dart';

class NewMeeting extends StatefulWidget {
  const NewMeeting({super.key});

  @override
  State<NewMeeting> createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  final api _api = api();
  bool isLoading = true;
  bool isProcessing = false;
  String userId = "";
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

  Future<void> createCall(receiverId, receiverFullName) async {
    setState(() {
      isProcessing = true;
      userId = receiverId;
    });
    dynamic store = StoreProvider.of<AppState>(context);
    String AUTH_TOKEN = store.state.account.AUTH_TOKEN;
    if (!JwtDecoder.isExpired(AUTH_TOKEN)) {
      await _api
          .createCall(AUTH_TOKEN, receiverId, receiverFullName)
          .then((dynamic response) async {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          Map<String, dynamic> RESPONSE = data['RESPONSE'];
          if (kDebugMode) {
            print(RESPONSE);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallPage(RESPONSE["callId"]),
            ),
          );
        } else if (response.statusCode == 400) {
          final Map<String, dynamic> data = json.decode(response.body);
          Map<String, dynamic> RESPONSE = data['RESPONSE'];
          if (kDebugMode) {
            print(RESPONSE);
          }
          showSnackBar(context, RESPONSE["error_message"]);
        } else {
          showSnackBar(
              context, "Something went wrong. Please try again later.");
        }
        setState(() {
          isProcessing = false;
        });
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
    Future.delayed(const Duration(seconds: 0), () => fetchAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Meeting",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
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
                                  leading: ProfilePicture(
                                    name: user["userFullName"],
                                    radius: 31,
                                    fontsize: 18,
                                  ),
                                  title: Text(
                                    user["userFullName"],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(
                                          193, 194, 195, 1),
                                    ),
                                  ),
                                  subtitle: Text(
                                    user["userEmailAddress"],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromRGBO(
                                          193, 194, 195, 1),
                                    ),
                                  ),
                                  trailing: MaterialButton(
                                    onPressed: isProcessing
                                        ? null
                                        : () => createCall(user["userId"],
                                            user["userFullName"]),
                                    child: isProcessing
                                        ? user["userId"] == userId
                                            ? const SizedBox(
                                                width: 30.0,
                                                child: SpinKitThreeBounce(
                                                  duration: Duration(
                                                      milliseconds: 800),
                                                  color: Colors.white,
                                                  size: 20.0,
                                                ),
                                              )
                                            : const Icon(
                                                Icons.video_call_sharp,
                                                color: Colors.white,
                                              )
                                        : const Icon(
                                            Icons.video_call_sharp,
                                            color: Colors.white,
                                          ),
                                  ),
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
      ),
    );
  }
}
