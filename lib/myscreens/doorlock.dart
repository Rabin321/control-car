import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  int selectedBotTab = 0;
  void onBottomNavTabChange(int index) {
    selectedBotTab = index;
    notifyListeners();
  }

  bool isRightDoorLock = true;
  bool isRightBackDoorLock = true;

  bool isLeftDoorLock = true;
  bool isLeftBackDoorLock = true;

  bool isFrontDoorLock = true;
  bool isBackDoorLock = true;

  // bool isMainLock = true;

  void updateRightDoor() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoor() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateFrontDoor() {
    isFrontDoorLock = !isFrontDoorLock;
    notifyListeners();
  }

  void updateLeftBackDoor() {
    isLeftBackDoorLock = !isLeftBackDoorLock;
    notifyListeners();
  }

  void updateRightBackDoor() {
    isRightBackDoorLock = !isRightBackDoorLock;
    notifyListeners();
  }

  void updateBackDoor() {
    isBackDoorLock = !isBackDoorLock;
    notifyListeners();
  }
//mainlock.
//left....
  // void updateMainlock() {
  //   isMainLock = !isMainLock;
  //   notifyListeners();
  // }
}
