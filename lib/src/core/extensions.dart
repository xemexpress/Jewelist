extension CapExtension on String {
  String get inCaps =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String get capitalizeFirstofEach =>
      split(' ').map((str) => str.inCaps).join(' ');
}
