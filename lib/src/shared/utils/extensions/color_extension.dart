import 'package:flutter/cupertino.dart';

/// Color extension
extension ColorExtension on Color {
  /// Return the lighetened version of the color by a defined [amount].
  ///
  /// [amount] must be a value greather than 0 and less than 1.
  Color lighten(double amount) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLightened = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLightened.toColor();
  }
}
