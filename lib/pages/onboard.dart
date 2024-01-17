import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    'M.Sc ADS',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //lets find your tt text
            //const SizedBox(height: 30),
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4),
                    child: Text(
                      "Let's find Your \nTimetable !",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 50, right: 8.0, bottom: 8, top: 8),
                    child: Icon(
                      Icons.calendar_month_sharp,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            //select your year text
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Select your year ",
                style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
              ),
            ),

            //Year Buttons
            Center(
              child: Wrap(
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
                        fixedSize: const MaterialStatePropertyAll(Size(50, 50)),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
            ),

            //enter dept text
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Select your department ",
                style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
              ),
            ),
            //Department dropdown
            const SizedBox(height: 5),
            Container(
              width: 230,
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
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  items:
                      departments.map<DropdownMenuItem<String>>((String value) {
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

            //Class text
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Select your class",
                style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
              ),
            ),

            //Class dropdown
            const SizedBox(height: 5),
            Container(
              width: 230,
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
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  items: classes.map<DropdownMenuItem<String>>((String value) {
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Select your section ",
                style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
              ),
            ),

            //Section dropdown
            const SizedBox(height: 10),
            Container(
              width: 230,
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
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  items: sections.map<DropdownMenuItem<String>>((String value) {
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
            const SizedBox(height: 10),
            const Padding(
              padding:
                  EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 10),
              child: Divider(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 100, left: 100),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(8),
                    shadowColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.secondary),
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
