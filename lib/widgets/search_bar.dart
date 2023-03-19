import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_wheather_app/utils/constants.dart';
import 'package:flutter_wheather_app/utils/state_objects.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: searchController,
            style: const TextStyle(color: kFontColor),
            onSubmitted: (val) {
              updateWheather(context, searchController.text);
            },
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              updateWheather(context, searchController.text);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kForegroundColor)),
            child: const Text("Update",
                style: TextStyle(fontSize: 18, color: kFontColor)),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: clearWheather,
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kForegroundColor)),
            child: const Text(
              "Clear",
              style: TextStyle(fontSize: 18, color: kFontColor),
            ),
          )
        ],
      ),
    );
  }

  void updateWheather(BuildContext context, String search) async {
    // still need to find good way to search city coords on windows
    var coords = search.split(" ");
    var response = await http.get(
      Uri.https(
        kApiAdress,
        kApiEndpoint,
        {
          'latitude': coords[0],
          'longitude': coords[1],
          'hourly': kRequestParams,
        },
      ),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> raw = json['hourly']['temperature_2m'];
      List<double> temps = raw.map((e) => e as double).toList();
      context.read<WheatherForecastState>().update(
            weekTemps: temps,
            humidity: getTodaysDetail('relativehumidity_2m', json),
            apparentTemp: getTodaysDetail('apparent_temperature', json),
            precipitation: getTodaysDetail('precipitation_probability', json),
            visibility: getTodaysDetail('visibility', json),
            windspeed: getTodaysDetail('windspeed_10m', json),
          );
    } else {
      debugPrint(response.statusCode.toString());
    }
  }

  void clearWheather() async {
    context.read<WheatherForecastState>().clear();
    setState(() {});
  }

  double getTodaysDetail(String key, dynamic json, {int hour = 12}) {
    return double.parse(json['hourly'][key][hour].toString());
  }
}
