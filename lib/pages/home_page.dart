import 'package:flutter/material.dart';

import 'package:flutter_wheather_app/utils/constants.dart';
import 'package:flutter_wheather_app/widgets/search_bar.dart';
import 'package:flutter_wheather_app/widgets/today_wheather.dart';
import 'package:flutter_wheather_app/widgets/weekly_wheather.dart';
import 'package:flutter_wheather_app/widgets/wheather_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: DefaultTextStyle(
        style: const TextStyle(
          color: kFontColor,
          fontSize: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  const TodayWheather(),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SearchBar(),
                            ],
                          ),
                        ),
                        const WeeklyWheather(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const WheatherDetails(),
          ],
        ),
      ),
    );
  }
}
