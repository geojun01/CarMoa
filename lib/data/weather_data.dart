class WeatherData {
  double lat;
  double lon;

  WeatherData({this.lat, this.lon});

  Map<String, dynamic> toWeather() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}