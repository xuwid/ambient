import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ambient/models/state_models.dart';
import 'package:ambient/widgets/zone_menu.dart'; // Import the new widget
import 'package:ambient/widgets/background_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ZoneScreen extends StatefulWidget {
  const ZoneScreen({super.key});

  @override
  _ZoneScreenState createState() => _ZoneScreenState();
}

class _ZoneScreenState extends State<ZoneScreen> {
  Map<int, ZoneMenuData> zoneMenus = {
    0: ZoneMenuData(), // Initialize with one ZoneMenuData
  };

  void addNewZoneMenu() {
    setState(() {
      final newIndex = zoneMenus.keys.isNotEmpty
          ? zoneMenus.keys.reduce((a, b) => a > b ? a : b) + 1
          : 0;
      zoneMenus[newIndex] = ZoneMenuData();
    });
  }

  void toggleZoneMenu(int index) {
    setState(() {
      zoneMenus[index]?.isZoneMenuVisible =
          !(zoneMenus[index]?.isZoneMenuVisible ?? false);
    });
  }

  void changeZoneName(int index, String newName) {
    setState(() {
      zoneMenus[index]?.zoneName = newName;
      //zoneMenus[index]?.isZoneMenuVisible =
      //   false; // Hide the menu after name change
    });
  }

  void onStartingLightValueChanged(int menuIndex, int portIndex, int newValue) {
    setState(() {
      zoneMenus[menuIndex]?.startingLightValues[portIndex] = newValue;
    });
  }

  void onEndingLightValueChanged(int menuIndex, int portIndex, int newValue) {
    setState(() {
      zoneMenus[menuIndex]?.endingLightValues[portIndex] = newValue;
    });
  }

  void onPortSelectionChanged(int menuIndex, int portIndex, bool? value) {
    setState(() {
      zoneMenus[menuIndex]?.portSelections[portIndex] = value ?? false;
    });
  }

  void saveZone(BuildContext context, int index) {
    final homeState = Provider.of<HomeState>(context, listen: false);
    final area = homeState.currentArea;

    final zoneMenu = zoneMenus[index];
    if (zoneMenu?.zoneName.isNotEmpty ?? false) {
      // Create a new Zone object
      final newZone = Zone(
        title: zoneMenu?.zoneName ?? '',
        ports: List.generate(4, (portIndex) {
          if (zoneMenu?.portSelections[portIndex] ?? false) {
            return Port(
              startingValue: zoneMenu?.startingLightValues[portIndex] ?? 0,
              endingValue: zoneMenu?.endingLightValues[portIndex] ?? 0,
            );
          } else {
            return null;
          }
        }).whereType<Port>().toList(), // Ensure to filter out null values
      );

      // Add the new zone to the current area
      if (area != null) {
        homeState.addZoneToCurrentArea(newZone);
        print('Adding zone: ${newZone.title}');
      }

      // Add a new ZoneMenuData if this was the last one
      if (index == zoneMenus.keys.reduce((a, b) => a > b ? a : b)) {
        setState(() {
          addNewZoneMenu(); // Add a new zone menu
          zoneMenus[index]?.isZoneMenuVisible = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeState = Provider.of<HomeState>(context);
    final area = homeState.currentArea;

    final buttonWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                const SizedBox(height: 60),
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 66, 64, 64)
                          .withOpacity(0.9),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  title: Text(
                    area?.title ?? 'Zone Configuration',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                ),
                const SizedBox(height: 20),
                ...zoneMenus.entries.map((entry) {
                  final index = entry.key;
                  final zoneMenu = entry.value;
                  return Column(
                    children: [
                      ZoneMenu(
                        isZoneMenuVisible: zoneMenu.isZoneMenuVisible,
                        zoneName: zoneMenu.zoneName,
                        buttonWidth: buttonWidth,
                        portSelections: zoneMenu.portSelections,
                        startingLightValues: zoneMenu.startingLightValues,
                        endingLightValues: zoneMenu.endingLightValues,
                        changeZoneName: (newName) =>
                            changeZoneName(index, newName),
                        onStartingLightValueChanged: (portIndex, newValue) =>
                            onStartingLightValueChanged(
                                index, portIndex, newValue),
                        onEndingLightValueChanged: (portIndex, newValue) =>
                            onEndingLightValueChanged(
                                index, portIndex, newValue),
                        onPortSelectionChanged: (portIndex, value) =>
                            onPortSelectionChanged(index, portIndex, value),
                        onMenuToggle: () =>
                            toggleZoneMenu(index), // Pass the callback here
                        onSaveZone: () =>
                            saveZone(context, index), // Save specific zone
                      ),
                      const SizedBox(
                          height: 20), // Add spacing between ZoneMenus
                    ],
                  );
                }).toList(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/homeTab',
                    (route) => false, // Remove all previous routes
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Adjust color as needed
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Add Area',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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

class ZoneMenuData {
  bool isZoneMenuVisible = false;
  String zoneName = "Add Zone";
  List<bool> portSelections = [false, false, false, false];
  List<int> startingLightValues = [1, 1, 1, 1]; // Initial values for each port
  List<int> endingLightValues = [
    12,
    12,
    12,
    12
  ]; // Initial values for each port
}
