import 'dart:convert';

import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/location.dart';
import 'package:carmoa/data/weather_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isWeatherCheck = true;

Widget buildTopWeather(BuildContext context) {
  final position = Provider.of<Location>(context);

  WeatherData weatherData = new WeatherData();

  return FutureBuilder<Size>(
      future: viewSize(Stream<Size>.periodic(
          Duration(milliseconds: 100), (x) => MediaQuery.of(context).size)),
      builder: (context, snapshot) {
        Size size = snapshot.data;
        return Container(
          width: size != null ? size.width * 0.9 : 0,
          height: 80,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(3.0, 3.0),
                  blurRadius: 6.0,
                  spreadRadius: 1),
              BoxShadow(
                  color: Color.fromRGBO(255, 252, 252, 1),
                  offset: Offset(-3.0, -3.0),
                  blurRadius: 6.0,
                  spreadRadius: 1),
            ],
          ),
          child: FutureBuilder(
              future: loadPreference(context),
              builder: (builder, snap) {
                if (snap.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      position.getIcon() != null
                          ? SvgPicture.asset(
                              'assets/weather/${position.getIcon()}.svg',
                              color: mainColor,
                              width: 50,
                              height: 50)
                          : Container(),
                      SizedBox(width: 10),
                      position.getTemp() != null
                          ? Text('${position.getTemp()}\u00B0',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  color: mainColor))
                          : Container(),
                      SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              position.getCity() != null
                                  ? Row(
                                      children: [
                                        Text('${position.getCity()}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: mainColor)),
                                        SizedBox(width: 10),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              // 현재 위치기반 날씨 데이터 가져오기
                                              getLocation(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Icon(
                                                  CupertinoIcons.location,
                                                  color: mainColor,
                                                  size: 20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Icon(FontAwesomeIcons.mapMarkerAlt,
                                      color: mainColor, size: 16)
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '${position.getId() != null ? weatherData.descriptionKR[position.getId()] : ''}',
                                style:
                                    TextStyle(fontSize: 15, color: mainColor),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        );
      });
}

Future<String> loadPreference(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String item = preferences.getString('location') ?? '37.5640455,126.834003';
  var data = item.split(',');

  // 프로그램 시작시 처음 한번만 실행
  if (isWeatherCheck) {
    isWeatherCheck = false;
    await getWeatherData(context: context, lat: data[0], lon: data[1]);
  }

  return item;
}

Future<void> savePreference(String location) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('location', location);
}

Future<void> getLocation(BuildContext context) async {
  var location = await Permission.location.status;
  try {
    if (!location.isGranted) {
      await Permission.location.request();
    }

    if (location.isGranted) {
      // var isGpsEnabled = await Geolocator.isLocationServiceEnabled();
      // locationCheck.setPosition(true);

      var location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      // name = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      String data = '${location.latitude},${location.longitude}';

      savePreference(data);
      getWeatherData(
          context: context,
          lat: location.latitude.toString(),
          lon: location.longitude.toString());
    }
    if (location.isDenied) {
      // 위치 권한 취소에 따른 안내 팝업창 생성 하기
      print('취소');
    }
  } catch (e) {
    print('예외처리: $e');
  }
}

Future<void> getWeatherData({
  @required BuildContext context,
  @required String lat,
  @required String lon,
}) async {
  WeatherData weatherData = new WeatherData();
  var id;
  var temp;
  var description;
  var city;
  var iconName;
  int index;

  var str =
      "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=kr&&appid=9a957a80e7504e2b62ef7cb70ce855ea";
  var response = await http.get(str);
  if (response.statusCode == 200) {
    var result = jsonDecode(response.body);
    if (result != null) {
      id = result['weather'][0]['id'];
      temp = result['main']['temp'];
      description = result['weather'][0]['description'];
      city = result['name'];
      iconName = result['weather'][0]['icon'];
    }
    // OpenWeather id 값 Text 변환
    for (int i = 0; i < weatherData.descriptionID.length; i++) {
      if (weatherData.descriptionID[i] == id) {
        index = i;
        break;
      }
    }
    if (iconName != null) {
      providerSave(context, lat, lon, index, temp, description, city, iconName);
    }
  } else {
    print('No Data');
  }
}

void providerSave(BuildContext context, String lat, String lon, int _id,
    var temp, var description, var city, var iconName) {
  double orgTemp = double.parse(temp.toString()) - 273.15;
  int _temp = orgTemp.round();

  var weatherProvider = Provider.of<Location>(context, listen: false);
  weatherProvider.setLocation(double.parse(lat), double.parse(lon));
  weatherProvider.setWeather(_temp, description, city, iconName, _id);
}
