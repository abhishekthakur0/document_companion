import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simplescanner/takepicturescreen.dart';

final Directory _photoDir =
    new Directory('/storage/emulated/0/MyCreatedFolder');

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var firstCamera;

  Future<void> chooseCamera() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();
    // Get a specific camera from the list of available cameras.
    firstCamera = cameras.first;
  }

  Future<bool> _permissionCheck;

  Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  Future<bool> requestPermission(Permission permission) async {
    await permission.request();
    return true;
  }

  @override
  void initState() {
    chooseCamera();
    super.initState();
    _permissionCheck = (() async {
      bool hasPermission = await isPermissionGranted(Permission.storage);
      if (!hasPermission) {
        hasPermission = await requestPermission(Permission.storage);
      }
      return hasPermission;
    })();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Scanner'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: FutureBuilder(
            future: _permissionCheck,
            builder: (context, status) {
              if (status.connectionState == ConnectionState.done) {
                if (status.data) {
                  print("Permission was granted");
                  return ImageGrid(directory: _photoDir);
                } else {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                            "Read permission was denied, so can't read pictures. Try again by pressing below."),
                        FlatButton(
                          child: Text("Request Permission"),
                          onPressed: () {
                            setState(() {
                              _permissionCheck =
                                  requestPermission(Permission.storage);
                            });
                          },
                        )
                      ],
                    ),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.camera_alt),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TakePictureScreen(
                  camera: firstCamera,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ImageGrid extends StatelessWidget {
  final Directory directory;

  const ImageGrid({Key key, this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stopwatch watch = new Stopwatch()..start();
    var imageList = directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".png"))
        .toList(growable: true);
    print("Time to load: ${watch.elapsed}, Image list: $imageList");
    return GridView.builder(
      itemCount: imageList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 4.0 / 3.0),
      itemBuilder: (context, index) {
        print("Loading image with index $index");
        return Card(
          color: Colors.transparent,
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: FileImage(
                  File(imageList[index]),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
