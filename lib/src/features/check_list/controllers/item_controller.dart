import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jewelist/src/apis/apis.dart';
import 'package:jewelist/src/models/models.dart';
import 'package:uuid/uuid.dart';

class ItemController extends StateNotifier<bool> {
  final ItemAPI _itemAPI;

  ItemController({required ItemAPI itemAPI})
      : _itemAPI = itemAPI,
        super(false);

  List<Item> getItems() {
    final items = _itemAPI
        .getAllItems()
        .map(
          (e) => Item.fromMap(e),
        )
        .toList();

    return items;
  }

  void createItem({
    required String title,
    required int quantity,
    required String description,
  }) {
    final item = Item(
      id: const Uuid().v4(),
      title: title,
      quantity: quantity,
      isChecked: false,
      description: description,
    );

    _itemAPI.createItem(item);
  }

  void deleteItem(Item item, BuildContext context) {
    _itemAPI.deleteItem(item);
  }
}
