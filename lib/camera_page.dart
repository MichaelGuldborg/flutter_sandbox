import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snacker/camera_button.dart';

class CameraPage extends StatefulWidget {
  _CameraPageState createState() => _CameraPageState();
}

// TODO BUTTON BOUNCE EFFECT

class _CameraPageState extends State<CameraPage> with SingleTickerProviderStateMixin {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  int cameraIndex;
  String path;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera({int index = 0}) async {
    cameraIndex = index;
    final cameras = await availableCameras();
    final camera = cameras[index];

    _controller = CameraController(camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void handleOnPressed() async {
    try {
      print("TAKE PICTURE");
      await _initializeControllerFuture;
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      await _controller.takePicture(path);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onDoubleTap: () async {
              initCamera(index: (cameraIndex - 1) % 2);
            },
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return false ? Container(color: Colors.cyan) : CameraPreview(_controller);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      null,
                    ),
                    onPressed: () {},
                  ),
                  CameraButton(
                    onPressed: handleOnPressed,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.folder,
                      color: Colors.white,
                      size: 40,
                    ),
                    splashColor: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/gallery');
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
