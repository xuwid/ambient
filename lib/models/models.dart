import 'package:flutter/foundation.dart';

class Area {
  final String name;
  bool isActive;

  Area({required this.name, this.isActive = false});
}

class Controller {
  final String name;
  bool isActive;

  Controller({required this.name, this.isActive = false});
}

class HomeState with ChangeNotifier {
  List<Area> _areas = [
    Area(name: 'Roofline'),
    Area(name: 'LandscapeLights'),
  ];

  List<Controller> _controllers = [
    Controller(name: 'Main'),
    Controller(name: 'Pool house'),
  ];

  List<Area> get areas => _areas;
  List<Controller> get controllers => _controllers;

  void toggleArea(int index, bool isActive) {
    _areas[index].isActive = isActive;
    notifyListeners();
  }

  void toggleController(int index, bool isActive) {
    _controllers[index].isActive = isActive;
    notifyListeners();
  }
}
