import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

const kFontColor = Color.fromARGB(255, 255, 255, 255);
const kBackgroundColor = Color.fromARGB(255, 11, 11, 11);
const kForegroundColor = Color.fromARGB(255, 30, 30, 30);

const kAccent1Color = Color.fromARGB(255, 112, 221, 255);
const kAccent2Color = Color.fromARGB(255, 154, 254, 168);
const kAccent3Color = Color.fromARGB(255, 247, 255, 152);

const kTitle = 'Wheater App';
const kApiAdress = 'api.open-meteo.com';
const kApiEndpoint = 'v1/forecast';
const kRequestParams = [
  'temperature_2m',
  'relativehumidity_2m',
  'apparent_temperature',
  'precipitation_probability',
  'visibility',
  'evapotranspiration',
  'windspeed_10m',
  'weathercode',
];

final kAnimationDelay = 300.milliseconds;
final kAnimationDelta = 100.milliseconds;
final kAnimationDuration = 750.milliseconds;
