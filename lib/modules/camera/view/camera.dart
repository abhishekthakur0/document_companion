// A screen that allows users to take a picture using a given camera.
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' show join;
import 'package:permission_handler/permission_handler.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  List<StorageInfo> _storageInfo = [];
  bool _isOn = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> initPlatformState() async {
    List<StorageInfo> storageInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      storageInfo = await PathProviderEx.getStorageInfo();
    } on PlatformException {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _storageInfo = storageInfo;
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<void> requestPermission(Permission permission) async {
    await permission.request();
  }

  Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  Future<String> get _localPath async {
    requestPermission(Permission.storage);
    bool storage = await isPermissionGranted(Permission.storage);

    if (storage) {
      final directory =
          await Directory(_storageInfo[0].rootDir + '/MySimpleScanner');

      return directory.path;
    } else {
      print("Permission not granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take a picture'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isOn ? Icons.flash_off : Icons.flash_on),
            onPressed: () {},
          ),
        ],
      ),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 10.0, left: 30.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(Icons.camera_alt),
            // Provide an onPressed callback.
            onPressed: () async {
              // Take the Picture in a try / catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;

                // Construct the path where the image should be saved using the
                // pattern package.
                final path = join(
                  // Store the picture in the temp directory.
                  // Find the temp directory using the `path_provider` plugin.
                  (await _localPath),
                  '${(new DateTime.now()).millisecondsSinceEpoch}.png',
                );
                print(path);
                // Attempt to take a picture and log where it's been saved.
                await _controller.takePicture();

                // If the picture was taken, display it on a new screen.
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(imagePath: path),
                  ),
                );
              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
          ),
        ),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Clicked Picture'),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              print("Discard clicked");
              print(imagePath);
              Future deleted = Directory(imagePath).delete(recursive: true);
              deleted.then((value) {
                //print(value);
                Navigator.pushReplacementNamed(context, '/');
              });
            },
          )),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: <Widget>[
          Image.file(File(imagePath)),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.clear),
                    Text("Discard"),
                  ],
                ),
                onPressed: () {
                  print("Discard clicked");
                  Future deleted = Directory(imagePath).delete(recursive: true);
                  deleted.then((value) {
                    print(value);
                    Navigator.pushReplacementNamed(context, '/');
                  });
                },
              ),
              RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.check),
                    Text("Accept"),
                  ],
                ),
                onPressed: () {
                  print("Accept Clicked");
                  Navigator.pushReplacementNamed(context, '/');
                },
              )
            ],
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
