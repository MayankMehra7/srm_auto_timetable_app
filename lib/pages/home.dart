import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:calendar_view/calendar_view.dart';

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

  String tC = "Today";
  String dayOrder = "Day 1";
  bool isNotif = false;
  String periodHour = "Period 1";
  String startTime = "8:30";
  String endTime = "9:20";
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);

  getDayorder() async {
    String day = "${DateTime.now().day}";
    String month = "${DateTime.now().month}";
    String year = DateTime.now().year.toString().substring(2);
    if (DateTime.now().day < 10) {
      day = "0${DateTime.now().day}";
    }
    if (DateTime.now().month < 10) {
      month = "0${DateTime.now().month}";
    }
    String date = "$day-$month-$year";
    http.Response dayOrderRes = await http.get(Uri.parse(
        "https://65ab8e5edf7d19ae4ef5.appwrite.global/dayorder?date=$date"));
    setState(() {
      dayOrder = json.decode(dayOrderRes.body)['msg'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDayorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Hey, ",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: FirebaseAuth.instance.currentUser!.displayName,
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))
                ])),
                const Spacer(),
                Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary,
                              width: 4),
                          // boxShadow: [
                          //   BoxShadow(
                          //       color: Theme.of(context)
                          //           .colorScheme
                          //           .tertiary
                          //           .withOpacity(0.6),
                          //       blurRadius: 3,
                          //       spreadRadius: 3,
                          //       offset: const Offset(0, 0))
                          // ],
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(FirebaseAuth
                                  .instance.currentUser!.photoURL!))),
                    ),
              ],
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: MonthView(
                  showBorder: false,
                  controller: EventController(),
                  headerBuilder: (date) => Text(
                    DateFormat.MMMM().format(date),
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  weekDayBuilder: (day) => const SizedBox(
                    height: 0,
                  ),
                  cellBuilder: (date, events, isToday, isInMonth) {
                    // Return your widget to display as month cell.
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: isInMonth
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${date.day}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedDate == date
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Colors.white,
                              ),
                            ),
                            if (events.isNotEmpty)
                              Text(
                                'Events: ${events.length}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  minMonth: DateTime(2024),
                  maxMonth: DateTime(2025),
                  initialMonth: DateTime(2021),
                  cellAspectRatio: 1,
                  onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
                  onCellTap: (events, date) {
                    // Implement callback when user taps on a cell.
                    print(date);
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  startDay:
                      WeekDays.sunday, // To change the first day of the week.
                  // This callback will only work if cellBuilder is null.
                  onEventTap: (event, date) => () {},
                  onDateLongPress: (date) => () {},
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: 160,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Padding(
                  //           padding: const EdgeInsets.only(left: 4.0, right: 4),
                  //           child: RichText(
                  //             text: TextSpan(children: [
                  //               TextSpan(
                  //                   text: "Hello,\n",
                  //                   style: GoogleFonts.poppins(
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 24,
                  //                     color: Theme.of(context).colorScheme.tertiary,
                  //                   )),
                  //               TextSpan(
                  //                   text: FirebaseAuth
                  //                       .instance.currentUser!.displayName!
                  //                       .split("(")
                  //                       .first,
                  //                   style: GoogleFonts.poppins(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 28,
                  //                       color:
                  //                           Theme.of(context).colorScheme.tertiary))
                  //             ]),
                  //           )),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       Container(
                  //         height: 80,
                  //         width: 100,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             border: Border.all(
                  //                 color: Theme.of(context).colorScheme.tertiary,
                  //                 width: 4),
                  //             image: DecorationImage(
                  //                 fit: BoxFit.fill,
                  //                 image: NetworkImage(
                  //                     FirebaseAuth.instance.currentUser!.photoURL!))),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  // //buttons today and calender
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Wrap(
                  //     alignment: WrapAlignment.start,
                  //     direction: Axis.horizontal,
                  //     children: List.generate(2, (index) {
                  //       String t = "Today";
                  //       index == 0 ? t = "Today" : t = "Calender";
                  //       return Padding(
                  //         padding: const EdgeInsets.all(5.0),
                  //         child: TextButton(
                  //           onPressed: () {
                  //             setState(() {
                  //               tC = t;
                  //             });
                  //           },
                  //           style: ButtonStyle(
                  //             elevation: const MaterialStatePropertyAll(5),
                  //             fixedSize: MaterialStatePropertyAll(Size(
                  //                 ((MediaQuery.of(context).size.width * 0.9) -
                  //                         30) /
                  //                     3,
                  //                 40)),
                  //             backgroundColor: MaterialStatePropertyAll(
                  //               tC == t
                  //                   ? Theme.of(context).colorScheme.primary
                  //                   : Theme.of(context).colorScheme.secondary,
                  //             ),
                  //             foregroundColor: MaterialStatePropertyAll(
                  //               tC == t ? Colors.white : Colors.black,
                  //             ),
                  //             shadowColor: MaterialStatePropertyAll(
                  //               Theme.of(context).colorScheme.secondary,
                  //             ),
                  //             shape: MaterialStateProperty.all<
                  //                 RoundedRectangleBorder>(
                  //               RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(30.0),
                  //               ),
                  //             ),
                  //           ),
                  //           child: Text(t.toString(),
                  //               style: GoogleFonts.poppins(
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //                 color:
                  //                     tC == t ? Colors.white : Colors.grey[800],
                  //               )),
                  //         ),
                  //       );
                  //     }),
                  //   ),
                  // ),

                  // //day text

                  Padding(
                      padding: const EdgeInsets.all(16.0),
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
                              text:
                                  DateFormat('d MMMM y').format(DateTime.now()),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.tertiary))
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
                                  color: Theme.of(context).colorScheme.tertiary,
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
                            Text(startTime,
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
                            Text(endTime,
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
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Timetable",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 30,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              const SizedBox(width: 70),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Switch(
                                    value: isNotif,
                                    onChanged: (value) {
                                      setState(() {
                                        isNotif = value;
                                      });
                                    },
                                    inactiveTrackColor:
                                        Theme.of(context).colorScheme.primary,
                                    activeColor:
                                        Theme.of(context).colorScheme.secondary,
                                    inactiveThumbColor:
                                        Theme.of(context).colorScheme.secondary,
                                    activeTrackColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(height: 2),
                                  Text("Notification",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      )),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                  //Container for present period and time
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(periodHour,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 38,
                                    color: Colors.white,
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: startTime,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 38,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " -- ",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 38,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: endTime,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 38,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
