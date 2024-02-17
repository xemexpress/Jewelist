import 'package:flutter/material.dart';
import 'package:jewelist/src/features/check_list/views/home_screen.dart';
import 'package:jewelist/src/themes/themes.dart';

class JewelistApp extends StatefulWidget {
  const JewelistApp({super.key});

  @override
  State<JewelistApp> createState() => _JewelistAppState();
}

class _JewelistAppState extends State<JewelistApp> with WidgetsBindingObserver {
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
        title: 'Jewelist | Packing for Shows',
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
