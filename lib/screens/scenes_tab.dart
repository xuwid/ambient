import 'package:ambient/screens/scene.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ambient/widgets/background_widget.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:ambient/models/state_models.dart'; // Import your state models

class Roofline extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RooflineState();
  }
}

class _RooflineState extends State<Roofline> {
  String selectedOption = 'Type of IC Setting';
  bool isOpen = true;

  // These are the options for the dropdown menu
  final List<String> events = [
    'Accent Lighting',
    'New Years',
    'Valentines Day',
    'St. Patrick’s Day',
    'Easter',
    'America',
    'Halloween',
    'Thanksgiving',
    'Christmas Spectacular',
    'Sports Teams',
    'My Scenes',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.all(16.0), // Add padding to the entire content
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
                          'No Area is Selected'; // Default title if no area is active
                    } else {
                      final titles = activeAreas
                          .take(2)
                          .map((area) => area.title)
                          .toList();
                      if (activeAreas.length > 2) {
                        titles.add('...'); // Add ellipsis for additional areas
                      }
                      titleText = titles.join(', ');
                    }

                    return AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      //   toolbarHeight: 80, // Increase height for the AppBar
                      flexibleSpace: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        margin: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.transparent, // Transparent background
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          border: const Border(
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
                              child: Center(
                                child: Text(
                                  titleText,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      centerTitle: true,
                    );
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        events.length, // Use the length of the events list
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChristmasSpectacular(
                                  selectedEvent: events[index]),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: 370,
                          height: 45,
                          decoration: BoxDecoration(
                            color: const Color(0x40000000),
                            borderRadius: BorderRadius.circular(15),
                            border: const Border(
                              bottom: BorderSide(
                                color: Colors.grey, // Bottom border color
                                width: 0.5, // Bottom border thickness
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  events[
                                      index], // Use events[index] to access the actual item
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
