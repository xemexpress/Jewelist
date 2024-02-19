String resizeCloudinaryImage(
  String url, {
  int width = 100,
  int height = 100,
  String action = 'c_fit',
}) {
  String result = '';
  List<String> parts = url.split('/');

  for (final part in parts) {
    if (part == parts.last) {
      result += part;
    } else {
      if (part == 'upload') {
        result += '$part/w_$width,h_$height,$action/';
      } else {
        result += '$part/';
      }
    }
  }

  return result;
}
