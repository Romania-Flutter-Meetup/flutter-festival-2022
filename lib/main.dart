import 'package:flutter/material.dart';
import 'package:flutter_festival_romania_meetup_2022/screens/events_screen.dart';
import 'package:flutter_festival_romania_meetup_2022/screens/home_screen.dart';
import 'package:flutter_festival_romania_meetup_2022/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDG Cluj',
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/home': (context) => const HomeScreen(),
        '/events': ((context) => const EventsScreen())
      },
      home: SplashScreen(),
    );
  }
}
