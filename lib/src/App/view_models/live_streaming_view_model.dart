import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LiveStreamingViewModel extends ChangeNotifier {
  WebSocketChannel? channel;
  String serverAddress = "ws://192.168.1.20:8080";
  String cameraNum = "1";

  connect() async {
    final serverUri = Uri.parse(serverAddress).replace(queryParameters: {
      "cameraNum": cameraNum,
    });

    channel = WebSocketChannel.connect(serverUri);
    print("Connected to server");
    channel!.sink.add("Hola");
  }

  void sendImageToServer(CameraImage image) async {
    if (channel == null) {
      print("Channel is null");
      return;
    }

    image.planes.map((plane) {
      // Bytes to Base64
      // return base64Encode(plane.bytes);
      return plane.bytes;
    }).forEach((element) {

      channel!.sink.add(element);
    });
  }
}
