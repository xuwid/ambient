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
  late String title;
  List<Controller> controller;
  List<Zone> zones;
  bool isActive;

  Area({
    required this.title,
    List<Controller>? controller,
    List<Zone>? zones,
    this.isActive = false,
  })  : controller = controller ?? [],
        zones = zones ?? [];
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
    Area(
        title: "Roofline",
        controller: [Controller("Main")],
        isActive: true,
        zones: [
          Zone(title: "Front", ports: []),
          Zone(title: "Back", ports: []),
        ]),
    Area(title: "Landscape Lights", controller: [Controller("Pool House")]),
  ];

  String? _selectedTimezone;
  String? _selectedLocation;

  String? get selectedTimezone => _selectedTimezone;
  String? get selectedLocation => _selectedLocation;

  void setSelectedTimezone(String? timezone) {
    _selectedTimezone = timezone;
    notifyListeners();
  }

  void setSelectedLocation(String? location) {
    _selectedLocation = location;
    notifyListeners();
  }

  List<Area> get areas => _areas;
  void addControllertoArea(Controller controller) {
    if (_currentArea != null) {
      _currentArea!.controller.add(controller);
      notifyListeners();
    }
  }

  void removeControllerfromArea(Controller controller) {
    if (_currentArea != null) {
      _currentArea!.controller.remove(controller);
      notifyListeners();
    }
  }

  // Create a new Area and assign it to _currentArea
  void createArea(String title,
      {List<Controller>? controller, List<Zone>? zones}) {
    _currentArea = Area(title: title, controller: controller, zones: zones);
    _areas.add(_currentArea!);
    if (controller != null) {
      print('Adding controllers to ${_currentArea!.title}');
      print('Controllers: ${controller.map((c) => c.name).toList()}');
    }
    notifyListeners();
  }

  void addTitletoArea(String title) {
    if (_currentArea != null) {
      _currentArea!.title = title;
    }
    notifyListeners();
  }

  // Add a Zone to the current Area
  void addZoneToCurrentArea(Zone zone) {
    if (_currentArea != null) {
      _currentArea!.zones.add(Zone(title: zone.title, ports: zone.ports));
      notifyListeners();
    }
  }

  // Toggle the active state of a Controller
  void toggleController(String name) {
    final controller = _controllers.firstWhere((c) => c.name == name);
    controller.isActive = !controller.isActive;
    notifyListeners();
  }

  // Toggle the active state of a Controller by index
  void toggleControllerByIndex(int index, bool isActive) {
    if (index >= 0 && index < _controllers.length) {
      _controllers[index].isActive = isActive;
      notifyListeners();
    }
  }

  // Toggle the active state of an Area by index
  void toggleArea(int index, bool isActive) {
    if (index >= 0 && index < _areas.length) {
      // Activate the selected area
      _areas[index].isActive = isActive;

      // Optionally update the isActive status of the Controller
      if (isActive) {
        _currentArea = _areas[index];
      } else {
        _currentArea = null;
      }

      notifyListeners();
    }
  }

  // Add a new Area with a list of Zones
  void addArea(String title,
      {List<Controller>? controller, List<Zone>? zones}) {
    _currentArea = Area(title: title, controller: controller, zones: zones);
    _areas.add(_currentArea!);
    notifyListeners();
  }

  void addControllersToCurrentArea(List<Controller> controllers) {
    if (_currentArea != null) {
      _currentArea!.controller.addAll(controllers);
      print('Adding controllers to ${_currentArea!.title}');
      print('Controllers: ${controllers.map((c) => c.name).toList()}');
      notifyListeners();
    }
    print('Current Area is null');
  }
}
