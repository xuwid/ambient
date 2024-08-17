import 'package:flutter/foundation.dart';

class Port {
  int startingValue;
  int endingValue;

  Port({this.startingValue = 1, this.endingValue = 12});
}

class Zone {
  final String title;
  final List<Port> ports;

  Zone({
    required this.title,
    List<Port>? ports,
  }) : ports = ports ?? List.generate(4, (_) => Port());
}

class Controller {
  final String name;
  bool isActive;

  Controller(this.name, {this.isActive = false});
}

class Area {
  final String title;
  final Controller controller;
  final List<Zone> zones;

  // Make the title a required parameter, and controller and zones optional
  Area({
    required this.title,
    Controller? controller,
    List<Zone>? zones,
  })  : controller = controller ?? Controller("Default Controller"),
        zones = zones ?? [Zone(title: "Default Zone")];
}

class HomeState with ChangeNotifier {
  List<Controller> _controllers = [
    Controller("Main"),
    Controller("Pool House"),
  ];

  List<Controller> get controllers => _controllers;

  Area? _currentArea;

  Area? get currentArea => _currentArea;

  List<Area> _areas = [
    Area(title: "Roofline", controller: Controller("Main")),
    Area(title: "Landscape Lights", controller: Controller("Pool House")),
  ];

  List<Area> get areas => _areas;

  // Create a new Area and assign it to _currentArea
  void createArea(String title, {Controller? controller, List<Zone>? zones}) {
    _currentArea = Area(title: title, controller: controller, zones: zones);
    _areas.add(_currentArea!);
    notifyListeners();
  }

  // Add a Zone to the current Area
  void addZoneToCurrentArea(Zone zone) {
    _currentArea?.zones.add(Zone(title: zone.title, ports: zone.ports));
    notifyListeners();
  }

  // Toggle the active state of a Controller
  void toggleController(String name) {
    final controller = _controllers.firstWhere((c) => c.name == name);
    controller.isActive = !controller.isActive;
    notifyListeners();
  }

  // Toggle the active state of a Controller by index
  void toggleControllerByIndex(int index, bool isActive) {
    _controllers[index].isActive = isActive;
    notifyListeners();
  }

  // Toggle the active state of an Area by index
  void toggleArea(int index, bool isActive) {
    _areas[index].controller.isActive = isActive;
    notifyListeners();
  }

  // Add a new Area with a list of Zones
  void addArea(String title, {Controller? controller, List<Zone>? zones}) {
    _currentArea = Area(title: title, controller: controller, zones: zones);
    _areas.add(_currentArea!);
    notifyListeners();
  }
}
