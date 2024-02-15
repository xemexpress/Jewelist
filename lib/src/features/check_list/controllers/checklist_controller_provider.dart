import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jewelist/src/apis/apis.dart';
import 'package:jewelist/src/features/check_list/controllers/controllers.dart';

final checklistControllerProvider =
    StateNotifierProvider<ChecklistController, ChecklistState>((ref) {
  return ChecklistController(
    itemAPI: ref.watch(itemAPIProvider),
  );
});
