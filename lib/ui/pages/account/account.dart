import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:talkrr/core/redux/actions/account_actions.dart';
import 'package:talkrr/core/redux/stores/app_state.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  void logout() {
    Store store = StoreProvider.of<AppState>(context);
    store.dispatch(LogoutAction());
    Navigator.pushNamedAndRemoveUntil(
        context, "/login", (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) => store.state,
      builder: (context, state) {
        dynamic account = state.account;
        Map<String, dynamic> userDetails = account.userDetails;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Account",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: "profile_picture",
                          child: CircleAvatar(
                            maxRadius: 50,
                            backgroundColor: Colors.grey[200],
                            // backgroundImage:
                            //     const AssetImage(Images.USER_AVATAR),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${userDetails["userFullName"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                                fontFamily: 'Montserrat',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${userDetails["userEmailAddress"]}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 3.0),
                              child: GestureDetector(
                                // onTap: () => Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         const EditProfile(),
                                //   ),
                                // ),
                                child: const Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings_power_outlined,
                      color: Colors.red,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18.0,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () => showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Attention!',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 19.0,
                          ),
                        ),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                'Are you sure you want to logout of this app?',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            onPressed: () => logout(),
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(height: 25.0),
                  // const HowCanWeHelpYou(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
