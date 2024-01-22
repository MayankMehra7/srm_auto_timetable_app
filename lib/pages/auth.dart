// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ScheduleSRM/utils/auth_arc_box.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  void checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser != null) {
      if (!mounted) return;
      if (!prefs.containsKey("onboard")) {
        Navigator.pushNamed(context, '/onboard');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomPaint(
              painter: ShapePainter(context: context),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: Colors.transparent,
                  child: Center(child: Image.asset("assets/images/auth.png"))),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 40, bottom: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Keep Track\nOf your Class",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                          letterSpacing: 2)),
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                      "• Get notifications\n• Know your Day order\n• View full calendar",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600,
                          letterSpacing: 2)),
                ],
              ),
            ),

            //divider
            // const SizedBox(height: 5),
            // const Padding(
            //   padding: EdgeInsets.only(right: 30, left: 30, top: 10),
            //   child: Divider(color: Colors.grey),
            // ),

            //sign in using google
            const SizedBox(height: 20),
            OutlinedButton(
                onPressed: () async {
                  GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
                  await FirebaseAuth.instance
                      .signInWithPopup(googleAuthProvider)
                      .then((value) {
                    if (FirebaseAuth.instance.currentUser!.email!
                            .split("@")
                            .last !=
                        "srmist.edu.in") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Please sign in using SRM Gmail",
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ));
                    } else {
                      checkAuth();
                    }
                  });
                },
                style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.grey[200],
                    shadowColor: Color.fromARGB(255, 17, 74, 121),
                    elevation: 5,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 50),
                    side: BorderSide(
                        width: 2, color: Color.fromARGB(255, 17, 74, 121))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 35,
                          child: Image.asset("assets/images/google.png")),
                    ),
                    SizedBox(width: 7),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Sign in with Google",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )
                  ],
                )),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Built with",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    TextSpan(
                      text: " ❤️ ",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(
                      text: " by LiveWires_",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ]),
                ))
          ]),
    );
  }
}
