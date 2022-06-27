import 'package:document_companion/config/custom_colors.dart';
import 'package:document_companion/modules/home/bloc/folder_bloc.dart';
import 'package:document_companion/modules/home/models/folder_view_model.dart';
import 'package:document_companion/modules/home/view/create_bottom_modal_sheet.dart';
import 'package:document_companion/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  static const String route = '/homepage';
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    folderBloc.fetchFolders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.view_list,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            builder: (context) => CreateBottomModalSheet(),
          );
        },
        isExtended: true,
        backgroundColor: CustomColors.leatherJacket,
        icon: Icon(Icons.add),
        label: Text("Create"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 110,
            child: ListView.separated(
              padding: EdgeInsets.all(20),
              itemCount: Constant.availableServices.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: CustomColors.white,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Constant.availableServices[index].operationIcon,
                        color: CustomColors.white,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        Constant.availableServices[index].title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: CustomColors.white,
                            ),
                      )
                    ],
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: 10,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    10.0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.sort,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.filter_list_sharp,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: StreamBuilder<List<FolderViewModel>>(
                      stream: folderBloc.folderList,
                      builder: (context,
                          AsyncSnapshot<List<FolderViewModel>> snapshot) {
                        if (snapshot.hasData) {
                          final folders = snapshot.data;
                          if (folders?.isEmpty ?? true) {
                            return const Center(
                              child: Text('No folders yet'),
                            );
                          }
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Wrap(
                              children: List.generate(
                                folders?.length ?? 0,
                                (index) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.folder,
                                      size: 180,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        folders?.elementAt(index).folder_name ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
