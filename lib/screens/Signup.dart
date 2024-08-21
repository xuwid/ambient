import 'package:ambient/screens/Login.dart';
import 'package:ambient/screens/homescreen.dart';
import 'package:ambient/screens/hometab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ambient/widgets/background_widget.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                Text(
                  'Create an Account',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 360,
                  height: 51,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      fillColor: Color(0xff606060),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide:
                            BorderSide(color: Color(0xff6060), width: 2),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 360,
                  height: 51,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      fillColor: Color(0xff606060),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide:
                            BorderSide(color: Color(0xff6060), width: 2),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 360,
                  height: 51,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      fillColor: Color(0xff606060),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide:
                            BorderSide(color: Color(0xff6060), width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  height: 51,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 20,
                      ),
                    ),
                    child: Text('Create an Account'),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  height: 51,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.blue,
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 20,
                      ),
                      side: BorderSide(color: Colors.blue, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: Text('Login'),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
