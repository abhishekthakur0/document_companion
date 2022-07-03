import 'dart:typed_data';

import 'package:document_companion/local_database/models/current_image.dart';
import 'package:document_companion/modules/home/bloc/current_image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/custom_colors.dart';
import '../../../home/view/images_preview.dart';
import '../../document_scanner_controller.dart';

class ButtonTakePhoto extends StatelessWidget {
  final bool hide;

  const ButtonTakePhoto({
    Key? key,
    this.hide = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hide) {
      return Container();
    }

    return Container(
      height: 120,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<List<CurrentImage>>(
                  stream: currentImageBloc.currentImageStream,
                  builder:
                      (context, AsyncSnapshot<List<CurrentImage>> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 100,
                          width: 80,
                          decoration: BoxDecoration(
                            color: CustomColors.black,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: CustomColors.white,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              snapshot.data?.last.image ?? Uint8List(0),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: CustomColors.white,
                            child: Text(
                              (snapshot.data?.length ?? 0).toString(),
                              style: TextStyle(
                                color: CustomColors.black,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ImagesPreview.route,
                  );
                },
                icon: Icon(
                  Icons.next_week_outlined,
                  size: 30,
                  color: CustomColors.leatherJacket,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () => context.read<DocumentScannerController>().takePhoto(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: CustomColors.leatherJacket,
                ),
              ),
              child: Icon(
                Icons.lens_blur_outlined,
                size: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
