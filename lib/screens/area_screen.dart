import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ambient/models/state_models.dart';
import 'package:ambient/widgets/edit_zone_menu.dart'; // Import the EditZone widget
import 'package:google_fonts/google_fonts.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/background.png', // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}

class AreaScreen extends StatefulWidget {
  const AreaScreen({super.key});

  @override
  _AreaScreenState createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  Map<int, ZoneMenuData> zoneMenus = {};

  @override
  void initState() {
    super.initState();
    _initializeZoneMenus();
  }

  void _initializeZoneMenus() {
    final homeState = Provider.of<HomeState>(context, listen: false);
    final areas = homeState.areas; // Assuming you have a list of all areas

    setState(() {
      zoneMenus.clear(); // Clear previous zones
      for (var area in areas) {
        if (area.isActive) {
          for (int i = 0; i < area.zones.length; i++) {
            zoneMenus[zoneMenus.length] = ZoneMenuData.fromZone(area.zones[i]);
          }
        }
      }
    });
  }

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

    final zoneMenu = zoneMenus[index];
    if (zoneMenu?.zoneName.isNotEmpty ?? false) {
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
        }).whereType<Port>().toList(),
      );

      // homeState.addZone(newZone); // Add the new zone to the list of zones for the appropriate area

      if (index == zoneMenus.keys.reduce((a, b) => a > b ? a : b)) {
        setState(() {
          addNewZoneMenu();
          zoneMenus[index]?.isZoneMenuVisible = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeState = Provider.of<HomeState>(context);
    final areas = homeState.areas; // Assuming you have a list of all areas

    // If no active areas, show a message or handle it accordingly
    if (areas.isEmpty || !areas.any((area) => area.isActive)) {
      return Scaffold(
        body: BackgroundWidget(
          child: Center(
            child: Text(
              'No active areas available.',
              style: GoogleFonts.montserrat(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      );
    }

    final buttonWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      body: BackgroundWidget(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // AppBar with the same background image as the body
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 80, // Increase height for the AppBar
              flexibleSpace: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                margin: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
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
                          color: Colors
                              .white), // Change icon color to black for better contrast
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Icon(
                      Icons.gamepad,
                      color: Colors
                          .white, // Change icon color to black for better contrast
                      size: 30,
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        'Zone Setup',
                        style: GoogleFonts.montserrat(
                          color: Colors
                              .white, // Change text color to black for better contrast
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ...zoneMenus.entries.map((entry) {
                        final index = entry.key;
                        final zoneMenu = entry.value;
                        return Column(
                          children: [
                            EditZoneMenu(
                              //isZoneMenuVisible: zoneMenu.isZoneMenuVisible,
                              isEditMenuVisible: zoneMenu.isZoneMenuVisible,
                              zoneName: zoneMenu.zoneName,
                              buttonWidth: buttonWidth,
                              portSelections: zoneMenu.portSelections,
                              startingLightValues: zoneMenu.startingLightValues,
                              endingLightValues: zoneMenu.endingLightValues,
                              changeZoneName: (newName) =>
                                  changeZoneName(index, newName),
                              onStartingLightValueChanged:
                                  (portIndex, newValue) =>
                                      onStartingLightValueChanged(
                                          index, portIndex, newValue),
                              onEndingLightValueChanged:
                                  (portIndex, newValue) =>
                                      onEndingLightValueChanged(
                                          index, portIndex, newValue),
                              onPortSelectionChanged: (portIndex, value) =>
                                  onPortSelectionChanged(
                                      index, portIndex, value),
                              onMenuToggle: () => toggleZoneMenu(index),
                              onSaveZone: () => saveZone(context, index),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ZoneMenuData {
  bool isZoneMenuVisible = false;
  String zoneName = "Add Zone";
  List<bool> portSelections = [false, false, false, false];
  List<int> startingLightValues = [1, 1, 1, 1];
  List<int> endingLightValues = [12, 12, 12, 12];

  ZoneMenuData();

  ZoneMenuData.fromZone(Zone zone)
      : isZoneMenuVisible = false,
        zoneName = zone.title,
        portSelections = List.generate(zone.ports.length, (i) => true),
        startingLightValues = zone.ports.map((p) => p.startingValue).toList(),
        endingLightValues = zone.ports.map((p) => p.endingValue).toList();
}
