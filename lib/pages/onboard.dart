import 'package:flutter/material.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  // TODO: get user class and section data
  // TODO: implement onboard UI
  // TODO: implement secure_sharedpreferences or hive for local DB
  // TODO: implement onboard UI
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Onboard"),
      ),
    );
  }
}
