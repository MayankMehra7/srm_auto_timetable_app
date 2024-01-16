// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  // TODO: implement auth status check and redirect
  // TODO: implement auth UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  SizedBox(height: 28),
                  Container(
                      height: 300,
                      child:
                          Center(child: Image.asset("assets/images/auth.png"))),

                  //Text
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, bottom: 10, right: 30, top: 20),
                    child: Text("Keep Track\nOf your Class",
                        style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[500],
                            letterSpacing: 2)),
                  ),

                  //divider
                  SizedBox(height: 5),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 30, left: 30, top: 10),
                    child: Divider(color: Colors.grey),
                  ),

                  //sign in using google
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 5, bottom: 20),
                    child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 17, 74, 121),
                            foregroundColor: Colors.grey[200],
                            shadowColor: Color.fromARGB(255, 17, 74, 121),
                            elevation: 5,

                            //fixedSize:,
                            side: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 17, 74, 121))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 35,
                                  child:
                                      Image.asset("assets/images/google.png")),
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
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
