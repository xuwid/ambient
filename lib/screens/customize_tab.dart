import 'package:ambient/widgets/color_picker.dart';
import 'package:ambient/widgets/starting_light_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:ambient/models/state_models.dart'; // Import your state models

class CustomizeTab extends StatefulWidget {
  const CustomizeTab({super.key});

  @override
  _CustomizeTabState createState() => _CustomizeTabState();
}

class _CustomizeTabState extends State<CustomizeTab> {
  int _selectedLedIndex = 0; // Track the currently selected LED index
  final List<Color> _ledColors =
      List<Color>.generate(12, (index) => Colors.green);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png', // Replace with your image asset
              fit: BoxFit.cover,
            ),
          ),
          // SafeArea to prevent UI elements from overlapping with system UI
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 15),
                // AppBar with dynamic title
                Consumer<HomeState>(
                  builder: (context, homeState, child) {
                    // Find the active areas
                    final activeAreas =
                        homeState.areas.where((area) => area.isActive).toList();

                    // Generate the title text based on active areas
                    String titleText;
                    if (activeAreas.isEmpty) {
                      titleText =
                          'Customize'; // Default title if no area is active
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
                      toolbarHeight: 80, // Increase height for the AppBar
                      flexibleSpace: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black
                              .withOpacity(0.0), // Transparent background
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
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                titleText,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
                // Zone Selector and Save Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          side: BorderSide(
                            color: const Color(0xFF8A2BE2)
                                .withOpacity(0.5)
                                .withBlue(
                                    200), // Border color mix of purple and blue
                            width: 2.0,
                          ),
                        ),
                        child: Text(
                          'Zone 1',
                          style: GoogleFonts.montserrat(
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Save action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Background color
                        ),
                        child: Text(
                          'Save',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // LED Preview (Scrollable)
                SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(12, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedLedIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: _ledColors[index],
                            shape: BoxShape.circle,
                            border: _selectedLedIndex == index
                                ? Border.all(
                                    color: Colors
                                        .white, // White border for selected LED
                                    width: 2.0,
                                  )
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                // Color Picker for the selected LED
                Expanded(
                  child: Center(
                    child: ColorPicker(
                      size: 225,
                      //     initialColor: _ledColors[_selectedLedIndex],
                      //   onColorChanged: (color) {
                      // setState(() {
                      //     _ledColors[_selectedLedIndex] = color;
                      // });
                      //},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
