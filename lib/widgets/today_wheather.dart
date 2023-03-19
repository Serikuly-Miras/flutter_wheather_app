import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_wheather_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:flutter_wheather_app/utils/state_objects.dart';
import 'package:flutter_wheather_app/widgets/my_card.dart';

class TodayWheather extends StatefulWidget {
  const TodayWheather({super.key});

  @override
  State<TodayWheather> createState() => _TodayWheatherState();
}

class _TodayWheatherState extends State<TodayWheather>
    with TickerProviderStateMixin {
  var date = DateTime.now();
  late AnimationController _controller;

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
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 32),
      child: MyCard(
        child: Consumer<WheatherForecastState>(
          builder: (context, value, child) {
            _controller.reset();
            _controller.forward();
            if (value.loaded) {
              double tempDay = value.getWeekTemps[8];
              double tempNight = value.getWeekTemps[16];
              return Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(DateFormat('EEEE').format(date)),
                            Text(DateFormat('d MMM').format(date)),
                            Text("$tempDay° / $tempNight°"),
                          ],
                        ),
                        const Icon(
                          Icons.cloud,
                          size: 100,
                        ),
                      ],
                    )
                  ],
                )
                    .animate(controller: _controller)
                    .fadeIn(duration: kAnimationDuration),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
