import 'package:flutter/material.dart';

// class ThemeModeNotifier extends ValueNotifier<Brightness> {
//   ThemeModeNotifier({
//     required appBrightness,
//   }) : super(appBrightness);

//   void changeAppBrightness({required Brightness brightness}) {
//     value = brightness;
//   }
// }

class ThemeModeNotifier {
  final ValueNotifier<Brightness> appBrightness;
  // ... other theme mode attributes

  ThemeModeNotifier({
    required this.appBrightness,
  });

  void changeAppBrightness({required Brightness brightness}) {
    appBrightness.value = brightness;
  }
}
