import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app/app_bloc.dart';
import '../../bloc/app/app_state.dart';
import '../../utils/take_photo_document_style.dart';
import '../widgets/button_take_photo.dart';

class TakePhotoDocumentPage extends StatelessWidget {
  final TakePhotoDocumentStyle takePhotoDocumentStyle;

  const TakePhotoDocumentPage({
    Key? key,
    required this.takePhotoDocumentStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, AppStatus>(
      selector: (state) => state.statusCamera,
      builder: (context, state) {
        switch (state) {
          case AppStatus.initial:
            return Container();

          case AppStatus.loading:
            return takePhotoDocumentStyle.onLoading;

          case AppStatus.success:
            return _CameraPreview(
              takePhotoDocumentStyle: takePhotoDocumentStyle,
            );

          case AppStatus.failure:
            return Container();
        }
      },
    );
  }
}

class _CameraPreview extends StatefulWidget {
  final TakePhotoDocumentStyle takePhotoDocumentStyle;

  const _CameraPreview({
    Key? key,
    required this.takePhotoDocumentStyle,
  }) : super(key: key);

  @override
  State<_CameraPreview> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<_CameraPreview> {
  bool isTorchOn = false;
  double zoomLevel = 1.0;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, CameraController?>(
      selector: (state) => state.cameraController,
      builder: (context, state) {
        if (state == null) {
          return const Center(
            child: Text(
              "No Camera",
            ),
          );
        }

        return Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              children: [
                // * Camera
                CameraPreview(state),

                // * children
                if (widget.takePhotoDocumentStyle.children != null)
                  ...widget.takePhotoDocumentStyle.children!,
                //
                /// Default
                const ButtonTakePhoto(),
              ],
            ),
            Positioned(
              top: 40,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (state.value.flashMode == FlashMode.off) {
                        state.setFlashMode(FlashMode.torch);
                        setState(() {
                          isTorchOn = true;
                        });
                      } else {
                        state.setFlashMode(FlashMode.off);
                        setState(() {
                          isTorchOn = false;
                        });
                      }
                    },
                    icon: Icon(
                      isTorchOn ? Icons.light_mode_outlined : Icons.light_mode,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      zoomLevel = await state.getMinZoomLevel();
                      if (zoomLevel < await state.getMaxZoomLevel()) {
                        zoomLevel += 1.0;
                        try {
                          state.setZoomLevel(zoomLevel);
                        } catch (e) {
                          print(e);
                        }
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.zoom_in,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (zoomLevel > await state.getMinZoomLevel()) {
                        zoomLevel -= 1.0;
                        state.setZoomLevel(zoomLevel);
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.zoom_out,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
