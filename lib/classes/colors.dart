import 'dart:ui';

class MyColors{
  static hexToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static colorToHexString(Color color) {
    return '#FF${color.value.toRadixString(16).substring(2, 8)}';
  }


}