// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:js/js_util.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});
  @override
  State<Onboard> createState() => _OnboardState();
}

// @JS('saveData')
// external dynamic saveData(String key, String value);

class _OnboardState extends State<Onboard> {
  int year = 0;
  String _department = 'Computer Applications';
  String _class = 'BCA';
  String _section = 'A';

  List<String> departments = [
    'Computer Applications',
  ];
  // List<String> classes = [
  //   'BCA',
  //   'BCA DS',
  //   'MCA',
  //   'MSc ADS',
  // ];

  bool loadingTimeTable = false;

  checkAuth() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, '/auth');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //lets find your tt text
            //const SizedBox(height: 30),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: SizedBox(
                height: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 160,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Hey, ",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Colors.white)),
                            TextSpan(
                                text: FirebaseAuth
                                    .instance.currentUser!.displayName!
                                    .split("(")
                                    .first,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color:
                                        Theme.of(context).colorScheme.tertiary))
                          ]),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Text(
                        "Let's find Your timetable!",
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade200,
                            fontSize: 23,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //select your year text
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select your year ",
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  //Year Buttons
                  Wrap(
                    alignment: WrapAlignment.center,
                    direction: Axis.horizontal,
                    children: List.generate(3, (index) {
                      int number = index + 1;
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _class = "BCA";
                              _section = "A";
                              year = number;
                            });
                          },
                          style: ButtonStyle(
                            elevation: const MaterialStatePropertyAll(5),
                            fixedSize: MaterialStatePropertyAll(Size(
                                ((MediaQuery.of(context).size.width * 0.9) -
                                        40) /
                                    3,
                                50)),
                            backgroundColor: MaterialStatePropertyAll(
                              number == year
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                            foregroundColor: MaterialStatePropertyAll(
                              number == year ? Colors.white : Colors.black,
                            ),
                            shadowColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.secondary,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                          ),
                          child: Text(number.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: number == year
                                    ? Colors.white
                                    : Colors.grey[800],
                              )),
                        ),
                      );
                    }),
                  ),
                  //enter dept text
                  const SizedBox(height: 15),
                  year == 0
                      ? const SizedBox()
                      : Text(
                          "Select your department",
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                  //Department dropdown
                  year == 0
                      ? const SizedBox()
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _department,
                              iconEnabledColor:
                                  Theme.of(context).colorScheme.primary,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 6,
                              isExpanded: false,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                              items: departments.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey[800]),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _department = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                  const SizedBox(height: 15),
                  //Class text
                  getClass().isEmpty
                      ? const SizedBox()
                      : Text(
                          "Select your class",
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                  //Class dropdown
                  getClass().isEmpty
                      ? const SizedBox()
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _class,
                              iconEnabledColor:
                                  Theme.of(context).colorScheme.primary,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 6,
                              isExpanded: false,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                              // items: classes
                              //     .map<DropdownMenuItem<String>>((String value) {
                              //   return DropdownMenuItem<String>(
                              //     value: value,
                              //     child: Text(
                              //       value,
                              //       style: GoogleFonts.poppins(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.normal,
                              //           color: Colors.grey[800]),
                              //     ),
                              //   );
                              // }).toList(),
                              items: getClass(),
                              onChanged: (String? cl) {
                                if (cl != null) {
                                  setState(() {
                                    _section = "A";
                                    _class = cl;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                  //enter section text
                  const SizedBox(height: 15),
                  //if (_class != 'BCA DS' && (year != 1 && year != 2))
                  getSection().isEmpty
                      ? const SizedBox()
                      : Text(
                          "Select your section ",
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                  //Section dropdown
                  //if (_class != 'BCA DS' && (year != 1 && year != 2))
                  getSection().isEmpty
                      ? const SizedBox()
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _section,
                              iconEnabledColor:
                                  Theme.of(context).colorScheme.primary,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 6,
                              isExpanded: false,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                              items: getSection(),
                              onChanged: (String? sec) {
                                if (sec != null) {
                                  setState(() {
                                    _section = sec;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                  //continue text_icon button
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      if (year == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.error_outline_rounded,
                                    color: Colors.white),
                                const SizedBox(width: 20),
                                Text(
                                  "Please select your year",
                                  style: GoogleFonts.poppins(fontSize: 14),
                                )
                              ],
                            )));
                      } else {
                        setState(() {
                          loadingTimeTable = true;
                        });
                        String fileName =
                            "${year.toString()}_${_class.replaceAll(" ", "_").toLowerCase()}_${_section.toLowerCase()}.json";
                        if (_class == 'BCA DS' && (year == 2 || year == 3)) {
                          fileName =
                              "${year.toString()}_${_class.replaceAll(" ", "_").toLowerCase()}.json";
                        }
                        http.Response res = await http.get(Uri.parse(
                            'https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/website/assets/json/$fileName'));
                        if (res.statusCode == 404) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.error_outline_rounded,
                                      color: Colors.white),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Timetable for $year, $_class and $_section sec. is not found",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  )
                                ],
                              )));
                          setState(() => loadingTimeTable = false);
                        } else {
                          Map timetableData = json.decode(res.body);
                          Map parsedTimetableData = timetableData;
                          /* Store the timetable in the below format
                            {
                              "Day 1" : [],
                              ...
                              "Day 5" : [],
                            }
                          */
                          Map<String, List<dynamic>> compressedTimetable = {};
                          // List of only the values of the JSON which is again a Map
                          List dayOrdersValues =
                              parsedTimetableData.values.toList();
                          // List of only the keys of the JSON
                          List dayOrdersKeys =
                              parsedTimetableData.keys.toList();
                          for (int i = 0; i < dayOrdersKeys.length; i++) {
                            compressedTimetable[dayOrdersKeys[i]] =
                                dayOrdersValues[i].values.toList();
                          }
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              "timetable", jsonEncode(compressedTimetable));
                          prefs.setBool("onboard", true);
                          // var promise = saveData(
                          //     "timetable", jsonEncode(compressedTimetable));
                          // await promiseToFuture(promise);
                          // js.context.callMethod("saveData",
                          //     ["timetable", jsonEncode(compressedTimetable)]);
                          if (!mounted) return;
                          Navigator.pushReplacementNamed(context, "/home");
                        }
                      }
                    },
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(8),
                        shadowColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.secondary),
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.primary),
                        fixedSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 0.9, 50)),
                        foregroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.primary)),
                    child: loadingTimeTable
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Section Dropdown For Each Class
  List<DropdownMenuItem<String>> getSection() {
    List<String> allowedSections = [];

    if (_class == 'BCA' && year == 1) {
      allowedSections = ['A', 'B', 'C'];
    } else if (_class == 'MCA' && year == 1) {
      allowedSections = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
    } else if (_class == 'MSc ADS' && year == 1) {
      allowedSections = ['A', 'B', 'C', 'D'];
    } else if (_class == 'BCA DS' && year == 1) {
      allowedSections = ['A', 'B', 'C'];
    } else if (_class == 'BCA' && year == 2) {
      allowedSections = ['A', 'B', 'C'];
    } else if (_class == 'BCA DS' && year == 2) {
      allowedSections = [];
    } else if (_class == 'BCA' && year == 3) {
      allowedSections = ['A', 'B'];
    } else if (_class == 'BCA DS' && year == 3) {
      allowedSections = [];
    }

    return allowedSections.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.grey[800],
          ),
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> getClass() {
    List<String> allowedClass = [];

    if (year == 1) {
      allowedClass = ['BCA', 'MCA', 'MSc ADS', 'BCA DS'];
    } else if (year == 2) {
      allowedClass = ['BCA DS', 'BCA'];
    } else if (year == 3) {
      allowedClass = ['BCA DS', 'BCA'];
    } else if (year == 4) {
      allowedClass = [];
    }

    return allowedClass.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.grey[800],
          ),
        ),
      );
    }).toList();
  }
}
