import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkrr/utils/constants.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class Meeting extends StatefulWidget {
  const Meeting({super.key});

  @override
  State<Meeting> createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meeting",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => createMeeting(),
              child: Container(
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
            ),
            Container(
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
            Container(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
