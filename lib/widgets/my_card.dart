import 'package:flutter/material.dart';

import 'package:flutter_wheather_app/utils/constants.dart';

class MyCard extends StatelessWidget {
  final Widget child;

  const MyCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: const BoxDecoration(
            color: kForegroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: child,
        ),
      ),
    );
  }
}
