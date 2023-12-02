import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:talkrr/utils/constants.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:talkrr/core/redux/stores/app_state.dart';

class CallPage extends StatefulWidget {
  final String callId;

  const CallPage(this.callId, {super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) => store.state,
      builder: (context, state) {
        dynamic account = state.account;
        Map<String, dynamic> userDetails = account.userDetails;
        return ZegoUIKitPrebuiltCall(
          appID: Constants.zegoAppId,
          appSign: Constants.zegoAppSign,
          userID: userDetails["userId"],
          userName: userDetails["userFullName"],
          callID: widget.callId,
          config: ZegoUIKitPrebuiltCallConfig(
            turnOnCameraWhenJoining: true,
          ),
        );
      },
    );
  }
}
