import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:ijkplayer_example/i18n/i18n.dart';
import 'package:ijkplayer_example/utils/options_utils.dart';

class LocalPlayPage extends StatefulWidget {
  final String path;

  const LocalPlayPage({Key key, this.path}) : super(key: key);
  @override
  _LocalPlayPageState createState() => _LocalPlayPageState();
}

class _LocalPlayPageState extends State<LocalPlayPage> {
  IjkMediaController mediaController = IjkMediaController();

  @override
  void initState() {
    super.initState();
    OptionUtils.addDefaultOptions(mediaController);
    _playInput();
  }

  void _playInput() async {
    await mediaController.setFileDataSource(
      File(widget.path),
      autoPlay: true,
    );
  }

  @override
  void dispose() {
    mediaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentI18n.networkButton),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 400,
            child: IjkPlayer(
              mediaController: mediaController,
            ),
          ),
        ],
      ),
    );
  }
}
