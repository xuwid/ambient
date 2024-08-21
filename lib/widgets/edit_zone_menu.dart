import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'starting_light_widget.dart'; // Ensure this import is correct

class EditZoneMenu extends StatefulWidget {
  final bool isEditMenuVisible;
  final String zoneName;
  final double buttonWidth;
  final List<bool> portSelections;
  final List<int> startingLightValues;
  final List<int> endingLightValues;
  final Function(String) changeZoneName;
  final Function(int, int) onStartingLightValueChanged;
  final Function(int, int) onEndingLightValueChanged;
  final Function(int, bool?) onPortSelectionChanged;
  final VoidCallback onMenuToggle;
  final VoidCallback onSaveZone;

  const EditZoneMenu({
    Key? key,
    required this.isEditMenuVisible,
    required this.zoneName,
    required this.buttonWidth,
    required this.portSelections,
    required this.startingLightValues,
    required this.endingLightValues,
    required this.changeZoneName,
    required this.onStartingLightValueChanged,
    required this.onEndingLightValueChanged,
    required this.onPortSelectionChanged,
    required this.onMenuToggle,
    required this.onSaveZone,
  }) : super(key: key);

  @override
  _EditZoneMenuState createState() => _EditZoneMenuState();
}

class _EditZoneMenuState extends State<EditZoneMenu> {
  late TextEditingController zoneNameController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    zoneNameController = TextEditingController(text: widget.zoneName);
  }

  @override
  void dispose() {
    zoneNameController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onZoneNameChanged(String newName) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.changeZoneName(newName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: widget.buttonWidth,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[850]!.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                minimumSize: const Size(250, 50),
              ),
              onPressed: widget.onMenuToggle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.zoneName,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.isEditMenuVisible)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: widget.buttonWidth,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[850]!.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: zoneNameController,
                    onChanged: _onZoneNameChanged,
                    style: GoogleFonts.montserrat(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Zone Name",
                      hintStyle: GoogleFonts.montserrat(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ports',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: List.generate(4, (index) {
                            return Row(
                              children: [
                                Text(
                                  '${index + 1}',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Checkbox(
                                  value: index < widget.portSelections.length
                                      ? widget.portSelections[index]
                                      : false,
                                  onChanged: (bool? value) {
                                    widget.onPortSelectionChanged(index, value);
                                  },
                                  checkColor: Colors.white,
                                  activeColor: Colors.blue,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: List.generate(4, (index) {
                      if (index < widget.portSelections.length &&
                          widget.portSelections[index]) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StartingLightWidget(
                              title: "Starting Light ${index + 1}",
                              initialValue:
                                  index < widget.startingLightValues.length
                                      ? widget.startingLightValues[index]
                                      : 0,
                              onValueChanged: (newValue) => widget
                                  .onStartingLightValueChanged(index, newValue),
                            ),
                            const SizedBox(height: 10),
                            StartingLightWidget(
                              title: "Ending Light ${index + 1}",
                              initialValue:
                                  index < widget.endingLightValues.length
                                      ? widget.endingLightValues[index]
                                      : 0,
                              onValueChanged: (newValue) => widget
                                  .onEndingLightValueChanged(index, newValue),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: widget.onSaveZone,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.white),
                        ),
                      ),
                      child: Text(
                        'Save Changes',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
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
    );
  }
}
