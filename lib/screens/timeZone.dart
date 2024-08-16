import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:google_fonts/google_fonts.dart';

class TimezoneScreen extends StatefulWidget {
  const TimezoneScreen({super.key});

  @override
  State<TimezoneScreen> createState() => _TimezoneScreenState();
}

class _TimezoneScreenState extends State<TimezoneScreen> {
  String? selectedTimezone;
  String? selectedLocation;
  List<String> timezones = [];
  Map<String, List<String>> locationsMap = {};
  List<String> locations = [];
  String? currentTime;

  @override
  void initState() {
    super.initState();
    tz_data.initializeTimeZones();
    _fetchTimezones();
  }

  Future<void> _fetchTimezones() async {
    final response = await http.get(
      Uri.parse('http://worldtimeapi.org/api/timezone'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        timezones = data
            .map((location) => location.toString().split('/').first)
            .toSet()
            .toList();
        locationsMap = {};
        for (var timezone in data) {
          var parts = timezone.toString().split('/');
          if (parts.length > 1) {
            var region = parts.first;
            var location = parts.last;
            if (!locationsMap.containsKey(region)) {
              locationsMap[region] = [];
            }
            locationsMap[region]!.add(location);
          }
        }
      });
    } else {
      throw Exception('Failed to load timezones');
    }
  }

  Future<void> _fetchLocations(String timezone) async {
    setState(() {
      locations = locationsMap[timezone] ?? [];
    });
  }

  Future<void> _fetchCurrentTime(String location) async {
    final response = await http.get(
      Uri.parse('http://worldtimeapi.org/api/timezone/$location'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        currentTime = data['datetime'];
      });
    } else {
      throw Exception('Failed to load current time');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg', // Replace with your image asset
              fit: BoxFit.cover,
            ),
          ),
          // SafeArea to prevent UI elements from overlapping with system UI
          SafeArea(
            child: Column(
              children: [
                // AppBar with custom container for title and leading icon
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: 80, // Increase height for the AppBar
                  flexibleSpace: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.0), // Same color as dropdowns
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
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const Icon(
                          Icons.alarm,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            'Time Zone and Location',
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
                ),
                // Body content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.25,
                                blurRadius: 0.25,
                                offset: Offset(0.2, 2),
                              ),
                            ],
                          ),
                          child: _buildCustomDropdownButton(
                            value: selectedTimezone,
                            hint: 'Time Zone',
                            items: timezones,
                            onChanged: (newValue) {
                              setState(() {
                                selectedTimezone = newValue;
                                selectedLocation = null;
                                locations = [];
                                currentTime = null;
                              });
                              if (newValue != null) {
                                _fetchLocations(newValue);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.25,
                                blurRadius: 0.25,
                                offset: Offset(0.2, 2),
                              ),
                            ],
                          ),
                          child: _buildCustomDropdownButton(
                            value: selectedLocation,
                            hint: 'Location',
                            items: locations,
                            onChanged: (newValue) {
                              setState(() {
                                selectedLocation = newValue;
                                currentTime = null;
                              });
                              if (newValue != null) {
                                _fetchCurrentTime(
                                    '$selectedTimezone/$newValue');
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (currentTime != null)
                          Text(
                            'Current Time: $currentTime',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
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
        ],
      ),
    );
  }

  Widget _buildCustomDropdownButton({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: value,
          hint: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              hint,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          style: GoogleFonts.montserrat(
            color: Colors.white,
          ),
          isExpanded: true,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: Colors.black.withOpacity(0.8),
          alignment: Alignment.bottomLeft,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            filled: true,
            fillColor: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
