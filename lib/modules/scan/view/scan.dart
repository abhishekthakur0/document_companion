import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../scanner/document_scanner_controller.dart';
import '../../scanner/ui/pages/document_scanner.dart';
import '../../scanner/utils/crop_photo_document_style.dart';
import '../../scanner/utils/general_styles.dart';

class Scan extends StatefulWidget {
  static const String route = '/scan';
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final _controller = DocumentScannerController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DocumentScanner(
        controller: _controller,
        generalStyles: const GeneralStyles(
          baseColor: Colors.black,
          hideDefaultDialogs: true,
        ),
        cropPhotoDocumentStyle: CropPhotoDocumentStyle(
          top: MediaQuery.of(context).padding.top,
        ),
        resolutionCamera: ResolutionPreset.ultraHigh,
        onSave: (Uint8List imageBytes) {
          print("HIIIII");
          // ? Bytes of the document/image already processed
        },
      ),
    );
  }
}
