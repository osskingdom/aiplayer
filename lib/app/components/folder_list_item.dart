import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'file_list_view.dart';

class FolderListItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final IconData icon;
  final bool isVideo;

  const FolderListItem({
    super.key,
    required this.title,
    this.onTap,
    this.icon = Icons.folder,
    this.isVideo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap ?? () {
          Get.to(() => FileListView(
            folderName: title,
            files: List.generate(10, (index) => 
              '${isVideo ? 'Video' : 'Audio'} File ${index + 1}.${isVideo ? 'mp4' : 'mp3'}'
            ),
          ));
        },
      ),
    );
  }
}
