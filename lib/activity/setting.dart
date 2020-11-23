import 'dart:io';

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
    return Container(
      padding: EdgeInsets.all(8),
      child: SafeArea(
        child: Column(
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
    );
  }

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await piker.getImage(source: imageSource);

    setState(() {
      _image = File(pickedFile.path);
      print('경로 ' + pickedFile.path);
      // _image = Image.file(File(pickedFile.path)) as File;
    });
  }

  Widget showImage() {
    if (_image == null)
      return Container();
    else
      return Image.file(_image);
  }
}
