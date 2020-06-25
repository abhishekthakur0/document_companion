import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:images_to_pdf/images_to_pdf.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simplescanner/takepicturescreen.dart';
import 'package:printing/printing.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static List<StorageInfo> _storageInfo = [];
  var firstCamera;
  Directory _photoDir;
  //Pdf Generating Variables
  File _pdfFile;
  String _status = "Not created";
  FileStat _pdfStat;
  bool _generating = false;

  _HomepageState();

  @override
  void initState() {
    initPlatformState();
    chooseCamera();
    _permissionCheck = (() async {
      bool hasPermission = await isPermissionGranted(Permission.storage);
      if (!hasPermission) {
        hasPermission = await requestPermission(Permission.storage);
      }
      return hasPermission;
    })();
    super.initState();
  }

  Future<File> _assetFromBundle(String name) async {
    final output = File(path.join(_photoDir.path, name));

    if (!await output.exists()) {
      final data = await rootBundle.load('$name');
      final buffer = data.buffer;
      output.writeAsBytes(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    }
    return output;
  }

  Future<void> _createPdf() async {
    try {
      this.setState(() => _generating = true);
      //final tempDir = await getApplicationDocumentsDirectory();
      final output = File(path.join(_photoDir.path, 'YourPdf.pdf'));
      //print(output);
      this.setState(() => _status = 'Preparing images...');
      List imagesList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".png"))
          .toList(growable: true);
      List images = [];
      for (int i = 0; i < imagesList.length; i++) {
        int maxleng = imagesList[i].length;
        images.add(await _assetFromBundle(
            imagesList[i].toString().substring(36, maxleng)));
      }
      this.setState(() => _status = 'Generating PDF');
      await ImagesToPdf.createPdf(
        pages: images
            .map(
              (file) => PdfPage(
                imageFile: file,
                size: Size(1240, 1754),
                compressionQuality: 0.5,
              ),
            )
            .toList(),
        output: output,
      );
      _pdfStat = await output.stat();
      this.setState(() {
        _pdfFile = output;
        _status = 'PDF Generated (${_pdfStat.size ~/ 1024}kb)';
      });
    } catch (e) {
      this.setState(() => _status = 'Failed to generate pdf: $e".');
    } finally {
      this.setState(() => _generating = false);
    }
    print(_status);
  }

  Future<void> _openPdf() async {
    if (_pdfFile != null) {
      try {
        final bytes = await _pdfFile.readAsBytes();
        await Printing.sharePdf(
            bytes: bytes, filename: path.basename(_pdfFile.path));
      } catch (e) {
        _status = 'Failed to open pdf: $e".';
      }
    }
  }

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
      _photoDir = Directory(_storageInfo[0].rootDir + '/MyCreatedFolder');
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Simple Scanner'),
            centerTitle: true,
            backgroundColor: Colors.black,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.print,
                  color: Colors.white,
                ),
                onPressed: () {
                  _createPdf();
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    _showMyDialog();
                  });
                },
              )
            ],
          ),
          body: Center(
            child: FutureBuilder(
              future: _permissionCheck,
              builder: (context, status) {
                if (status.connectionState == ConnectionState.done) {
                  if (status.data) {
                    //print("Permission was granted");
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
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          height: 50,
          width: 100,
          child: AlertDialog(
            title: Text(_status),
            actions: <Widget>[
              FlatButton(
                child: Text('Open Pdf'),
                onPressed: () {
                  _openPdf();
                },
              ),
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ImageGrid extends StatelessWidget {
  final Directory directory;

  const ImageGrid({Key key, this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Stopwatch watch = new Stopwatch()..start();
    var imageList = directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".png"))
        .toList(growable: true);
    //print(imageList);
    //print("Time to load: ${watch.elapsed}, Image list: $imageList");
    return GridView.builder(
      itemCount: imageList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 4.0 / 3.0),
      itemBuilder: (context, index) {
        //print("Loading image with index $index");
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
