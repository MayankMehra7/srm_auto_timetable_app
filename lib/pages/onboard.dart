import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Onboard extends StatefulWidget {
  const Onboard({super.key});
  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int year = 0;
  String _department = 'Computer Applications';
  String _class = 'BCA';
  String _section = 'A';

  List<String> departments = [
    'Computer Applications',
  ];
  List<String> classes = [
    'BCA',
    'BCA DS',
    'MCA',
    'MSc ADS',
  ];

  List<String> sections = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
  ];
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
                    children: List.generate(4, (index) {
                      int number = index + 1;
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              year = number;
                            });
                          },
                          style: ButtonStyle(
                            elevation: const MaterialStatePropertyAll(5),
                            fixedSize: MaterialStatePropertyAll(Size(
                                ((MediaQuery.of(context).size.width * 0.9) -
                                        40) /
                                    4,
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
                  Text(
                    "Select your department ",
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  //Department dropdown
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _department,
                        iconEnabledColor: Theme.of(context).colorScheme.primary,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 6,
                        isExpanded: false,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        items: departments
                            .map<DropdownMenuItem<String>>((String value) {
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
                  Text(
                    "Select your class",
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  //Class dropdown
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _class,
                        iconEnabledColor: Theme.of(context).colorScheme.primary,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 6,
                        isExpanded: false,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        items: classes
                            .map<DropdownMenuItem<String>>((String value) {
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
                        onChanged: (String? cl) {
                          if (cl != null) {
                            setState(() {
                              _class = cl;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  //enter section text
                  const SizedBox(height: 15),
                  Text(
                    "Select your section ",
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  //Section dropdown
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _section,
                        iconEnabledColor: Theme.of(context).colorScheme.primary,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 6,
                        isExpanded: false,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        items: sections
                            .map<DropdownMenuItem<String>>((String value) {
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
                      String fileName =
                          "${year.toString()}_${_class.toLowerCase()}_${_section.toLowerCase()}";
                      http.Response res = await http.get(Uri.parse('https://srmtt.livewires.tech/assets/json/$fileName'));
                      Navigator.pushReplacementNamed(context, '/home');
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Continue",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
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
}
