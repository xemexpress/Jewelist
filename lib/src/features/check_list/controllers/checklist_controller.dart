import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jewelist/src/core/utils/get_update_type.dart';
import 'package:uuid/uuid.dart';

import 'package:jewelist/src/apis/apis.dart';
import 'package:jewelist/src/core/core.dart';
import 'package:jewelist/src/models/models.dart';

class ChecklistState {
  final List<Item> items;
  bool isLoading;

  ChecklistState({
    required this.items,
    required this.isLoading,
  });

  ChecklistState copyWith({
    List<Item>? items,
    bool? isLoading,
  }) {
    return ChecklistState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChecklistController extends StateNotifier<ChecklistState> {
  final ItemAPI _itemAPI;

  ChecklistController({required ItemAPI itemAPI})
      : _itemAPI = itemAPI,
        super(ChecklistState(
          items: itemAPI.getAllItems().map((e) => Item.fromMap(e)).toList(),
          isLoading: false,
        ));

  void startLoading() {
    state = state.copyWith(isLoading: true);
  }

  void endLoading() {
    state = state.copyWith(isLoading: false);
  }

  List<Item> getItems() {
    startLoading();

    final items = _itemAPI.getAllItems().map((e) => Item.fromMap(e)).toList();

    endLoading();
    state = state.copyWith(items: items);

    return items;
  }

  void createItem({
    required String title,
    required int quantity,
    required String description,
    required BuildContext context,
  }) {
    try {
      startLoading();
      final item = Item(
        id: const Uuid().v4(),
        title: title,
        quantity: quantity,
        isChecked: false,
        description: description,
      );

      _itemAPI.createItem(item);
      endLoading();

      final newChecklist = [...state.items, item];
      state = state.copyWith(items: newChecklist);

      showSnackBar(
        context: context,
        message: 'Saved ${item.title} x ${item.quantityString}.',
      );
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'Unexpected error when updating item. ${e.toString()}',
        dismissText: 'Gotcha!',
      );
    }
  }

  void updateItem(Item item, BuildContext context) {
    try {
      ItemUpdateType updateType;
      startLoading();
      final updatedItemDocument = _itemAPI.updateItem(item);
      endLoading();

      if (updatedItemDocument != null) {
        final updatedItem = Item.fromMap(updatedItemDocument);

        final checklist = state.items;
        for (var i = 0; i < checklist.length; i++) {
          if (checklist[i].id == updatedItem.id) {
            updateType = getUpdateType(checklist[i], updatedItem);

            checklist[i] = updatedItem;
            state = state.copyWith(items: checklist);

            switch (updateType) {
              case ItemUpdateType.update:
                showSnackBar(
                  context: context,
                  message: updateType.actionResult,
                );

                break;
              default:
                continue;
            }
            break;
          }
        }
      } else {
        showSnackBar(
          context: context,
          message: 'Failed to update item',
        );
      }
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'Unexpected error when updating item. ${e.toString()}',
        dismissText: 'Gotcha!',
      );
    }
  }

  void deleteItem(Item item, BuildContext context) {
    try {
      startLoading();
      _itemAPI.deleteItem(item);
      endLoading();

      final updatedItems = state.items.where((e) => e.id != item.id).toList();
      state = state.copyWith(items: updatedItems);
      showSnackBar(
        context: context,
        message: 'Deleted ${item.title} x ${item.quantityString}',
      );
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'Unexpected error when deleting item. ${e.toString()}',
        dismissText: 'Gotcha!',
      );
    }
  }
}
