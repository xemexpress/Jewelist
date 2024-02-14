import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jewelist/src/constants/app_constants.dart';
import 'package:jewelist/src/features/check_list/views/home_screen.dart';
import 'package:jewelist/src/themes/themes.dart';

void main() {
  Hive.initFlutter();

  Hive.openBox(AppConstants.checklistBoxName);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late final WidgetsBinding _widgetsBinding;
  late final ThemeModeNotifier _themeModeNotifier;

  @override
  void initState() {
    _widgetsBinding = WidgetsBinding.instance;
    _widgetsBinding.addObserver(this);

    _themeModeNotifier = ThemeModeNotifier(
      appBrightness: ValueNotifier(
        _widgetsBinding.platformDispatcher.platformBrightness,
      ),
    );

    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    _themeModeNotifier.changeAppBrightness(
      brightness: _widgetsBinding.platformDispatcher.platformBrightness,
    );

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _themeModeNotifier.appBrightness,
      builder: (context, brightness, child) => MaterialApp(
        title: 'Jewelist | Jeweler\'s List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: brightness,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
