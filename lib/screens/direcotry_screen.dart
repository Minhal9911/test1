import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({Key? key}) : super(key: key);

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  List<String> dirs = [];

  void printDirectoryContents(String path, [String parentFolder = '']) {
    final directory = Directory(path);
    final List<FileSystemEntity> entities = directory.listSync();

    for (var entity in entities) {
      if (entity is File) {
        String path = '$parentFolder - ${entity.path.split('/').last}';
        dirs.add(path);
      } else if (entity is Directory) {
        final folderName = entity.path.split('/').last;
        printDirectoryContents(entity.path, '$parentFolder - $folderName');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directory'),
      ),
      body: ListView.builder(
        itemCount: dirs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(dirs[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //final path = Directory.current.path; // Replace with the path to the root folder
          Directory? appDocDir = await getApplicationDocumentsDirectory();
          String appDocPath = appDocDir.path;
          debugPrint('cp: $appDocPath');
          dirs.clear(); // Replace with the path to the root folder
          printDirectoryContents(appDocPath);
          setState(() {});
        },
        child: const Icon(Icons.folder_copy),
      ),
    );
  }
}
