import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkrr/core/providers/api.dart';
import 'package:talkrr/ui/pages/callpage/callpage.dart';
import 'package:talkrr/utils/colors.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({super.key});

  @override
  State<JoinMeeting> createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  final api _api = api();
  final TextEditingController meetingIdController = TextEditingController();
  bool isLoading = true;
  List users = [];

  Future<void> joinMeeting() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(meetingIdController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildMeetingIdTextField() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: meetingIdController,
              cursorColor: Colors.white,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Example: 8554-4e30-812a",
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: kInputColor.withOpacity(0.6),
                ),
                disabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kInputColor,
                  ),
                ),
                border: const UnderlineInputBorder(
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

    Widget _buildJoinBtn() {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          elevation: 0.0,
          highlightElevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          color: kButtonColor,
          disabledColor: kButtonColor,
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          onPressed: () => joinMeeting(),
          child: const Text(
            "Join",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Join Meeting",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(
          children: [
            const Text(
              "Enter the code provided by the meeting organiser",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: kInputColor,
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            _buildMeetingIdTextField(),
            const SizedBox(
              height: 35.0,
            ),
            _buildJoinBtn(),
          ],
        ),
      ),
    );
  }
}
