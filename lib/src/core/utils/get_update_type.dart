import 'package:jewelist/src/core/core.dart';
import 'package:jewelist/src/models/models.dart';

ItemUpdateType getUpdateType(Item originalItem, Item newItem) {
  if (originalItem.description != newItem.description ||
      originalItem.quantity != newItem.quantity ||
      originalItem.title != newItem.title) {
    return ItemUpdateType.update;
  } else if (originalItem.isChecked && !originalItem.isChecked) {
    return ItemUpdateType.uncheck;
  } else if (!originalItem.isChecked && originalItem.isChecked) {
    return ItemUpdateType.check;
  } else {
    return ItemUpdateType.unchanged;
  }
}
