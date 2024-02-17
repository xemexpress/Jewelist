enum ItemUpdateType {
  check('Item is checked'),
  uncheck('Item is unchecked'),
  update('Item is updated.'),
  unchanged('Item remains unchanged.');

  final String actionResult;
  const ItemUpdateType(this.actionResult);
}
