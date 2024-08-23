import 'package:ambient/screens/ambients_lights_account.dart';
import 'package:ambient/screens/area_screen.dart';
import 'package:ambient/screens/controller_setup.dart';
import 'package:ambient/screens/timeZone.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ambient/widgets/background_widget.dart'; // Import the BackgroundWidget

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding:
              const EdgeInsets.all(16.0), // Add padding to the entire column
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AmbientLightsAccount(),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 150, bottom: 20),
                  width: 370,
                  height: 51,
                  decoration: BoxDecoration(
                    color: Color(0x40000000),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'AmbientLights Accounts',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ControllerSetup(),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 370,
                  height: 51,
                  decoration: BoxDecoration(
                    color: Color(0x40000000),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Controllers Setup',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreaScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 370,
                  height: 51,
                  decoration: BoxDecoration(
                    color: Color(0x40000000),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Zones Setup',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TimezoneScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 370,
                  height: 51,
                  decoration: BoxDecoration(
                    color: Color(0x40000000),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Time Zone and Location',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
