import 'package:jewelist/src/core/core.dart';
import 'package:jewelist/src/models/item.dart';

ItemDocument convertToItemDocument(element) {
  return Item.fromMap(element).toMap();
}
