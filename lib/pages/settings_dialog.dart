import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

dialogueBox(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            content: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Settings  and close
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                        child: Row(
                          children: [
                            Text(
                              "Settings",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2),
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.close_outlined,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(),
                      //LW logo and  built and maintained by Livewires
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/lw_dark.png",
                            width: 150,
                            // height: MediaQuery.of(context).size.height * 0.3,
                            // width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          //const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Built & maintained by LiveWires_ ",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      //contributors text
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contributors",
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 69, 147, 48),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            Text(
                              "👧🏽\t\tPanchami",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "🧑🏽\t\tRoshan",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2),
                            ),
                          ],
                        ),
                      ),
                      //follow us
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Follow Us",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      //icons
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    await launchUrl(Uri.parse(
                                        "https://www.instagram.com/live.wires_/"));
                                  },
                                  child: Image.asset(
                                    'assets/icons/ig.png',
                                    height: 30,
                                    width: 30,
                                  )),
                              // const Spacer(),
                              InkWell(
                                  onTap: () async {
                                    await launchUrl(Uri.parse(
                                        "https://x.com/LiveWires_2k23?t=SfRtFlFjs0MBaof2ypydhQ&s=09"));
                                  },
                                  child: Image.asset(
                                    'assets/icons/twt.png',
                                    height: 30,
                                    width: 30,
                                  )),
                              // const Spacer(),
                              InkWell(
                                  onTap: () async {
                                    await launchUrl(Uri.parse(
                                        "https://www.facebook.com/profile.php?id=61550269514833&mibextid=ZbWKwL"));
                                  },
                                  child: Image.asset(
                                    'assets/icons/fb.png',
                                    height: 30,
                                    width: 30,
                                  )),
                              // const Spacer(),
                              InkWell(
                                  onTap: () async {
                                    await launchUrl(Uri.parse(
                                        "https://github.com/LiveWiresSRM2023"));
                                  },
                                  child: Image.asset(
                                    'assets/icons/github_round.png',
                                    height: 30,
                                    width: 30,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(height: 10),
                      //join team
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                                onPressed: () async {
                                  await launchUrl(
                                      Uri.parse("https://wa.me/+918122354855"));
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 9, 14, 10),
                                  foregroundColor:
                                      const Color.fromARGB(255, 9, 14, 10),
                                  shadowColor: Colors.black,
                                  elevation: 2,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      40),
                                ),
                                child: Text("Join Team",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                                onPressed: () async {
                                  await launchUrl(Uri.parse(
                                      "mailto:livewires2k20@gmail.com"));
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 9, 14, 10),
                                  elevation: 2,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      40),
                                ),
                                child: Text("Suggest an idea!",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                                onPressed: () async {
                                  FirebaseAuth.instance.signOut();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.remove("onboard");
                                  Navigator.pushReplacementNamed(
                                      context, "/auth");
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  elevation: 2,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      40),
                                ),
                                child: Text("Logout",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white))),
                          ),
                        ],
                      ),
                      //what would u like us to build
                      //logout?
                    ]),
              ),
            ),
          ));
}
