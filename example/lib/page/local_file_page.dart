import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ijkplayer_example/page/loacl_play_page.dart';
import 'package:path_provider/path_provider.dart' as FileSystemUtil;

class LocalFilePage extends StatefulWidget {
  @override
  _LocalFilePageState createState() => _LocalFilePageState();
}

class _LocalFilePageState extends State<LocalFilePage> {
  String filePath = "";

  var _files = <FileSystemEntity>[];

  Widget _buildFileTile(ctx, index) {
    var item = _files[index];
    return ListTile(
      title: Text(item.path),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => LocalPlayPage(path: item.path)));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initPath();
  }

  void _initPath() async {
    Directory root;
    if (Platform.isIOS) {
      root = await FileSystemUtil.getApplicationDocumentsDirectory();
    } else {
      root = await FileSystemUtil.getExternalStorageDirectory();
    }
    print('路径为:' + root.path);
    var files = root.listSync();
    print(files);
    setState(() {
      files.forEach((f) {
        _files.add(f);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filePath),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: _buildFileTile,
        itemCount: _files.length,
      ),
    );
  }
}
