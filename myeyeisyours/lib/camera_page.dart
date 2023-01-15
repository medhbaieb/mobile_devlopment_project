import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? pictureFile;
//this function will check if there are any cameras mounted into the device before loding the page.
  //the camera controller will then use the first camera it finds as the default camera.
  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: 600,
                width: 300,
                //camerapreview is a widget that always you to show what the camera is depicting
                child: CameraPreview(controller),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                pictureFile = await controller.takePicture();
                //this button here will take the image from the controller to get it into file.
                //this file will then be encoded into bytes then into a string to be later send to the database
                final bytes = await File(pictureFile!.path).readAsBytes();
                String string_image = base64Encode(bytes);

                print(string_image);
                setState(() {});
              },
              child: const Text('Capture Image'),
            ),
          ),
          if (pictureFile != null)
            Image.network(
              pictureFile!.path,
              height: 200,
            )
        ],
      ),
    );
  }
}
