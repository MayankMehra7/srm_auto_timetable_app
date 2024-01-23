// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:js' as js;
import 'dart:js_util' as js_util;
import 'package:js/js.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:js/js_util.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

@JS('getTimetableStringFromLocalStorage')
external dynamic getTimetableStringFromLocalStorage();

class _HomeState extends State<Home> {
  Map timetableData = {};
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

  String dayOrder = "Day 1";
  bool isNotif = false;
  bool loadingTimetable = true;
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);
  DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);

  checkAuth() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, '/auth');
    }
  }

  getTimetableString() async {
    var promise = getTimetableStringFromLocalStorage();
    String timetableString = await promiseToFuture(promise);
    setState(() {
      timetableData = json.decode(timetableString);
    });
  }

  getDayorder(DateTime selectedDate) async {
    String day = "${selectedDate.day}";
    String month = "${selectedDate.month}";
    String year = selectedDate.year.toString().substring(2);
    if (selectedDate.day < 10) {
      day = "0${selectedDate.day}";
    }
    if (selectedDate.month < 10) {
      month = "0${selectedDate.month}";
    }
    String date = "$day-$month-$year";
    try {
      Client client = Client();
      client
        ..setEndpoint('https://cloud.appwrite.io/v1')
        ..setProject("65a4fa1564de7f6869d7");
      Functions function = Functions(client);
      Execution result = await function.createExecution(
          path: '/dayorder?date=$date', functionId: '65ab8e5e3cef04e16bf1');
      setState(() {
        dayOrder = json.decode(result.responseBody)["msg"] == "nothing"
            ? "Holiday 🛌"
            : json.decode(result.responseBody)["msg"];
        loadingTimetable = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.white),
              const SizedBox(width: 20),
              Text(
                e.toString(),
                style: GoogleFonts.poppins(fontSize: 14),
              )
            ],
          )));
    }
  }

  @override
  void initState() {
    super.initState();
    getDayorder(DateTime.now());
    checkAuth();
    getTimetableString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Hey,\n",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: FirebaseAuth
                                    .instance.currentUser!.displayName!
                                    .split('(')[0],
                                style: GoogleFonts.poppins(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              )
                            ])),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                            "Settings",
                                            style: GoogleFonts.poppins(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          backgroundColor: Colors.white,
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Include toggle notifcation,
                                              TextButton(
                                                onPressed: () {
                                                  FirebaseAuth.instance
                                                      .signOut();
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, '/auth');
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      const MaterialStatePropertyAll(
                                                          Colors.red),
                                                  fixedSize:
                                                      MaterialStatePropertyAll(
                                                          Size(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.8,
                                                              50)),
                                                  shape:
                                                      MaterialStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                  elevation:
                                                      const MaterialStatePropertyAll(
                                                          8),
                                                  shadowColor:
                                                      MaterialStatePropertyAll(
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary),
                                                ),
                                                child: Text(
                                                  "Logout",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                        ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
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
                                              .instance
                                              .currentUser!
                                              .photoURL!))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: MonthView(
                          showBorder: false,
                          controller: EventController(),
                          headerBuilder: (date) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${DateFormat('MMM').format(selectedMonth)}, ",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                Text(
                                  "${DateFormat('EE').format(selectedDate)}, ",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                Text(
                                  "${DateFormat('d').format(selectedDate)}, ",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                                Text(
                                  dayOrder,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
                            ),
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
                                          ? selectedDate == date
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .tertiary
                                              : Colors.white
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary),
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
                                            ? Theme.of(context)
                                                .colorScheme
                                                .tertiary
                                            : Colors.white,
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
                          onPageChange: (date, pageIndex) {
                            setState(() => selectedMonth = date);
                          },
                          onCellTap: (events, date) {
                            // Implement callback when user taps on a cell.
                            print(date);
                            getDayorder(date);
                            setState(() {
                              loadingTimetable = true;
                              selectedDate = date;
                            });
                          },
                          startDay: WeekDays
                              .sunday, // To change the first day of the week.
                          // This callback will only work if cellBuilder is null.
                          onEventTap: (event, date) => () {},
                          onDateLongPress: (date) => () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
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
                    padding: const EdgeInsets.only(left: 20.0, top: 10),
                    child: Text(
                      "Today's timetable",
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  loadingTimetable
                      ? Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Loading timetable",
                                  style: GoogleFonts.poppins(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: dayOrder == "Holiday 🛌" ||
                                      timetableData == {}
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "🛌",
                                          style: GoogleFonts.poppins(
                                              fontSize: 125),
                                        ),
                                        Text(
                                          "Holiday!",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 35,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: timetableData == {}
                                          ? 0
                                          : timetableData[dayOrder].length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4,
                                              right: 4,
                                              top: 10,
                                              bottom: 10),
                                          child: Container(
                                              height: 100,
                                              // width: 300,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      blurRadius: 3,
                                                      spreadRadius: 3,
                                                      offset:
                                                          const Offset(0, 0))
                                                ],
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Text(
                                                                timetableData[
                                                                            dayOrder]
                                                                        [index]
                                                                    .toString()
                                                                    .replaceAll(
                                                                        "\n",
                                                                        ""),
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25)),
                                                          ),
                                                        ),
                                                        Text(
                                                            '${startTimes[index]} ── ${endTimes[index]}',
                                                            style: GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                fontSize: 20)),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      "Hour: ${index + 1}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ));
  }
}
