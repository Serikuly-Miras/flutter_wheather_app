import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_wheather_app/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_wheather_app/utils/state_objects.dart';
import 'package:flutter_wheather_app/widgets/my_card.dart';

class WeeklyWheather extends StatefulWidget {
  const WeeklyWheather({super.key});

  @override
  State<WeeklyWheather> createState() => _WeeklyWheatherState();
}

class _WeeklyWheatherState extends State<WeeklyWheather>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late DateTime date;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: kAnimationDuration,
    );
    _controller.reset();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    date = DateTime.now();
    return Consumer<WheatherForecastState>(
      builder: (context, value, child) {
        _controller.reset();
        _controller.forward();
        if (value.loaded) {
          return Expanded(
            child: Row(
              children: [
                for (int i = 0; i < 6; i++) getDay(i, value),
              ],
            ),
          );
        } else {
          return Expanded(
            child: Row(
              children: [
                for (int i = 0; i < 6; i++) MyCard(child: Container()),
              ],
            ),
          );
        }
      },
    );
  }

  Widget getDay(int i, WheatherForecastState value) {
    int tempDay = value.getWeekTemps[8 * (i + 1) + 24].toInt();
    int tempNight = value.getWeekTemps[16 * (i + 1) + 24].toInt();
    return MyCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.cloud),
            Column(
              children: [
                Text(
                  DateFormat('d EE').format(date.add(Duration(days: i + 1))),
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "$tempDay° / $tempNight°",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      )
          .animate(controller: _controller)
          .fadeIn(duration: kAnimationDuration, delay: kAnimationDelta * i),
    );
  }
}
