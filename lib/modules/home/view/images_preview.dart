import 'dart:typed_data';

import 'package:document_companion/local_database/models/current_image.dart';
import 'package:document_companion/modules/home/bloc/current_image_bloc.dart';
import 'package:flutter/material.dart';

import '../../../config/custom_colors.dart';

class ImagesPreview extends StatefulWidget {
  static const route = '/images_preview';
  const ImagesPreview({Key? key}) : super(key: key);

  @override
  State<ImagesPreview> createState() => _ImagesPreviewState();
}

class _ImagesPreviewState extends State<ImagesPreview> {
  PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    currentImageBloc.getCurrentImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<CurrentImage>>(
        stream: currentImageBloc.currentImageStream,
        builder: (context, AsyncSnapshot<List<CurrentImage>> snapshot) {
          final list = snapshot.data;
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: list?.length ?? 0,
                  controller: _pageController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final imageData = list?.elementAt(index);
                    return Image.memory(
                      imageData?.image ?? Uint8List(0),
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                color: CustomColors.white,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      icon: Icon(
                        Icons.skip_previous,
                      ),
                    ),
                    Text('1'),
                    IconButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      icon: Icon(
                        Icons.skip_next,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {},
                      icon: Icon(
                        Icons.close,
                        color: CustomColors.white,
                      ),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: CustomColors.white,
                      ),
                      onPressed: () {},
                      label: Text(
                        'Create PDF',
                      ),
                      icon: Icon(
                        Icons.picture_as_pdf,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
