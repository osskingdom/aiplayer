import 'package:flutter/material.dart';

class FolderListItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final IconData icon;

  const FolderListItem({
    Key? key,
    required this.title,
    this.onTap,
    this.icon = Icons.folder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
