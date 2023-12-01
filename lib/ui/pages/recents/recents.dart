import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkrr/utils/colors.dart';

class Recents extends StatefulWidget {
  const Recents({super.key});

  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  bool isLoading = true;
  List recentCalls = [
    {
      "userId": "3749976349nd4585d",
      "userFullName": "Siddharth Kumar",
      "callAt": "Dec 02, 05:30 PM"
    },
    {
      "userId": "3749976349nd4585d",
      "userFullName": "Manish Nagar",
      "callAt": "Nov 26, 02:00 AM"
    }
  ];

  Future<void> getAllRecentCalls() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllRecentCalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recents",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading
          ? const SpinKitThreeBounce(
              duration: Duration(milliseconds: 600),
              color: Colors.white,
              size: 20.0,
            )
          : recentCalls.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://cdni.iconscout.com/illustration/premium/thumb/no-video-found-9633767-7882958.png",
                        width: 250,
                      ),
                      Text(
                        "No calls found!",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.6,
                          fontSize: 18.0,
                          color: kTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: recentCalls
                        .map(
                          (call) => ListTile(
                            leading: const CircleAvatar(),
                            title: Text(call["userFullName"]),
                            subtitle: Text(call["callAt"]),
                            trailing: IconButton(
                              onPressed: () => {},
                              icon: const Icon(
                                Icons.video_call,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
    );
  }
}
