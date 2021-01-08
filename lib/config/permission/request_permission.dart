import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermission extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static var routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('권한설정'),
            onPressed: () async {
              if (await checkPermissionGranted()) {
                SnackBar snackBar = SnackBar(content: Text('권한설정 완료'));
                _key.currentState.showSnackBar(snackBar);
              } else {
                SnackBar snackBar = SnackBar(content: Text('권한설정 완료'), action: SnackBarAction(
                  label: '권한설정 확인',
                  onPressed: () {
                    _key.currentState.hideCurrentSnackBar();
                    AppSettings.openAppSettings();
                  },
                ),);
                _key.currentState.showSnackBar(snackBar);
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<bool> checkPermissionGranted() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
  ].request();

  bool permitted = true;

  statuses.forEach((permission, permissionStatus) {
    if (!permissionStatus.isGranted) permitted = false;
  });

  print('권한설정 : ${statuses[Permission.location]}');

  return permitted;
}
