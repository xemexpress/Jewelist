import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jewelist/src/constants/constants.dart';
import 'package:jewelist/src/core/core.dart';
import 'package:jewelist/src/models/models.dart';

final itemAPIProvider = Provider(
  (ref) => ItemAPI(
    checklist: Hive.box(AppConstants.checklistBoxName),
  ),
);

abstract class IItemAPI {
  List<ItemDocument> getAllItems();
  ItemDocument createItem(Item item);
  ItemDocument? updateItem(Item item);
  void deleteItem(Item item);
  void updateDatabase(List<ItemDocument> checklist);
}

class ItemAPI implements IItemAPI {
  final Box _checklistBox;

  ItemAPI({
    required Box checklist,
  }) : _checklistBox = checklist;

  @override
  ItemDocument createItem(Item item) {
    final mainCheckList = getAllItems();

    mainCheckList.add(
      item.toMap(),
    );

    updateDatabase(mainCheckList);

    return item.toMap();
  }

  @override
  void deleteItem(Item item) {
    final mainCheckList = getAllItems();
    final itemToBeDeleted = item.toMap();

    mainCheckList.removeWhere(
      (targetItem) => targetItem['id'] == itemToBeDeleted['id'],
    );

    updateDatabase(mainCheckList);
  }

  @override
  List<ItemDocument> getAllItems() {
    final List items = (_checklistBox.get(AppConstants.mainChecklist) ?? []);

    final List<ItemDocument> mappedItems =
        items.whereType<ItemDocument>().toList();

    return mappedItems;
  }

  @override
  ItemDocument? updateItem(Item itemToBeUpdated) {
    final mainCheckList = getAllItems();

    for (int i = 0; i < mainCheckList.length; i++) {
      final item = mainCheckList[i];

      if (item['id'] == itemToBeUpdated.id) {
        mainCheckList[i] = itemToBeUpdated.toMap();

        return mainCheckList[i];
      }
    }

    updateDatabase(mainCheckList);

    return null;
  }

  @override
  void updateDatabase(List<ItemDocument> checklist) {
    _checklistBox.put(AppConstants.mainChecklist, checklist);
  }
}
