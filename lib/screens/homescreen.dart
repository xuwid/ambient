import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ambient/screens/timeZone.dart';
import 'package:ambient/screens/SelectCotroller.dart';
import 'dart:ui'; // Import dart:ui to use ImageFilter
import 'package:ambient/widgets/menu_buttons.dart'; // Import your widgets
import 'package:ambient/widgets/bottom_navigation_bar.dart'; // Import the new widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track the selected tab
  bool _isMenuOpen = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigate to the respective screen based on the index
    // Example:
    // if (index == 1) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => ScenesScreen()));
    // }
  }

  void _openBottomMenu() {
    setState(() {
      _isMenuOpen = true;
    });

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
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
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
                      setState(() {
                        _isMenuOpen = false;
                      });
                    }),
                    AddNewControllerButton(onPressed: () {
                      // Handle Add New Controller action
                      setState(() {
                        _isMenuOpen = false;
                      });
                      Navigator.pop(context);
                    }),
                    const Divider(
                        color: Colors.white), // Divider between options
                    CancelButton(onPressed: () {
                      setState(() {
                        _isMenuOpen = false;
                      });
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ).whenComplete(() {
      setState(() {
        _isMenuOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        onPressed: _openBottomMenu,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TimezoneScreen()),
                          );
                        },
                        child: const Text('Go to Timezone Selector'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SelectControllerScreen()),
                          );
                        },
                        child: const Text('Go to Select Controller'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
