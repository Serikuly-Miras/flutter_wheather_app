import 'package:flutter/material.dart';
import 'package:flutter_wheather_app/utils/constants.dart';
import 'package:flutter_wheather_app/utils/state_objects.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WheatherForecastState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.urbanistTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}
