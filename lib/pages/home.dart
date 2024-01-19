import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // TODO: implement FCM getToken()
  // TODO: implement FCM notification listner subscriber
  // TODO: implement home UI

  Map dummyData = {
    "Day 1": [
      "Class 1",
      "Class 2",
      "Class 3",
      "Class 4",
      "Class 5",
      "Class 6",
      "Class 7",
      "Class 8",
      "Class 9"
    ],
    "Day 2": [
      "Class 1",
      "Class 2",
      "Class 3",
      "Class 4",
      "Class 5",
      "Class 6",
      "Class 7",
      "Class 8",
      "Class 9"
    ],
    "Day 3": [
      "Class 1",
      "Class 2",
      "Class 3",
      "Class 4",
      "Class 5",
      "Class 6",
      "Class 7",
      "Class 8",
      "Class 9"
    ],
    "Day 4": [
      "Class 1",
      "Class 2",
      "Class 3",
      "Class 4",
      "Class 5",
      "Class 6",
      "Class 7",
      "Class 8",
      "Class 9"
    ],
    "Day 5": [
      "Class 1",
      "Class 2",
      "Class 3",
      "Class 4",
      "Class 5",
      "Class 6",
      "Class 7",
      "Class 8",
      "Class 9"
    ],
  };
  String t_c = "Today";
  String dayOrder = "Day 1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: SizedBox(
                height: 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Hello,\n",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white)),
                            TextSpan(
                                text: FirebaseAuth
                                    .instance.currentUser!.displayName!
                                    .split("(")
                                    .first,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.tertiary))
                          ]),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      width: 160,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary,
                              width: 4),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(FirebaseAuth
                                  .instance.currentUser!.photoURL!))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            //buttons today and calender
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: List.generate(2, (index) {
                  String t = "Today";
                  index == 0 ? t = "Today" : t = "Calender";
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          t_c = t;
                        });
                      },
                      style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(5),
                        fixedSize: MaterialStatePropertyAll(Size(
                            ((MediaQuery.of(context).size.width * 0.9) - 30) /
                                3,
                            40)),
                        backgroundColor: MaterialStatePropertyAll(
                          t_c == t
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                        ),
                        foregroundColor: MaterialStatePropertyAll(
                          t_c == t ? Colors.white : Colors.black,
                        ),
                        shadowColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.secondary,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(t.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: t_c == t ? Colors.white : Colors.grey[800],
                          )),
                    ),
                  );
                }),
              ),
            ),

            //day text
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: DateFormat('EEEE, ').format(DateTime.now()),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    TextSpan(
                        text: DateFormat('d MMMM y').format(DateTime.now()),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.tertiary))
                  ]),
                )),

            //row
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 8, bottom: 8, right: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Day Order",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      const SizedBox(height: 2),
                      Text(dayOrder,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("08:30",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 38,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      Center(
                        child: Container(
                          height: 20,
                          width: 2,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text("09:20",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 38,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                    ],
                  ),
                ),
              ],
            ),

            //container for tt text and notif
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            //Container for present period and time
          ],
        )));
  }
}
