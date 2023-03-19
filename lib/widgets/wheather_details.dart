import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_wheather_app/utils/constants.dart';
import 'package:provider/provider.dart';

import 'package:flutter_wheather_app/utils/state_objects.dart';
import 'package:flutter_wheather_app/widgets/my_card.dart';

class WheatherDetails extends StatefulWidget {
  const WheatherDetails({super.key});

  @override
  State<WheatherDetails> createState() => _WheatherDetailsState();
}

class _WheatherDetailsState extends State<WheatherDetails>
    with TickerProviderStateMixin {
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
    return Expanded(
      child: Consumer<WheatherForecastState>(
        builder: (context, value, child) {
          _controller.reset();
          _controller.forward();
          List<_DetailsElem> elems = [
            _DetailsElem(
              title: "Humidity",
              value: value.getHumidity,
              icon: Icons.water_drop,
              controller: _controller,
              unit: "%",
            ),
            _DetailsElem(
              title: "Apparent T",
              value: value.getApparentTemp,
              icon: Icons.thermostat,
              controller: _controller,
              unit: "°C",
            ),
            _DetailsElem(
              title: "Precipitation",
              value: value.getPrecipitation,
              icon: Icons.cloudy_snowing,
              controller: _controller,
              unit: " mm",
            ),
            _DetailsElem(
              title: "Visibility",
              value: value.getVisibility,
              icon: Icons.remove_red_eye,
              controller: _controller,
              unit: " m",
            ),
            _DetailsElem(
              title: "Windspeed",
              value: value.getWindspeed,
              icon: Icons.air,
              controller: _controller,
              unit: " Km/h",
            ),
          ];
          return Row(
            children: [
              if (value.loaded)
                ...elems
              else
                for (int i = 0; i < elems.length; i++)
                  MyCard(child: Container()),
            ],
          );
        },
      ),
    );
  }
}

class _DetailsElem extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final AnimationController controller;
  final String unit;

  const _DetailsElem({
    required this.title,
    required this.value,
    required this.icon,
    required this.controller,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 40,
          ),
          Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 32),
                textAlign: TextAlign.start,
              ),
              Text(
                value.toInt().toString() + unit,
                style: const TextStyle(fontSize: 32),
              ),
            ],
          ),
        ],
      ).animate(controller: controller).fadeIn(duration: kAnimationDuration),
    );
  }
}
