import 'package:flutter/foundation.dart';

class WheatherForecastState with ChangeNotifier {
  List<double> weekTemps = [];
  double humidity = 0;
  double apparentTemp = 0;
  double precipitation = 0;
  double visibility = 0;
  double windspeed = 0;

  bool loaded = false;

  List<double> get getWeekTemps => weekTemps;
  double get getHumidity => humidity;
  double get getApparentTemp => apparentTemp;
  double get getPrecipitation => precipitation;
  double get getVisibility => visibility;
  double get getWindspeed => windspeed;

  void update({
    required List<double> weekTemps,
    required double humidity,
    required double apparentTemp,
    required double precipitation,
    required double visibility,
    required double windspeed,
  }) {
    this.weekTemps = weekTemps;
    this.humidity = humidity;
    this.apparentTemp = apparentTemp;
    this.precipitation = precipitation;
    this.visibility = visibility;
    this.windspeed = windspeed;
    loaded = true;
    notifyListeners();
  }

  void clear() {
    loaded = false;
    notifyListeners();
  }
}
