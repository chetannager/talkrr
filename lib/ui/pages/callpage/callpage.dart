import 'package:flutter/material.dart';
import 'package:talkrr/utils/constants.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatefulWidget {
  final String userId;
  final String userFullName;
  final String callId;

  const CallPage(this.userId, this.userFullName, this.callId, {super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: Constants.zegoAppId,
      appSign: Constants.zegoAppSign,
      userID: widget.userId,
      userName: widget.userFullName,
      callID: widget.callId,
      config: ZegoUIKitPrebuiltCallConfig(
        turnOnCameraWhenJoining: true,
      ),
    );
  }
}
