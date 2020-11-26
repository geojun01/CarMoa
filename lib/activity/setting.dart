import 'dart:io';

import 'package:carmoa/config/config_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final piker = ImagePicker();
  File _image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                color: Colors.lightBlueAccent,
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: Text('사진 찍기'),
              ),
              FlatButton(
                color: Colors.lightBlueAccent,
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Text('갤러리 열기'),
              ),
              showImage(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await piker.getImage(source: imageSource);

    setState(() {
      _image = File(pickedFile.path);
      Styles.imagePath = _image;
    });
  }

  Widget showImage() {
    if (Styles.imagePath == null)
      return Container();
    else
      return Image.file(Styles.imagePath);
  }
}
