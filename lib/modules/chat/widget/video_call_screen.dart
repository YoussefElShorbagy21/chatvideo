import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../shared/components/constants.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late int _remoteUid = 0;
  RtcEngine engine =createAgoraRtcEngine();

  @override
  void initState() {
    initAgora();
    super.initState();
  }

/*  @override
  dispose() {
    engine.leaveChannel();
    super.dispose();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150.0),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: _renderLocalVideo(),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only( bottom: 25.0,right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 IconButton(
                   onPressed: (){
                     Navigator.pop(context);
                   },
                   icon: const Icon(
                      Icons.call_end,
                      color: Colors.redAccent,
                      size: 44,
                   ),
                 ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initAgora() async {
    await [Permission.camera, Permission.microphone].request();
    engine = createAgoraRtcEngine();
    await engine.initialize( RtcEngineContext(appId: appID,
    channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    engine.enableVideo();
    engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = 0;
            Navigator.pop(context);
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await engine.joinChannel(
      token: tempToken,
      channelId: channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
            rtcEngine: engine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection:  RtcConnection(channelId: channelName),

        ),
      );
    }else{
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _renderLocalVideo() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: engine,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }
}
