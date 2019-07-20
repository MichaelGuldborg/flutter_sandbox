

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GalleryPage extends StatefulWidget {
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> _filePaths = List();
  List<File> _files = List();

  @override
  void initState() {
    super.initState();
    initFiles();
  }

  void initFiles() async {
    String path = (await getTemporaryDirectory()).path;
    Directory dir = new Directory(path);
    List<FileSystemEntity> fileEntities = dir.listSync();
    final filePaths = fileEntities.map((f) => f.path).toList();
    setState(() {
      _filePaths = filePaths;
    });
  }

  get filePathWidgets => _filePaths.map((file) => Text(file)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        children: filePathWidgets,
      ),
    );
  }

}
