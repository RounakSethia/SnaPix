import 'package:flutter/material.dart';

//Just being used for dark and light mode
bool themesSwitch = false;
  dynamic themeColors() {
    if (themesSwitch) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }