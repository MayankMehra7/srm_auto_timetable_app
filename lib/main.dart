import 'package:flutter/material.dart';
import 'package:srm_timetable/pages/auth.dart';
import 'package:srm_timetable/pages/home.dart';
import 'package:srm_timetable/pages/onboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // TODO: implement app theme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Auth(),
      routes: {
        '/home': (context) => const Home(),
        '/oboard': (context) => const Onboard()
      },
    );
  }
}