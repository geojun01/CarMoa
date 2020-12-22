import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/location.dart';
import 'package:carmoa/data/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildTopWeather(BuildContext context) {
  final position = Provider.of<Location>(context, listen: false);

  final w = MediaQuery.of(context).size.width;

  return Container(
    width: w * 0.85,
    height: 80,
    decoration: BoxDecoration(
      color: Color.fromRGBO(235, 235, 235, 1),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
            color: Colors.grey[500],
            offset: Offset(3.0, 3.0),
            blurRadius: 6.0,
            spreadRadius: 1),
        BoxShadow(
            color: Colors.white,
            offset: Offset(-3.0, -3.0),
            blurRadius: 6.0,
            spreadRadius: 1),
      ],
    ),

    child: FutureBuilder(
        future: loadPreference(context),
        builder: (builder, snap) {
          if (snap.hasData) {
            String data = snap.data;
            var location = data.split(',');

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(weatherIcons[10], color: Colors.cyan),
                    SizedBox(width: 20),
                    Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      color: Theme.of(context).primaryColor,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${position.getLat() != null ? position.getLat() : location[0]} / ${position.getLon() != null ? position.getLon() : location[1]}',
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
                SizedBox(height: 6),
                Text('대체로 구름이 조금 끼고 바람이 많이 불 예정',
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor))
              ],
            );
          }
          return Container();
        }),

    // child: FutureBuilder(
    //     future: getLocation(),
    //     builder: (builder, snap) {
    //       if (snap.hasData) {
    //         WeatherData weatherData = snap.data;
    //         return Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Icon(weatherIcons[10], color: Colors.cyan),
    //                 SizedBox(width: 20),
    //                 Icon(
    //                   FontAwesomeIcons.mapMarkerAlt,
    //                   color: Theme
    //                       .of(context)
    //                       .primaryColor,
    //                   size: 14,
    //                 ),
    //                 SizedBox(width: 4),
    //                 Text(
    //                   '${weatherData.lat} / ${weatherData.lon}',
    //                   style: TextStyle(
    //                       fontSize: 14, color: Theme
    //                       .of(context)
    //                       .primaryColor),
    //                 )
    //               ],
    //             ),
    //             SizedBox(height: 6),
    //             Text('대체로 구름이 조금 끼고 바람이 많이 불 예정',
    //                 style: TextStyle(
    //                     fontSize: 14, color: Theme
    //                     .of(context)
    //                     .primaryColor))
    //           ],
    //         );
    //       }
    //       return Container();
    //     }),
  );
}

Future<String> loadPreference(BuildContext context) async {
  final position = Provider.of<Location>(context, listen: false);

  SharedPreferences preferences = await SharedPreferences.getInstance();
  String item = preferences.getString('location') ?? '37.5640451,126.8336596';
  var data = item.split(',');
  position.setLocation(double.parse(data[0]), double.parse(data[1]));

  return item;
}

Future<void> savePreference(String location) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('location', location);
}

Future<WeatherData> getLocation() async {
  var location = await Permission.location.status;
  WeatherData weatherData = new WeatherData();

  if (!location.isGranted) {
    await Permission.location.request();
  }

  if (location.isGranted) {
    // var isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    // locationCheck.setPosition(true);

    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print('위치정보 : $location');
    weatherData.lon = location.latitude;
    weatherData.lat = location.longitude;
    return weatherData;
  } else {
    weatherData.lon = 126.8336596;
    weatherData.lat = 37.5640451;
    print('위치정보 확인 않됨');
    return weatherData;
  }
}
