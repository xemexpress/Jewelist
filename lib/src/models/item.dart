class Item {
  String id;
  String title;
  int quantity;
  bool isChecked;
  String description;

  Item({
    required this.id,
    required this.title,
    required this.quantity,
    required this.isChecked,
    required this.description,
  });

  String get quantityString => quantity == 0 ? "" : quantity.toString();

  Item copyWith({
    String? id,
    String? title,
    int? quantity,
    bool? isChecked,
    String? description,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      isChecked: isChecked ?? this.isChecked,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'quantity': quantity,
      'isChecked': isChecked,
      'description': description,
    };
  }

  factory Item.fromMap(map) {
    return Item(
      id: map['id'] as String,
      title: map['title'] as String,
      quantity: map['quantity'] as int,
      isChecked: map['isChecked'] as bool,
      description: map['description'] as String,
    );
  }

  @override
  String toString() {
    return 'Item(id: $id, title: $title, quantity: $quantity, isChecked: $isChecked, description: $description)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.quantity == quantity &&
        other.isChecked == isChecked &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        quantity.hashCode ^
        isChecked.hashCode ^
        description.hashCode;
  }
}
