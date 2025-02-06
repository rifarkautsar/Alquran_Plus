import 'package:flutter/material.dart';

class FolderDialog extends StatefulWidget {
  final Function(String) onFolderCreated;

  const FolderDialog({super.key, required this.onFolderCreated});

  @override
  FolderDialogState createState() => FolderDialogState();
}

class FolderDialogState extends State<FolderDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create New Folder"),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: 'Enter folder name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onFolderCreated(_controller.text);
              Navigator.pop(context);
            }
          },
          child: Text("Create"),
        ),
      ],
    );
  }
}
