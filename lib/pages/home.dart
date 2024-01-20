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
  final List<String> startTimes = [
    "8:30",
    "9:20",
    "10:10",
    "11:00",
    "12:00",
    "12:50",
    "1:40",
    "2:30",
    "3:20",
  ];

  final List<String> endTimes = [
    "9:20",
    "10:10",
    "11:00",
    "11:50",
    "12:50",
    "1:40",
    "2:30",
    "3:20",
    "4:10",
  ];
  final List<String> periodHours = [
    "Period 1",
    "Period 2",
    "Period 3",
    "Period 4",
    "Period 5",
    "Period 6",
    "Period 7",
    "Period 8",
    "Period 9",
  ];

  String tC = "Today";
  String dayOrder = "Day 1";
  bool isNotif = false;
  String periodHour = "Period 1";
  String startTime = "8:30";
  String endTime = "9:20";
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);

  checkAuth() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, '/auth');
    }
  }

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
    http.Response dayOrderRes = await http.get(
        Uri.parse("https://get-day-order.livewires.tech/dayorder?date=$date"));
    setState(() {
      dayOrder = json.decode(dayOrderRes.body)['msg'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDayorder();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Hey,\n",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: FirebaseAuth.instance.currentUser!.displayName!
                          .split('(')[0],
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ])),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 60,
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
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: MonthView(
                  showBorder: false,
                  controller: EventController(),
                  headerBuilder: (date) => Text(
                    "${DateFormat.MMMM().format(date)}, $dayOrder",
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
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: DateFormat('EEEE, ').format(DateTime.now()),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).colorScheme.primary,
                              )),
                          TextSpan(
                              text:
                                  DateFormat('d MMMM y').format(DateTime.now()),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color:
                                      Theme.of(context).colorScheme.tertiary))
                        ]),
                      )),
                  //DayOrder and Notif
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(dayOrder,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 38,
                                color: Theme.of(context).colorScheme.tertiary,
                              )),
                          const SizedBox(width: 150),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                            ],
                          ),
                        ]),
                  ),

                  //Container for period and time
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(periodHour,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 30)),
                            const SizedBox(width: 50),
                            Text('$startTime -- $endTime',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 20)),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: periodHours.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 10, bottom: 10),
                            child: Container(
                                height: 150,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(periodHours[index],
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                  fontSize: 30)),
                                          const SizedBox(width: 50),
                                          Text(
                                              '${startTimes[index]} -- ${endTimes[index]}',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.normal,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  fontSize: 20)),
                                        ],
                                      ),
                                      const SizedBox(width: 100),
                                      const Icon(Icons.timer,
                                          color: Colors.white),
                                    ],
                                  ),
                                )),
                          );
                        },
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
