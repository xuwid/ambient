import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:ambient/widgets/background_widget.dart'; // Import your BackgroundWidget
import 'package:provider/provider.dart'; // Import provider package
import 'package:ambient/models/state_models.dart'; // Import your state models

class AmbientLightsAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Column(
            children: [
              Consumer<HomeState>(
                builder: (context, homeState, child) {
                  // Find the active areas
                  final activeAreas =
                      homeState.areas.where((area) => area.isActive).toList();

                  // Generate the title text based on active areas
                  String titleText;
                  if (activeAreas.isEmpty) {
                    titleText =
                        'AmbientLights Account'; // Default title if no area is active
                  } else {
                    final titles =
                        activeAreas.take(2).map((area) => area.title).toList();
                    if (activeAreas.length > 2) {
                      titles.add('...'); // Add ellipsis for additional areas
                    }
                    titleText = titles.join(', ');
                  }

                  return AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      margin: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.transparent, // Transparent background
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey, // Color of the bottom border
                            width: 0.5, // Width of the bottom border
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.grey),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  'AmbientLights Account',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    centerTitle: true,
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(
                      16.0), // Add padding to the entire content
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        width: 370,
                        height: 51,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                              0.4), // Match with background gradient
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'useremail@gmail.com',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        margin: EdgeInsets.only(bottom: 20),
                        width: 370,
                        height: 51,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                              0.4), // Match with background gradient
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'Password Reset',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        margin: EdgeInsets.only(bottom: 20),
                        width: 370,
                        height: 51,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                              0.4), // Match with background gradient
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'Delete Account',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        margin: EdgeInsets.only(bottom: 60),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Logout'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            textStyle: GoogleFonts.montserrat(
                              fontSize: 16,
                            ),
                          ),
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
