import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic_bullet/dashboard.dart';
import 'package:magic_bullet/utils/color_value.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: whiteColor),
      home: AnimatedSplash(
        imagePath: 'assets/images/logo.jpg',
        home: Dashboard(),
        // customFunction: duringSplash,
        duration: 500,
        type: AnimatedSplashType.StaticDuration,
        // outputAndHome: op,
      ),
    );
  }
}
