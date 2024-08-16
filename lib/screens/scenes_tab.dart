import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScenesTab extends StatelessWidget {
  const ScenesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(
            'Scenes',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        Expanded(
          child: Center(
            child: Text(
              'Scenes Content Here',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
