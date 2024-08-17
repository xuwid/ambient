import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui'; // Import dart:ui to use ImageFilter
import 'package:ambient/screens/add_controller_screen.dart'; // Import the Add Controller Screen
import 'package:ambient/screens/SelectCotroller.dart'; // Import the Select Controller Screen
import 'package:ambient/widgets/menu_buttons.dart'; // Import your custom buttons
import 'package:ambient/widgets/area_widget.dart'; // Import the RoofLineWidget
import 'package:ambient/widgets/controller_widget.dart'; // Import the ControllerWidget
import 'package:ambient/models/state_models.dart'; // Import the models
import 'package:provider/provider.dart'; // Import state management

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeState = Provider.of<HomeState>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Content overlay
          Column(
            children: [
              Container(
                color: Colors.transparent,
                child: AppBar(
                  title: Text(
                    'Home',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _showBottomSheetMenu(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    // Areas section
                    Text(
                      'Areas',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildAreaList(homeState),
                    const SizedBox(height: 32),
                    // Controllers section
                    Text(
                      'Controllers',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildControllerList(homeState),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            // Blur effect for the entire screen
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            // Menu content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                      255, 54, 51, 51), // Set background color to grey
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AddNewAreaButton(onPressed: () {
                      // Navigate to Select Controller Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectControllerScreen(),
                        ),
                      );
                    }),
                    AddNewControllerButton(onPressed: () {
                      // Navigate to Add Controller Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddControllerScreen(),
                        ),
                      );
                    }),
                    const Divider(
                        color: Colors.white), // Divider between options
                    CancelButton(onPressed: () {
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAreaList(HomeState homeState) {
    return Column(
      children: homeState.areas.asMap().entries.map((entry) {
        int index = entry.key;
        Area area = entry.value;
        return RoofLineWidget(
          title: area.title,
          isActive:
              area.controller.isActive, // Check if the controller is active
          onToggle: (value) {
            homeState.toggleArea(index, value);
          },
          index: index, // Pass index to determine background image
        );
      }).toList(),
    );
  }

  Widget _buildControllerList(HomeState homeState) {
    return Column(
      children: homeState.controllers.asMap().entries.map((entry) {
        int index = entry.key;
        Controller controller = entry.value;
        return ControllerWidget(
          title: controller.name,
          isActive: controller.isActive, // Display the active state
          onToggle: (value) {
            homeState.toggleControllerByIndex(index, value);
          },
          index: index, // Pass index to determine background image
        );
      }).toList(),
    );
  }
}
