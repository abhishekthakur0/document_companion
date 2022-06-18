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

class _CameraPreview extends StatelessWidget {
  final TakePhotoDocumentStyle takePhotoDocumentStyle;

  const _CameraPreview({
    Key? key,
    required this.takePhotoDocumentStyle,
  }) : super(key: key);

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

        return Column(
          // fit: StackFit.loose,
          // alignment: Alignment.bottomCenter,
          children: [
            // * Camera
            CameraPreview(state),

            // * children
            if (takePhotoDocumentStyle.children != null)
              ...takePhotoDocumentStyle.children!,
            //
            /// Default
            const ButtonTakePhoto(),
          ],
        );
      },
    );
  }
}
