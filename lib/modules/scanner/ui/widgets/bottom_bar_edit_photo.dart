import 'package:document_companion/config/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../document_scanner_controller.dart';
import '../../models/filter_type.dart';
import '../../utils/edit_photo_document_style.dart';

class BottomBarEditPhoto extends StatelessWidget {
  final EditPhotoDocumentStyle editPhotoDocumentStyle;

  const BottomBarEditPhoto({
    Key? key,
    required this.editPhotoDocumentStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editPhotoDocumentStyle.hideBottomBarDefault) return Container();

    return Positioned(
      bottom: 50,
      left: 10,
      right: 10,
      child: StreamBuilder(
          stream: context.read<DocumentScannerController>().currentFilterType,
          builder: (context, AsyncSnapshot<FilterType> snapshot) {
            return Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () =>
                        context.read<DocumentScannerController>().applyFilter(
                              FilterType.natural,
                            ),
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: snapshot.data?.index == 0
                            ? CustomColors.leatherJacket
                            : CustomColors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.nature_people_outlined,
                            color: CustomColors.leatherJacket,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Natural',
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.leatherJacket,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        context.read<DocumentScannerController>().applyFilter(
                              FilterType.gray,
                            ),
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: snapshot.data?.index == 1
                            ? CustomColors.leatherJacket
                            : CustomColors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.nature_people_outlined,
                            color: CustomColors.leatherJacket,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Gray',
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.leatherJacket,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        context.read<DocumentScannerController>().applyFilter(
                              FilterType.eco,
                            ),
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: snapshot.data?.index == 2
                            ? CustomColors.leatherJacket
                            : CustomColors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.nature_people_outlined,
                            color: CustomColors.leatherJacket,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Eco',
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.leatherJacket,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
