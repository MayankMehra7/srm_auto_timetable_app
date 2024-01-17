import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:srm_timetable/pages/auth.dart';
import 'package:srm_timetable/pages/home.dart';
import 'package:srm_timetable/pages/onboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDpPLA4Nt1FY6hsoseVPYD2JRP7e9ENKD4",
          authDomain: "srm-timetable-bb661.firebaseapp.com",
          projectId: "srm-timetable-bb661",
          storageBucket: "srm-timetable-bb661.appspot.com",
          messagingSenderId: "1062574904489",
          appId: "1:1062574904489:web:28469fb2790052f36485b8",
          measurementId: "G-0HHRGFQ665"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff0c4da2),
          secondary: const Color(0xffa8cbf6),
          tertiary: const Color(0xffe4b316),
        ),
        useMaterial3: true,
      ),
      home: const Auth(),
      routes: {
        '/home': (context) => const Home(),
        '/onboard': (context) => const Onboard()
      },
    );
  }
}
