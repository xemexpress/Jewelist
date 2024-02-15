import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jewelist/src/constants/app_constants.dart';
import 'package:jewelist/src/jewelist_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox(AppConstants.checklistBoxName);

  runApp(
    const ProviderScope(
      child: JewelistApp(),
    ),
  );
}
